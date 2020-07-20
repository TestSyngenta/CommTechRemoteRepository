global class BatchInsertOlis implements Database.Batchable<OpportunityLineItem>,database.stateful{

    global List<OpportunityLineItem> oliList;
    global List<OpportunityLineItem> oliListtoInsert;
    global Opportunity Opp;
    global Id globalOppId;
    List<Database.saveResult> resultList;

    private static datetime startTime = system.now();
    private static datetime endTime;    
    
    global BatchInsertOlis(Id oppId,List<OpportunityLineItem> oppLineList){ 
        globalOppId = oppId;
        oliList = oppLineList;
        oliListtoInsert = new List<OpportunityLineItem>();
    }

    global Iterable<OpportunityLineItem> start(Database.BatchableContext bc){
        
        if(globalOppId != null){
            //fetching th opportunity related to the OLi
            Opp = [select id,AccountId,IsBatchProcessing__c,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,territory__c,Name,
                    AccountBusinessPlan__r.Year__c,CommercialUnit__c,PriceBook2Id,Sales_Plan_Type__c,CountofOppProducts__c,Product_Type__c,
                    RecordType.DeveloperName, Year__c from Opportunity where id =: globalOppId LIMIT 1];
        }

        if(Opp != null){
            Opp.isBatchprocessing__c = true;
            update Opp;
        }

        if(oliList != null)//If there has already been a List of Line Items passed to the batch, return that itself
        {
            return oliList;
        }
        else{//query and return the Products to be inserted
            Set<Id> existingOLIProdIds = new Set<Id>();
            if(Opp.CountofOppProducts__c > 0){
                for(OpportunityLineItem oli: [Select Product2Id from OpportunityLineItem where OpportunityId = :Opp.Id])
                {
                   existingOLIProdIds.add(oli.Product2Id); 
                }
           	}
            return SalesPlanCreationHandler.getInsertOLIList(Opp, existingOLIProdIds, true, true);
            return null;
        }

    }

    global void execute(Database.BatchableContext BC, List<OpportunityLineItem> oppLineList){
        for(OpportunityLineItem oli:oppLineList)
        {
            oliListtoInsert.add(oli);
        }
        //inserting the OLi here.So that it is done in batches of 200
        if(!oliListtoInsert.isEmpty())
        {
            resultList= Database.insert(oliListtoInsert,false);
        }
	}

    global void finish(Database.BatchableContext BC) {
        if(!oliListtoInsert.isEmpty()){
            //List<Database.saveResult> resultList= Database.insert(oliListtoInsert,false);
            List<OpportunityLineItem> oliupdate=new List<OpportunityLineItem>();
            List<Exception_Log__c> exceptionList = new List<Exception_Log__c>();
            Exception_Log__c successLog;
            String successIds = '';
            for(Integer i = 0; i<oliListtoInsert.size(); i++){
                Database.saveResult sr = resultList[i];
                if(!sr.success) {
                    for(Database.Error err : sr.getErrors()) {
                        exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','BatchInsertOlis','finish','Technical Exception',userInfo.getUserId(),err.getStatusCode() + ': ' + err.getMessage()+err.getFields(),'',err.getMessage()));
                    }
                }
                else
                {
                    
                }
            }
            if(!exceptionList.isEmpty()){
                insert exceptionList;
            }
        }
        endtime = system.now();
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems FROM AsyncApexJob WHERE Id = :BC.getJobId()];
        if(a.status == 'Completed')
        {
          Insert ( ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem',a.id,'BatchInsertOlis','finish','Other',userInfo.getUserId(),'',String.valueof(starttime),String.valueof(endtime)));  
        }
    }
}