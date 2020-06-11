trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert,before update,after update,after insert) {
    
    //to create Opportunities,OLi's and SPA's
    if (trigger.isBefore && trigger.isInsert){
        // Ticket TKT-067977 IST Start: By Sravani
        SalesPlanCreationHandler.updatOLIwithKeys(trigger.new);
        // Stop TKT-067977
        /*UpdateOpportunitySeedsAllocationClass upopp=new UpdateOpportunitySeedsAllocationClass(); 
        upopp.seedsupdatebeforeInsert(trigger.new);  Commented because Seeds Allocation is not being used.*/
    }
    // Ticket TKT-067734 IST Start: By Sravani
    //To update the CY Planned Stocks on OLI
    if((trigger.isUpdate||trigger.isInsert) && trigger.isBefore && AvoidRecursion.isupdateplndstockfirstRun()){
           populateOLIHandler.populateCropProvision(trigger.new);
    }

    // Stop TKT-067734
    if((trigger.isUpdate||trigger.isInsert) && trigger.isBefore){
           BusinessPlanTriggerHandler.updateOLICYPlannedSales(trigger.new);
    }
    // To Update Seeds Sales Plan with allocated Units and to map SPA with OLis 
    if (trigger.isAfter && trigger.isInsert ){
        /*if(!System.isBatch() && !System.isFuture()){
        
        UpdateOpportunitySeedsAllocationClass upopp=new UpdateOpportunitySeedsAllocationClass(); 
        upopp.seedsinsertOpportunityLineItem(trigger.new);
        }  Commented because Seeds Allocation is not being used */
        SalesPlanCreationHandler.createCYSPA(trigger.new);
        List<Id> oliIds = new List<id>();
        for(OpportunityLineItem oli: trigger.new){
            oliIds.add(oli.Id);    
        }
        If(!oliIds.isEmpty())
            SalesPlanCreationHandler.updateOLIwithSPALookUp(oliIds);
    }    
    
    //to update the previous updated units fields on Seeds Allocation Sales Plan
    /*if (trigger.isBefore && trigger.isUpdate && AvoidRecursion.isUpdatePreviousUnitsFirstRun()){    //TKT-068988 - Added recursive check
        OpportunitySeedsAllocation allocate = new OpportunitySeedsAllocation();
        allocate.updatePreviousAllocations(trigger.oldMap,trigger.newMap);
    } Commented because Seed Allocations is not being used */
    if((trigger.isUpdate||trigger.isInsert) && trigger.isBefore){
        SalesPlanCreationHandler.defaultProductFields(trigger.new);   
    }
   // To Update Parent OLIs
    if(trigger.isUpdate && trigger.isAfter && AvoidRecursion.isbatchfirstRun()){
        // To execute rollup functionality
        set<Id> prodids=new set<Id>();
        try{
        Opportunity opp=[select id,RelHeadOfficePlan__c,RelatedDistributorPlan__c,RelatedCUPlan__c,RelatedTerritoryPlan__c,RecordType.developername from Opportunity where id=:Trigger.new[0].opportunityid];
        for(OpportunityLineItem oli:Trigger.new)
        {
            prodids.add(oli.Product2Id);
        }
        if(opp.RelHeadOfficePlan__c!=Null && !System.isBatch() && !System.isFuture())
        {
            RetailertoHeadOfficeNoBatch batch=new RetailertoHeadOfficeNoBatch(opp.RelHeadOfficePlan__c,prodids);
            batch.Start();
            /*
            RetailertoHeadOffice batch=new RetailertoHeadOffice(opp.RelHeadOfficePlan__c,prodids);
            Database.executeBatch(batch);
            */
        }
        else if(opp.RelatedDistributorPlan__c!=Null && !System.isBatch() && !System.isFuture())
        {
            RetailertoDistributorNoBatch disbatch=new RetailertoDistributorNoBatch(opp.RelatedDistributorPlan__c,prodids);
            
            disbatch.Start();
            /*Database.executeBatch(disbatch);*/
        }
        else if(opp.RelatedCUPlan__c!=Null && !System.isBatch() && !System.isFuture())
        {
            DistributortoCUPlanNoBatch cubatch=new DistributortoCUPlanNoBatch(opp.RelatedCUPlan__c,prodids);
            cubatch.Start();
            /*
            DistributortoCUPlan cubatch=new DistributortoCUPlan(opp.RelatedCUPlan__c,prodids);
            Database.executeBatch(cubatch);
            */
        } 
        /*
        Disabled Jan 8 2020 because Territory and District Plans are currently not in use
        if(opp.RelatedTerritoryPlan__c!=Null && !System.isBatch() && !System.isFuture())
        {
            Opportunity terrOpp=[select id,RecordType.developername from Opportunity where id=:opp.RelatedTerritoryPlan__c];
            if(terrOpp.RecordType.developername==Label.Territory_Sales_Plan || terrOpp.RecordType.developername == Label.Territory_Seeds_Sales_Plan)
            {
              RetailtoTerritory terrBatch = new RetailtoTerritory(terrOpp.id,prodids);
              Database.executeBatch(terrBatch);
            }
            else if(terrOpp.RecordType.developername == Label.District_Sales_Plan || terrOpp.RecordType.developername == Label.District_Seeds_Sales_Plan){
                    TerritorytoDistrict distBatch = new TerritorytoDistrict(terrOpp.id,prodids);
                    Database.executeBatch(distBatch);
            }   
            
        }*/
       }
       catch(Exception e)
       {
           Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','OpportunityLineItemTrigger Handler','callRollUpClasses','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
           insert exceptionLogRecord;
       } 
    }

    
    //to update the Seeds Alloaction sales plan if Seeds allocation is updated, commented because Seeds allocation is not being used.
    /*if(trigger.isAfter && trigger.isUpdate && AvoidRecursion.isFirstRun()){
        UpdateOpportunitySeedsAllocationClass upopp=new UpdateOpportunitySeedsAllocationClass(); 
        upopp.updateOpportunityLineItem(trigger.oldMap,trigger.new);
        upopp.seedsupdateOpportunityLineItem(trigger.oldMap,trigger.new);
    }*/
   
}