public with Sharing class populateOLIHandler{
    
    public Boolean errorExists {get;set;}
    public static Business_Plan__c BusinessPlan;
    public string OpportunityId {get;set;}
    public Opportunity Oppty {get;set;}
    public string rtName {get;set;}
    Public string BpId {get;set;}
    public string AccName {get;set;}
    public string Accid;
    public string oppName {get;set;}
    public string oppYear {get;set;}
    public string status {get;set;}
    public string relDistr {get;set;}
    public string territory {get;set;}
    public string district {get;set;}
    public string SalesOrg {get;set;}
    public string ParentAcc {get;set;}
    public string salesPlanType {get;set;}
    public Decimal oliCount {get;set;}
    public String accountRole {get;set;}
    public String owner {get;set;}
    public String productType{get;set;}
    public String cu {get;set;}
   public String tabValues {get;set;}
    
    
    //Controller to populate Opportunity related Businessplan,SPP and  Account Details
    public populateOLIHandler(ApexPages.StandardController Controller){
        try{
        errorExists = false;
        OpportunityId = controller.getId();
        System.Debug('OpportunityId is ' + OpportunityId);  
        if(OpportunityId!=null){
        List<opportunity> oppList = [select Id,AccountId,Related_Business_Plan_Locked__c,Account.Account_ID__c,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,Territory__c,Territory__r.District__r.Name,Territory__r.Name,Territory__r.Sales_Org_Description__c,Name, Owner.Name,Account_Territory__r.Parent_Account__r.Name,
                                     AccountBusinessPlan__r.Year__c,District__r.Name,CommercialUnit__c,PriceBook2Id,Product_Type__c,CountofOppProducts__c,RecordType.DeveloperName, Account_Territory__r.Parent_Account__c, year__c,RelatedDistributor__c, Sales_Plan_Type__c,IsBatchProcessing__c, RelHeadOfficePlan__c,RelatedDistributorPlan__c,
                                     RelatedCUPlan__c, RelatedTerritoryPlan__c from Opportunity where id =: OpportunityId];
        Oppty = oppList[0];
        System.debug('Opp Prod type '+Oppty.Product_Type__c);
        oppName = Oppty.Name;
        BPId = Oppty.AccountBusinessPlan__c;
        rtName = Oppty.RecordType.DeveloperName;
        System.debug('Opp record type '+ rtName);
        //BusinessPlan = new Business_Plan__c();
        //BusinessPlan.year__c = oppty.AccountBusinessPlan__r.Year__c;
        Accid = Oppty.AccountId;
        oppYear = Oppty.AccountBusinessPlan__r.Year__c;
        relDistr = Oppty.RelatedDistributor__c;
        territory = Oppty.Territory__r.Name;
        if(rtName==Label.Territory_Sales_Plan || rtName == Label.Territory_Seeds_Sales_Plan){
            if(Oppty.Territory__r.District__r.Name!=null){
                district = Oppty.Territory__r.District__r.Name; 
            }
        }
        if((rtName == Label.District_Sales_Plan || rtName == Label.District_Seeds_Sales_Plan) && Oppty.District__r.Name != null){
            district = Oppty.District__r.Name;
        }
        
        salesOrg = oppty.Territory__r.Sales_Org_Description__c;
        salesPlanType = oppty.Sales_Plan_Type__c;
        parentAcc = Oppty.Account_Territory__r.Parent_Account__r.Name;
        cu =Oppty.CommercialUnit__c;
        owner = Oppty.Owner.Name;
        AccName = Oppty.Account.Name;
        productType = Oppty.Product_Type__c;
         system.debug('Test RadioButton'+tabValues);  
        }
        }
        catch(Exception e)
        {
             Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','CTR_PopulatOli','Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
             insert exceptionLogRecord;
        }
    }
    /********************************************************************************************
* Method        createOlis
* Description:  US-228386: Called from PopulateOli page to insert OLIs depending on record type of oppty
* ------------------------------------------------------------------------------------------
* Date          Name               Modification Description
* ------------------------------------------------------------------------------------------
* 1-Jan-2018   Sruthi              Created
********************************************************************************************/
    public PageReference createOlis(){
        
        if (rtName== Label.RetailerSalesPlanRecordType || rtName== Label.RetailSeedsRecordType || rtName == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || rtName == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name){
            if (relDistr == null || relDistr == ''){
                PageReference errorPage = new PageReference('/apex/ErrorPage');
                return errorPage;
            }
        }
        List<opportunityLineitem> LineItemList = new List<opportunityLineItem>();
        LineItemList = createOlisFromPastData();
        if(LineItemList != null && !LineItemList.isEmpty()){
            //createSPAforCY(LineItemList,oppty);
            
            set<Id> prodids=new set<Id>();
            for(OpportunityLineItem oli:LineItemList)
            {
                prodids.add(oli.Product2Id);
            }
            /*system.debug('LineItemList:'+LineItemList.size());*/
            /*There are more than 1000 OLIs to be inserted(changed by vijay t0 1000 on 28th March. Insert them in a batch and show a message to the user to revisit the screen after a while            */

            /* Remove old code that would choose between running batch and running upsert directly 
            if(LineItemList.size() > 1000){
                Integer flexCount = [Select count() from AsyncApexJob where Status = 'Holding'];
                if(flexCount < Integer.valueOf(label.Flexcount))
                {
                    Database.executeBatch(new BatchInsertOlis(Oppty.Id,LineItemList));
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'System Overload:Please try again after sometime'));
                    return null;
                }
            }       
            else{
                try{
                    system.debug('LineItemList::::'+LineItemList);
                    Database.upsert(LineItemList);
                    System.debug('Inserted');
                }
                catch(Exception e){
                    Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','CTR_PopulatOli','createOLIs','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
                    insert exceptionLogRecord;
                }
            }*/
            /* Directly upsert Line Item List */
            Database.upsert(LineItemList);
        
            /*if (Oppty.RecordType.developername==Label.CP_Distributor_Sales_Plan || Oppty.RecordType.developername==Label.Seeds_Distributor_Sales_Plan){*/
            if (Oppty.RecordType.developername==Label.CP_Distributor_Sales_Plan){
                /*BatchRetailertoDistributor batch=new BatchRetailertoDistributor(Oppty.Id);
                Database.executeBatch(batch);                            */
                RetailertoDistributorNoBatch disbatch=new RetailertoDistributorNoBatch(Oppty.Id,prodids);            
                disbatch.Start();
            }
            else if(Oppty.RecordType.developername == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || Oppty.RecordType.developername == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name){
                /*BatchRetailertoHeadOffice retailerBatch = new BatchRetailertoHeadOffice(Oppty.Id);
                Database.executeBatch(retailerBatch);*/
                RetailertoHeadOfficeNoBatch batch=new RetailertoHeadOfficeNoBatch(Oppty.Id,prodids);
                batch.Start();               
            }
            /* Disabled because Territory plans have been discontinued
            else if(Oppty.RecordType.developername == Label.Territory_Sales_Plan || Oppty.RecordType.developername == Label.Territory_Seeds_Sales_Plan){
                BatchTerritorytoDistrict distBatch = new BatchTerritorytoDistrict(Oppty.Id);
                Database.executeBatch(distBatch);
            }*/
        }
        
        /* Old batch kickoff code.
        if (Oppty.RecordType.developername==Label.CP_Distributor_Sales_Plan || Oppty.RecordType.developername==Label.Seeds_Distributor_Sales_Plan){
            BatchRetailertoDistributor batch=new BatchRetailertoDistributor(Oppty.Id);
            Database.executeBatch(batch);                            
        }
        else if(Oppty.RecordType.developername == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || Oppty.RecordType.developername == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name){
            BatchRetailertoHeadOffice retailerBatch = new BatchRetailertoHeadOffice(Oppty.Id);
            Database.executeBatch(retailerBatch);
        }
        else if(Oppty.RecordType.developername == Label.CP_CU_Sales_Plan_Record_Type_Name || Oppty.RecordType.developername == Label.Seeds_CU_Sales_Plan_Record_Type_Name){
            BatchDistributortoCUPlan cuBatch = new BatchDistributortoCUPlan(Oppty.Id);
            Database.executeBatch(cuBatch);
        }
        else if(Oppty.RecordType.developername == Label.Territory_Sales_Plan || Oppty.RecordType.developername == Label.Territory_Seeds_Sales_Plan){
            BatchRetailtoTerritory terrBatch = new BatchRetailtoTerritory(Oppty.Id);
            Database.executeBatch(terrBatch);
       }
        else if(Oppty.RecordType.developername == Label.District_Sales_Plan || Oppty.RecordType.developername == Label.District_Seeds_Sales_Plan){
            BatchTerritorytoDistrict distBatch = new BatchTerritorytoDistrict(Oppty.Id);
            Database.executeBatch(distBatch);
        }*/   
        return null;    
    }
    
/********************************************************************************************
* Method        createOlisFromPastData()
* ------------------------------------------------------------------------------------------
* Date          Name               Modification Description
* ------------------------------------------------------------------------------------------*
1-Jan-2018    Sruthi                Created
Method to Insert Oli's on click of Edit Sales Plan on Baseline Opportunity(Sales Plan) Layout .
********************************************************************************************/
    public List<opportunityLineItem> createOlisFromPastData()
    {
        List<OpportunitylineItem > InsertOppList = new List<OpportunitylineItem >();
        try{
            if(oppty.PriceBook2Id != null){
                //     List<opportunityLineItem> Nplus1InsList = new List<opportunityLineItem>();
                Set<Id> existingOLIProdIds = new Set<Id>();
                if(Oppty.CountofOppProducts__c > 0){
                    //To check whether the opp already have some line items and to ignore them in insert
                    for(OpportunityLineItem oli: [Select Product2Id from OpportunityLineItem where OpportunityId = :Oppty.Id]){
                        existingOLIProdIds.add(oli.Product2Id);
                    }
                }
                System.debug('Going in to SalesPlanCreationHandler class');
                InsertOppList = SalesPlanCreationHandler.getInsertOLIList(Oppty, existingOLIProdIds, false, true);//remove true
                
                if(!InsertOppList.isEmpty())
                {
                    set<opportunitylineitem> insertOppSet = new set<opportunityLineItem>();
                    insertOppSet.addAll(InsertOppList);
                    InsertOppList.clear();
                    InsertOppList.addAll(insertOppSet);
                }
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','PopulatOliHandler','createOLIsFromPastData','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
        return InsertOppList;
    }
    
/********************************************************************************************
* Method:     populateCropProvision
* Description: To populate the crop provision related value based on the CU of opportunity
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 14-Mar-2018   sravani                Created
********************************************************************************************/
     public static void populateCropProvision(List<OpportunityLineItem> newOLIList){
        
        Set<String> pbe = new Set<String>();
        Set<Id> oppidset = new Set<Id>();
        Map<Id,String> oliMap = new Map<Id,String>();
        Map<Id,String> alloliMap = new Map<Id,String>();
        Map<Id,String> cropgroupnameECU = new Map<Id,String>();
        Map<Id,String> cropgroupnameWCU = new Map<Id,String>();
        Map<Id,Decimal> baseuomECU = new Map<Id,Decimal>();
        Map<Id,Decimal> baseuomWCU = new Map<Id,Decimal>();
        Map<Id,PriceBookEntry> pricebookMap = new Map<Id,PriceBookEntry>();
        try{
            for(OpportunityLineItem oli: newOLIList){
                pbe.add(oli.PricebookEntryId);
                oppidset.add(oli.opportunityid);
            }
            for(Opportunity opp:[select id,Recordtype.developername,CommercialUnit__c from opportunity where id in :oppidset])
            {
                alloliMap.put(opp.id, opp.CommercialUnit__c);
                if(opp.Recordtype.developername == Label.Seeds_Distributor_Sales_Plan || opp.Recordtype.developername == Label.Retailer_Seed_Sales_Plan){
                    oliMap.put(opp.id, opp.CommercialUnit__c);
                }
            }
            Map<Id,Id> cropGroupsECU = new Map<Id,Id>();
            Map<Id,Id> cropGroupsWCU = new Map<Id,Id>();
            
            if(oliMap.size() > 0){
                for(PriceBookEntry p:[Select Id,Product2Id,Product2.PrimaryECUCrop__c,Product2.PrimaryECUCrop__r.name,Product2.PrimaryWCUCrop__c,Product2.PrimaryWCUCrop__r.Name,Product2.Quantity_Acres_Conversion_A623__c,Product2.Quantity_Acres_Conversion_A633__c,Product2.Volume_L__c,Product2.Min_Saleable_UoM_Conversion__c FROM PriceBookEntry Where ID IN: pbe ]){
                    if(p.Product2.PrimaryECUCrop__c != null){
                        cropGroupsECU.put(p.Id,p.Product2.PrimaryECUCrop__c);
                        cropgroupnameECU.put(p.Id, p.Product2.PrimaryECUCrop__r.name);
                    }
                    if(p.Product2.PrimaryWCUCrop__c != null){
                        cropGroupsWCU.put(p.Id,p.Product2.PrimaryWCUCrop__c);
                        cropgroupnameWCU.put(p.Id, p.Product2.PrimaryWCUCrop__r.name);
                    }
                    if((p.Product2.Quantity_Acres_Conversion_A623__c)!=null)
                    {
                        baseuomECU.put(p.Id,p.Product2.Quantity_Acres_Conversion_A623__c);
                    }
                    if((p.Product2.Quantity_Acres_Conversion_A633__c)!=null)
                    {
                        baseuomWCU.put(p.Id,p.Product2.Quantity_Acres_Conversion_A633__c);
                    }
                    pricebookMap.put(p.Id,p);
                }
                Map<String,Crop_Return_Provision__c> cropRetProv = new Map<String,Crop_Return_Provision__c>();
                for(Crop_Return_Provision__c crp:[Select Id,CropGroup__c,ECUReturnProvision__c,WCUReturnProvision__c FROM Crop_Return_Provision__c Where (CropGroup__c IN: cropGroupsECU.values() or CropGroup__c IN: cropGroupsWCU.values())]){
                    cropRetProv.put(crp.CropGroup__c, crp);
                } 
                for(OpportunityLineItem oli: newOLIList){
                    if(oli.plnd_CY_stock_odr__c == null){
                        oli.plnd_CY_stock_odr__c = 0;
                    }
                  
                    if(oli.MY_FY_Planned_Ship_Totes__c == null){
                        oli.MY_FY_Planned_Ship_Totes__c = 0;
                    }
                    if(oli.Q4_Planned_Ship_CY__c == null){
                        oli.Q4_Planned_Ship_CY__c = 0;
                    }
                    if(oli.MY_Q4_Planned_Ship_Totes__c == null){
                        oli.MY_Q4_Planned_Ship_Totes__c = 0;
                    }                    
                  
                    if(oli.MY_FY_Planned_Ship_Total__c != oli.plnd_CY_stock_odr__c + oli.MY_FY_Planned_Ship_Totes__c)
                    {
                        oli.MY_FY_Planned_Ship_Total__c = oli.plnd_CY_stock_odr__c + oli.MY_FY_Planned_Ship_Totes__c;
                    }   
                      
                    if(cropRetProv.get(cropGroupsECU.get(oli.PricebookEntryId))!=null && oliMap.get(oli.OpportunityId) == Label.ECU && oli.plnd_CY_stock_odr__c!=null && oli.MY_FY_Planned_Ship_Totes__c !=null){
                         if(cropRetProv.get(cropGroupsECU.get(oli.PricebookEntryId)).ECUReturnProvision__c != null){                       
                            if(oli.FNS_CY__c != math.round((oli.plnd_CY_stock_odr__c + oli.MY_FY_Planned_Ship_Totes__c)* (1-(cropRetProv.get(cropGroupsECU.get(oli.PricebookEntryId)).ECUReturnProvision__c/100))))
                            
                            {
                             //Old Order calculation
                             //oli.plnd_CY_stock_odr__c = (oli.FNS_CY__c )/ (1-(cropRetProv.get(cropGroupsECU.get(oli.PricebookEntryId)).ECUReturnProvision__c/100));
                                 
                             oli.FNS_CY__c  = math.round((oli.plnd_CY_stock_odr__c + oli.MY_FY_Planned_Ship_Totes__c)* (1-(cropRetProv.get(cropGroupsECU.get(oli.PricebookEntryId)).ECUReturnProvision__c/100)));
                                     
                            }
                         }
                    }        
                    if(cropRetProv.get(cropGroupsWCU.get(oli.PricebookEntryId))!=null && oliMap.get(oli.OpportunityId) == Label.WCU && oli.plnd_CY_stock_odr__c!=null && oli.MY_FY_Planned_Ship_Totes__c!=null){
                        if(cropRetProv.get(cropGroupsWCU.get(oli.PricebookEntryId)).WCUReturnProvision__c!=null){
                            if(oli.FNS_CY__c != math.round((oli.plnd_CY_stock_odr__c + oli.MY_FY_Planned_Ship_Totes__c )* (1-(cropRetProv.get(cropGroupsWCU.get(oli.PricebookEntryId)).WCUReturnProvision__c/100))))
                            {
                               /* Old Order calculation 
                               oli.plnd_CY_stock_odr__c = (oli.FNS_CY__c) / (1-(cropRetProv.get(cropGroupsWCU.get(oli.PricebookEntryId)).WCUReturnProvision__c/100));
                               */
                               oli.FNS_CY__c  = math.round((oli.plnd_CY_stock_odr__c + oli.MY_FY_Planned_Ship_Totes__c )* (1-(cropRetProv.get(cropGroupsWCU.get(oli.PricebookEntryId)).WCUReturnProvision__c/100)));
                            }                       
                        }
                    }       
                }
            }
        }    
        catch(Exception e)
        {
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','PopulatOliHandler','populateCropProvision','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
            
        try{
        
            for(OpportunityLineItem oli:newOLIList ){
                if(cropgroupnameECU.get(oli.PricebookEntryId)!=null && alloliMap.get(oli.OpportunityId) == Label.ECU){
                    /*system.debug('Primary ECU Crop' +oli.PricebookEntryId);*/
                    oli.Primary_Crop__c = cropgroupnameECU.get(oli.PricebookEntryId);
                }
                if(cropgroupnameWCU.get(oli.PricebookEntryId)!=null && alloliMap.get(oli.OpportunityId) == Label.WCU){
                    /*system.debug('Primary WCU Crop' +oli.PricebookEntryId);*/
                    oli.Primary_Crop__c = cropgroupnameWCU.get(oli.PricebookEntryId);
                }
            }
        }
        catch(Exception e)
        {
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','PopulatOliHandler','populateCropProvision','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
        
        try{
            for(OpportunityLineItem oli:newOLIList ){
                 if(alloliMap.get(oli.OpportunityId) == Label.ECU && baseuomECU.get(oli.PricebookEntryId)!=null){
                     system.debug('Primary ECU Crop' +oli.PricebookEntryId);
                     oli.Acres_Per_Field_UOM__c = baseuomECU.get(oli.PricebookEntryId);
                  }
                  else if(alloliMap.get(oli.OpportunityId) == Label.WCU && baseuomWCU.get(oli.PricebookEntryId)!=null){
                      system.debug('Primary WCU Crop' +oli.PricebookEntryId);
                      oli.Acres_Per_Field_UOM__c = baseuomWCU.get(oli.PricebookEntryId);
                  }
                  if(pricebookMap.get(oli.PricebookEntryId)!= null){
                      oli.Field_UOM_Conversion__c=(pricebookMap.get(oli.PricebookEntryId)).Product2.Volume_L__c;
                      oli.MinSaleableUOMConversion__c=(pricebookMap.get(oli.PricebookEntryId)).Product2.Min_Saleable_UoM_Conversion__c;
                  }    
            }
        }
        catch(Exception e)
        {
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','PopulatOliHandler','populateCropProvision','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    
 /********************************************************************************************
* Method:     copyLastMonthToNextMonth
* Description: To populate the crop provision related value based on the CU of opportunity
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 14-Mar-2018   sravani                Created
********************************************************************************************/
     public static void copyLastMonthToNextMonth(){
             System.Debug('Entered copy method');
             String fieldNameSource = '';
             String fieldNameTarget = '';
             String queryString = '';             
             
             try{
             Id OppId = ApexPages.currentpage().GetParameters().get('id');
             
             /*List<opportunity> oppList = [select Id, RecordType.DeveloperName from Opportunity where id =: OppId];
             rtName = oppList[0].RecordType.DeveloperName;*/
             
             
             AggregateResult[] aggOLIs=[select 
               sum(LE_March_Quantity__c)mar,
               sum(LE_April_Quantity__c)apr,
               sum(LE_May_Quantity__c)may,
               sum(LE_June_Quantity__c)jun,
               sum(LE_July_Quantity__c)jul,
               sum(LE_August_Quantity__c)aug,
               sum(LE_September_Quantity__c)sep
     
               from OpportunityLineItem where OpportunityId=:OppId];
               
               if(aggOLIs.size() == 1){
                 if((Decimal)aggOLIs[0].get('aug') > 0 && (Decimal)aggOLIs[0].get('sep') == 0){    
                    fieldNameSource = 'LE_August_Quantity__c';
                    fieldNameTarget = 'LE_September_Quantity__c';                               
                 }
                 else if((Decimal)aggOLIs[0].get('jul') > 0 && (Decimal)aggOLIs[0].get('aug') == 0){    
                    fieldNameSource = 'LE_July_Quantity__c';
                    fieldNameTarget = 'LE_August_Quantity__c';                                                                      
                 }
                 else if((Decimal)aggOLIs[0].get('jun') > 0 && (Decimal)aggOLIs[0].get('jul') == 0){    
                    fieldNameSource = 'LE_June_Quantity__c';
                    fieldNameTarget = 'LE_July_Quantity__c';                               
                 }
                 else if((Decimal)aggOLIs[0].get('may') > 0 && (Decimal)aggOLIs[0].get('jun') == 0){    
                    fieldNameSource = 'LE_May_Quantity__c';
                    fieldNameTarget = 'LE_June_Quantity__c';                               
                 }
                 else if((Decimal)aggOLIs[0].get('apr') > 0 && (Decimal)aggOLIs[0].get('may') == 0){    
                    fieldNameSource = 'LE_April_Quantity__c';
                    fieldNameTarget = 'LE_May_Quantity__c';                               
                 }
                 else if((Decimal)aggOLIs[0].get('mar') > 0 && (Decimal)aggOLIs[0].get('apr') == 0){    
                    fieldNameSource = 'LE_March_Quantity__c';
                    fieldNameTarget = 'LE_April_Quantity__c';                               
                 }
                 
               
               }
               /*System.Debug('Source field name is ' + fieldNameSource + ' and target is ' + fieldNameTarget);*/
               queryString = 'select Id, LE_March_Quantity__c, LE_April_Quantity__c, LE_May_Quantity__c, LE_June_Quantity__c, LE_July_Quantity__c, LE_August_Quantity__c, LE_September_Quantity__c from OpportunityLineItem where OpportunityId =:OppId and ' + fieldNameSource + ' <> 0';
               List<OpportunityLineItem> childOLIList=Database.query(queryString);
               for(OpportunityLineItem o : childOLIList){
                    o.put(fieldNameTarget,o.get(fieldNameSource));               
               }
               /*System.Debug(fieldNameSource + ' - ' + (Decimal)aggOLIs[0].get('aug') + '...' + fieldNameTarget);*/
               update childOLIList;
               }
               catch(Exception e)
               {
                   Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','PopulatOliHandler','copyLastMonthToNextMonth','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
                   insert exceptionLogRecord;
               }
          }
}