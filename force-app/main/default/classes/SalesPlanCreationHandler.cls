/********************************************************************************************
* Class:     SalesPlanCreationHandler to write the methods
* Description: US-231913
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 15-Dec-2017 Pooja Joshi               Created
* 20-Dec-2017 Sruthi                    Modified for US-228386
********************************************************************************************/
public class SalesPlanCreationHandler{
    public static Business_Plan__c BusinessPlan;
    public static Id userId = UserInfo.getUserId();
    public static String prodType;
    public static String BusPlanId;
    public static String OpprecordType;
    public static String salesPlanType;
    public static String existingOpportunityId;
    public static Id recordTypeId;
    public static String currentYear;
    public static String previousYear;
    public static String P_previousYear;
    public static String category;
    public static String recordType;
    public static Map<String,Sales_Plan_Actual__c> mapActuals;
    
    
    /********************************************************************************************
* Method        createSPHeader
* ------------------------------------------------------------------------------------------
* 20-Dec-2017     Sruthi             Created   For Setting theredirection URL on click of new Sales plan button
********************************************************************************************/    
    public static String createSPHeader(){
        try{
            prodType = ApexPages.currentPage().getParameters().get('ProdType');
            BusPlanId = ApexPages.currentPage().getParameters().get('BPId');
            OpprecordType = ApexPages.currentPage().getParameters().get('OppRecType');
            salesPlanType = ApexPages.currentPage().getParameters().get('SalesPlanType');       
            Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
            if(OpprecordType != null){
                recordTypeId = oppRecordtypes.get(OpprecordType);    
            }
            if(BusPlanId != null){
                BusinessPlan = [select id,name,Year__c,Account__c,Recordtype.DeveloperName from Business_Plan__c where id = :BusPlanId];
            }         
            
            existingOpportunityId = null;
            List<Opportunity> existingOpp = [Select Id,RecordTypeId from Opportunity where Year__c = :BusinessPlan.Year__c and Product_type__c =: prodType and AccountId =: BusinessPlan.Account__c and RecordTypeId = :recordTypeId];
            if (existingOpp.size() > 0 && existingOpp[0].RecordTypeId != oppRecordtypes.get(Label.RetailerSalesPlanRecordType) /* Ticket TKT-068067 IST Start: By Sravani */ && existingOpp[0].RecordTypeId != oppRecordtypes.get(Label.RetailSeedsRecordType) /* Stop TKT-068067*/&& existingOpp[0].RecordTypeId != oppRecordtypes.get(Label.GrowerCPSalesPlanRecordType) && existingOpp[0].RecordTypeId != oppRecordtypes.get(Label.GrowerSeedsSalesPlanRecordType)) {
                existingOpportunityId = existingOpp[0].id;
                return '/'+existingOpportunityId;
            }
            else {
                Opportunity SalesPlan =  createSalesPlan(BusinessPlan,recordTypeId); // Method to Create Sales plan
                if(SalesPlan!=null){
                return '/'+SalesPlan.id;
                }
                return '';
            }
        }
        
        catch(Exception e){
            if(e.getMessage().contains('DUPLICATE_VALUE')){
                String oppId = e.getMessage().Split(':').get(3).trim();
                return '/'+oppId;
            }
            ApexPages.Message myMsg;
            myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
            return null;
        }
        
    }
    
    
    /********************************************************************************************
* Method        createSalesPlan
* ------------------------------------------------------------------------------------------
* 20-Dec-2017     Sruthi             Created   To populate the fields of the opportunity with the necessary values
********************************************************************************************/     
    public static Opportunity createSalesPlan(Business_Plan__c BPlan,Id recordTypeId){
        Opportunity salesPlan = new Opportunity();
        Territory__c userTerritory = new Territory__c();
        Account_Territory__c actTerritory = new Account_Territory__c();
        try{
            User loggedinUser = [select id, user_country__c, Territory_Code__c from User where id = :userInfo.getUserId()];
            Account bpAccount = [select Id, OwnerId, Territory_Lookup__c from Account where Id = :BPlan.Account__c];
            try{
                if(loggedinUser.Territory_Code__c != null)
                    userTerritory = [select id,Name,TerritoryLevel__c,District__c,CommercialUnit__c from Territory__c where Name = :loggedinUser.Territory_Code__c];
            }
            Catch(Exception e){
                userTerritory = null; 
            }
            salesPlan.AccountId = BPlan.Account__c;
            salesPlan.recordtypeId = recordTypeId;
            salesPlan.Name = BPlan.Year__c+' ' +salesPlan.Account.Name+' '+salesPlan.RecordType.Name;
            salesPlan.AccountBusinessPlan__c = BPlan.Id;
            salesPlan.StageName = 'Closed';
            salesPlan.Probability = 100;
            salesPlan.Year__c = BPlan.Year__c;
            salesPlan.OwnerId = bpAccount.OwnerId;
            /*salesPlan.OwnerId = loggedinUser.Id;*/
            
            // Ticket TKT-067591 IST Start: By Sruthi
           // RecordType salesPlanRecType = [SELECT DeveloperName FROM RecordType WHERE Id =:recordTypeId limit 1];
           // if(!(salesPlanRecType.DeveloperName == Label.GrowerCPSalesPlanRecordType || salesPlanRecType.DeveloperName == Label.GrowerSeedsSalesPlanRecordType))
                
                /*TC change April 9 2019  Territory was set to user territory.  Will now be Account Owner Territory 
                salesPlan.Territory__c = userTerritory.Id;*/
                salesPlan.Territory__c = bpAccount.Territory_Lookup__c;
            // Stop TKT-067591
            
            if((OpprecordType == Label.District_Sales_Plan || OpprecordType == Label.District_Seeds_Sales_Plan) && userTerritory.TerritoryLevel__c=='L2:District'){
                //System.debug('userTerritory.Name'+userTerritory.Name);
                salesPlan.District__c = userTerritory.Id; 
                salesPlan.Territory__c = userTerritory.Id;
            }
            else if((OpprecordType == Label.District_Sales_Plan || OpprecordType == Label.District_Seeds_Sales_Plan) && userTerritory.TerritoryLevel__c=='L3:Territory'){
                if(userTerritory.District__c != null){
                    salesPlan.District__c = userTerritory.District__c;
                    salesPlan.Territory__c = userTerritory.Id;
                } 
            }
            
            if(salesPlan.AccountId != null && salesPlan.Territory__c != null){
                try{
                    actTerritory = [Select id From Account_Territory__c
                                    WHERE Territory__c =: bpAccount.Territory_Lookup__c  AND Account__c =:BPlan.Account__c limit 1];    
                }Catch(Exception e){
                    salesPlan.Account_Territory__c = null;
                }
                if(actTerritory != null){
                    salesPlan.Account_Territory__c = actTerritory.Id;
                }
            }
            salesPlan.CloseDate = Date.newInstance(Integer.valueOf(BPlan.Year__c), 12, 31);
            if(OpprecordType == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || OpprecordType == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name){
                salesPlan.Sales_Plan_Type__c = 'AASP';
            }
            else{
                salesPlan.Sales_Plan_Type__c = 'ASP';
            }
            salesPlan.Type = 'Sales Plan';
            salesPlan.Product_Type__c = ApexPages.currentPage().getParameters().get('prodType');
            if(prodType == 'CP'){
                salesPlan.Pricebook2Id =  Label.CP_Price_Book;   
            }
            else{
                salesPlan.Pricebook2Id =  Label.Seeds_Price_Book;   
            }
            
            upsert salesPlan;
            ToUpdateRelatedPlan.UpdateDSPRelatedPlan(salesPlan);
            return salesPlan;
            
        }
        Catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','SYT_OpportunityNewDispatcher','redirectURL','Technical exception',userId,e.getStackTraceString(),'TC0001/0002',e.getMessage());
            insert exceptionLogRecord;
            return null;
        }
    }
    
    /********************************************************************************************
* Method        getInsertOLIList
* ------------------------------------------------------------------------------------------
* 20-Dec-2017     Sruthi             Created   Method for finding the products to be inserted to the opportunity from previous year SPA
********************************************************************************************/    
    
    public static List<OpportunitylineItem> getInsertOLIList(Opportunity opp,Set<Id> ProdIds, Boolean checkPY, Boolean checkCY){
        //passing existing products on opp
        List<OpportunityLineItem> InserOppList = new List<OpportunityLineItem>();
        try{
            //Get the Current Year from the Opportunity
            currentYear = (opp.Year__c != null && opp.Year__c != '' ? opp.Year__c : opp.CurrentBusinessPlanYear__c);
            previousYear = String.Valueof(Integer.valueof(currentYear) -1);
            P_previousYear = String.Valueof(Integer.valueof(currentYear) -2);
            
            //Get the Product Type from the opportunity
            String productType = opp.Product_Type__c;
            
            //Get the other parameters to be used to query the Opportunity
            Id accId = opp.AccountId;
            Id AreaLevelId = opp.Territory__c;
            Boolean prodAddedfromPYOLIs = false;
            
            Set<Id> ProdIdstoGet = new Set<Id>();
            
            Map<Id, OpportunityLineItem> Prod2OliMap = new Map<Id, OpportunityLineItem>();
            
            //Map to store PricebookEntry of Records to be Inserted
            Map<id,PricebookEntry> Product_PricebookMap = new Map<id,PricebookEntry>();
            
            /* Query Previous Year's OLIs to get the Line Items.*/
            /* Commenting because prior year source is disabled.
            if(checkPY){
                String PYOLIQuery = 'select id,CY_Planned_Sales__c,Quantity,UnitPrice,ListPrice ,PriceBookEntryId,'+
                    'Product2Id,Product2.Product_ID__c,Ending_Inventory_CY__c from OpportunityLineItem '+ 
                    'where Opportunity.AccountId = :accId and Opportunity.Product_Type__c =:productType'+
                    ' and Opportunity.AccountBusinessPlan__r.Year__c =: previousYear';
                
                if(opp.RecordType.DeveloperName == Label.DistributorCPSalesPlan){
                    PYOLIQuery ='';
                    PYOLIQuery = 'select id,CY_Planned_Sales__c,Quantity,UnitPrice,ListPrice ,PriceBookEntryId,'+
                        'Product2Id,Product2.Product_ID__c,Commercial_Unit__c,Ending_Inventory_CY__c from OpportunityLineItem '+ 
                        'where Opportunity.AccountId = :accId and Opportunity.Product_Type__c =:productType'+
                        ' and (Opportunity.AccountBusinessPlan__r.Year__c =: previousYear'  +  
                        ' or Opportunity.AccountBusinessPlan__r.Year__c =:P_previousYear)';
                    
                }
                
                if(ProdIds != null && !ProdIds.isEmpty()){// There are already products present on the Opportunity. Exclude those from the query.
                    PYOLIQuery = PYOLIQuery + ' and Product2Id NOT IN :ProdIds';
                }
                
                List<OpportunityLineItem> oliList = Database.query(PYOLIQuery);
                if(!oliList.isEmpty()){
                    for(OpportunityLineItem oli: oliList){
                        ProdIdstoGet.add(oli.Product2Id);
                        ProdIds.add(oli.Product2Id);
                        Prod2OliMap.put(oli.Product2Id,oli);
                    }
                    prodAddedfromPYOLIs = true;
                    Product_PricebookMap = getPriceBookProducts(Opp.Pricebook2Id,ProdIdstoGet);  
                    for(OpportunityLineItem oli:oliList){
                        if(Product_PricebookMap.containsKey(oli.Product2Id))
                            InserOppList.add(createOppoProducts(oli,opp, Product_PricebookMap));                       
                    }
                }
                
            }*/
            if (checkCY || !prodAddedfromPYOLIs) {//If Products are to be added from current year and previous year SPAs
                String queryString = 'select id,Account__c,Product__c,Product__r.name,Product__r.Product_ID__c,' +
                    'UniqueKey__c, PY_YTDOrders__c,Year__c from Sales_Plan_Actual__c ' +
                    'where Account__c=:accId and Blank_SPA_Filter__c <> 0 ' ;
               /* if (opp.RecordType.DeveloperName == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || 
                    opp.RecordType.DeveloperName == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name ||
                    opp.RecordType.DeveloperName == Label.RetailerSalesPlanRecordType || opp.RecordType.DeveloperName == Label.Retailer_Seed_Sales_Plan) {
                        queryString = queryString + ' AND Territory__c =:AreaLevelId ';
                    } */
                queryString = queryString + ' AND (Year__c = :currentYear or year__c=:previousYear';
                if(opp.RecordType.DeveloperName == Label.DistributorCPSalesPlan){
                    queryString = queryString + ' or year__c=:P_previousYear' ;
                }
                queryString = queryString + ')';
                if(ProdIds != null && !ProdIds.isEmpty())// There are already products present on the Opportunity. Exclude those from the query
                    queryString = queryString + 'and Product__c NOT IN :ProdIds';
                
                //queryString = queryString + ' AND (Year__c = :currentYear or year__c=:previousYear)' ;
                
                System.Debug('Querystring is ' + queryString); 
                queryString = queryString + ' Order By Year__c';
                List<Sales_Plan_Actual__c> spaList = Database.query(queryString);               
                System.Debug('spaList Size is ' + spaList.size());
                
                //Get the corresponding PricebookEntry for the SPA Products
                for(Sales_Plan_Actual__c spa : spaList){
                    ProdIdstoGet.add(spa.Product__c);
                    ProdIds.add(spa.Product__c);
                }
                if(!ProdIdstoGet.isEmpty()){
                    Product_PricebookMap = getPriceBookProducts(Opp.Pricebook2Id,ProdIdstoGet);
                    if(!Product_PricebookMap.isEmpty()){
                        Set<Id> prodIdSet = new Set<Id>();
                        for(Sales_Plan_Actual__c spa:spaList){
                            if(Product_PricebookMap.containsKey(spa.Product__c)){
                                if(!prodIdSet.contains(spa.Product__c)){
                                    OpportunityLineItem newOli = createOppoProducts(spa,opp,Product_PricebookMap);                                      
                                    // If sales is not done in PPY then set the Qty and Planned_Oty to 0 
                                    InserOppList.add(newOli);
                                    prodIdSet.add(spa.Product__c);
                                }
                            }
                        }
                    }
                }
            }
            
             if (checkCY) {// Products are to be added from current year Syngenta Products list
                String commercialUnit=opp.CommercialUnit__c;
                String queryString = '';
                if(opp.CommercialUnit__c != null){
                    queryString = 'select id,Products__c,Products__r.name,Products__r.Product_ID__c,' +
                    'Year__c from Syngenta_Product__c ' + 'where Commercial_Unit__c =:commercialUnit AND Year__c = :currentYear AND ProductType__c=:productType' ;
                }
                else{
                    queryString = 'select id,Products__c,Products__r.name,Products__r.Product_ID__c,' +
                    'Year__c from Syngenta_Product__c ' + 'where Year__c = :currentYear AND ProductType__c=:productType';
                }
                              
                if(ProdIds != null && !ProdIds.isEmpty())// There are already products present on the Opportunity. Exclude those from the query
                    queryString = queryString + ' and Products__c NOT IN :ProdIds';
                
               
                List<Syngenta_Product__c> spList = Database.query(queryString);                
                
                //Get the corresponding PricebookEntry for the SPA Products - US-345111
                for(Syngenta_Product__c sp : spList){
                    ProdIdstoGet.add(sp.Products__c);
                }
                if(!ProdIdstoGet.isEmpty()){
                    Product_PricebookMap = getPriceBookProducts(Opp.Pricebook2Id,ProdIdstoGet);
                    if(!Product_PricebookMap.isEmpty()){
                         for(Syngenta_Product__c sp:spList){
                            if(Product_PricebookMap.containsKey(sp.Products__c)){
                               OpportunityLineItem newOli = createOppoProducts(sp,opp,Product_PricebookMap);                                      
                               InserOppList.add(newOli);
                             }
                        }
                    }
                }
            }
            
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','SalesPlanCreationHandler','getInsertOLIList','Technical exception',userId,e.getStackTraceString(),'TC0001/0002',e.getMessage());
            insert exceptionLogRecord;
        }
        return  InserOppList;
    }
    
    /********************************************************************************************
* Method        createOppoProducts
* ------------------------------------------------------------------------------------------
* 1-JAN-2018     Sruthi             Created
********************************************************************************************/
    public static OpportunityLineItem createOppoProducts(Sales_Plan_Actual__c spa, Opportunity Opp,Map<id,PricebookEntry> Product_PricebookMap){
        OpportunityLineItem objOppProd = new OpportunityLineItem();        
        objOppProd.OpportunityID = Opp.id;
        objOppProd.PriceBookEntryId = Product_PricebookMap.get(spa.Product__c).Id;
        objOppProd.Related_Business_Plan_Locked__c = Opp.Related_Business_Plan_Locked__c;
        return objOppProd;
    }
    
    public static OpportunityLineItem createOppoProducts(OpportunitylineItem oli, Opportunity Opp,Map<id,PricebookEntry> Product_PricebookMap){
        OpportunityLineItem objOppProd = new OpportunityLineItem();
        objOppProd.OpportunityID = Opp.id;
        objOppProd.Related_Business_Plan_Locked__c = Opp.Related_Business_Plan_Locked__c;
        objOppProd.PriceBookEntryId = Product_PricebookMap.get(oli.Product2id).Id;
        return objOppProd;
    }
    
    public static OpportunityLineItem createOppoProducts(Syngenta_Product__c synprod, Opportunity Opp,Map<id,PricebookEntry> Product_PricebookMap){
        OpportunityLineItem objOppProd = new OpportunityLineItem();
        objOppProd.OpportunityID = Opp.id;
        objOppProd.Related_Business_Plan_Locked__c = Opp.Related_Business_Plan_Locked__c;
        objOppProd.PriceBookEntryId = Product_PricebookMap.get(synprod.Products__c).Id;
        return objOppProd;
    }
    
    /********************************************************************************************
* Method        getPriceBookProducts()
* ------------------------------------------------------------------------------------------
* 5-Jan-2018    Sruthi Haridas             Created
********************************************************************************************/
    public static Map<Id,PricebookEntry> getPriceBookProducts(String priceBookId, Set<Id> ProductIds){
        Map<Id,PricebookEntry> Prd_PbEntryMap = new Map<Id,PricebookEntry>();
        
        if(priceBookId != null && priceBookId != '' && ProductIds != null && !ProductIds.isEmpty()){
            for(PricebookEntry pricebk : [select id , Pricebook2Id,Product2Id,UnitPrice
                                          from PricebookEntry where Pricebook2Id = :priceBookId and Product2Id in :ProductIds and isActive = true]){
                                              Prd_PbEntryMap.put(pricebk.Product2Id,pricebk);
                                          }
        }
        
        return Prd_PbEntryMap;
    }
    
    /********************************************************************************************
* Method        defaultProductFields()
* ------------------------------------------------------------------------------------------
* 8-Jan-2018    Sruthi Haridas                 Created
********************************************************************************************/
    public static void defaultProductFields(List<OpportunityLineItem> oppLIs){
        for(OpportunityLineItem oli:oppLIs){
            oli.Quantity = decimal.valueOf(1); 
            if(oli.TotalPrice == null && oli.UnitPrice == null){
                oli.TotalPrice = decimal.valueOf(1);    
            }
        }
    }
    
    /********************************************************************************************
* Method        updateOLICYactualsales()
* ------------------------------------------------------------------------------------------
* 9-Jan-2018    Sruthi Haridas                 Created
********************************************************************************************/
    public static void updateOLICYactualsales(List<OpportunityLineItem> opportunityOLIList){
        //Get the related OpportunityLineItems of the District seeds sales plan
        List <String> OLIspKey = new List<String>();
        //Map<String, OpportunityLineItem> OLISPmatchingkey = new Map<String, OpportunityLineItem>();
        If(!opportunityOLIList.isEmpty()){
            for(OpportunityLineItem oli : opportunityOLIList){
                OLIspKey.add(oli.SP_Matching_Key__c);
                OLIspKey.add(oli.SP_Matching_Key_1__c);
                OLIspKey.add(oli.SP_Matching_Key_2__c);  
            } 
        } 
        List<Sales_Plan_Actual__c> relatedSPAOLI = [Select Id,Units__c,UniqueKey__c,Product__c,Product_ID__c from Sales_Plan_Actual__c where UniqueKey__c in :OLIspKey];
        Map<String, Sales_Plan_Actual__c> matchingKeyWithSPAOLI = new Map<String, Sales_Plan_Actual__c>();
        if(!relatedSPAOLI.isEmpty()){
            for(Sales_Plan_Actual__c spkey : relatedSPAOLI ){  
                matchingKeyWithSPAOLI.put(spkey.UniqueKey__c,spkey);             
            }                                
            for(OpportunityLineItem olis : opportunityOLIList ){ 
                try{
                    if((matchingKeyWithSPAOLI.get(olis.SP_Matching_Key__c) != null)){
                        olis.SalesPlanActual__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key__c).id;
                    }
                }Catch(Exception e){
                    olis.SalesPlanActual__c=null;    
                }
                try{   
                    if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_1__c) != null){
                        olis.Sales_Plan_Actual_1__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_1__c).id; 
                    } 
                }Catch(Exception e){
                    olis.Sales_Plan_Actual_1__c = null;    
                }
                try{
                    if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_2__c) != null){
                        olis.Sales_Plan_Actual_2__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_2__c).id;    
                    }
                }Catch(Exception e){
                    olis.Sales_Plan_Actual_2__c=null;    
                }
                
            } 
        }
    }
    
    
    /********************************************************************************************
* Method        createCYSPA()      Method to create SPA for the new OLI created from grid and establish the lookup relation
* ------------------------------------------------------------------------------------------
* 19-Jan-2018    Sruthi Haridas                 Created
********************************************************************************************/
    public static void createCYSPA(List<OpportunityLineItem> oppOLIList){
        List<OpportunityLineItem> opptoBeUpdated = new List<OpportunityLineItem>();
        Set<OpportunityLineItem> OLIToCreateSPA = new Set<OpportunityLineItem>();
        List<Sales_Plan_Actual__c> SPAlstToInsert = new List<Sales_Plan_Actual__c>();
        Set<Sales_Plan_Actual__c> SPAtoCreate = new Set<Sales_Plan_Actual__c>();
        List<String> OLIspKey = new List<String>();
        Set <ID> oppIds = new Set<ID>();
        Set<ID> prdIds = new Set<ID>();
        List<Sales_Plan_Actual__c> relatedSPAavailable = new List<Sales_Plan_Actual__c>();
        List<Opportunity> oppSPAtoCreate = new List<Opportunity>();
        List<Product2> prdEntry = new List<Product2>();
        
        If(!oppOLIList.isEmpty()){
            for(OpportunityLineItem oli : oppOLIList){
                OLIspKey.add(oli.SP_Matching_Key__c); 
            }
            //System.debug('OLI SP Key List---->'+OLIspKey);
        } 
        
        try{
            relatedSPAavailable = [Select Id,UniqueKey__c,Year__c,Product__c,Product_ID__c from Sales_Plan_Actual__c 
                                   where UniqueKey__c in :OLIspKey];
        }Catch (Exception e){
            relatedSPAavailable = null;
        }
        Map<String, Sales_Plan_Actual__c> SPAwithKey = new Map<String, Sales_Plan_Actual__c>();
        if(!relatedSPAavailable.isEmpty()){
            for(Sales_Plan_Actual__c SPA : relatedSPAavailable){  
                SPAwithKey.put(SPA.UniqueKey__c,SPA);             
            }                             
        } 
        
        for(OpportunityLineItem oli : oppOLIList){ 
            if((SPAwithKey.get(oli.SP_Matching_Key__c) == null)){
                OLIToCreateSPA.add(oli);  
                oppIds.add(oli.OpportunityId);
                prdIds.add(oli.Product2Id);
            }   
        } 
        //getting the related opportunity details and adding that to map
        try{
            oppSPAtoCreate = [select id,AccountId,Account.Account_ID__c,AccountBusinessPlan__r.name,Product_Type__c,
                              Territory__c,Territory__r.Name,AccountBusinessPlan__r.Year__c,RecordType.DeveloperName,year__c 
                              from Opportunity where id IN : oppIds];   
        }Catch (Exception Ex){
            oppSPAtoCreate[0]=null;   
        }
        Map<Id,Opportunity> OppwithKey = new Map<Id,Opportunity>();
        if(!oppSPAtoCreate.isEmpty()){
            for(Opportunity opps: oppSPAtoCreate){
                OppwithKey.put(opps.id,opps); 
            }   
        }
        
        //Getting details of product and pricebook entry
        try{
            prdEntry = [select id,Product2.Product_ID__c FROM Product2 
                        WHERE id in :prdIds];
        }Catch(Exception ec){
            prdEntry[0]=null;   
        }
        Map<Id,Product2> prdEntrywithKey = new Map<Id,Product2>();
        if(!prdEntry.isEmpty()){
            for(Product2 pdEntry: prdEntry){
                prdEntrywithKey.put(pdEntry.id,pdEntry); 
            }   
        }
        //To get opportunity record types
        Map<string,id> SPARecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Sales_Plan_Actual__c.SObjectType);
        
        //Populating the fields of the SPA to create
        
        for(OpportunityLineItem oppOLI: OLIToCreateSPA){
            String SPACategory;
            Opportunity oppty = OppwithKey.get(oppOLI.OpportunityId);
            
            Sales_Plan_Actual__c SPACY =  new Sales_Plan_Actual__c();
            Product2 prdEy = prdEntrywithKey.get(oppOLI.Product2Id);
            
            SPACY.Account__c = oppty.AccountId;         
            SPACY.SoldtoID__c = oppty.Account.Account_ID__c;       
            SPACY.Territory__c = oppty.Territory__c;      
            if(oppty.RecordType.DeveloperName == Label.GrowerCPSalesPlanRecordType || oppty.RecordType.DeveloperName == Label.GrowerSeedsSalesPlanRecordType){
                SPACY.Category__c = 'Grower OTG Sales';   
            }else if(oppty.RecordType.DeveloperName == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || 
                     oppty.RecordType.DeveloperName == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name || oppty.RecordType.DeveloperName ==Label.RetailerSalesPlanRecordType || oppty.RecordType.DeveloperName ==Label.Retailer_Seed_Sales_Plan){
                         SPACY.Category__c = 'Retail OTG Sales';    
                     }else if(oppty.RecordType.DeveloperName ==Label.CP_Distributor_Sales_Plan || Oppty.RecordType.developername==Label.Seeds_Distributor_Sales_Plan){
                         SPACY.Category__c = 'Channel Sales';    
                     }
            else
            {
                SPACY.Category__c = 'Area Sales';
            }
            if(oppty.Product_Type__c == 'CP'){
                SPACY.RecordTypeId = SPARecordtypes.get('CP_Sales'); 
                SPACategory = label.CP_Sales; 
            }else{
                SPACY.RecordTypeId = SPARecordtypes.get('Seeds_Sales');
                SPACategory = label.Seeds_Sales;
            }
            SPACY.Year__c = oppty.AccountBusinessPlan__r.Year__c;
            SPACY.Product__c = prdEy.Id;
            SPACY.UniqueKey__c = oppty.Account.Account_ID__c+'|'+prdEy.Product_ID__c+'|'
                +oppty.AccountBusinessPlan__r.Year__c+'|'+SPACY.Category__c+'|'+SPACategory;
            SPACY.Name = oppty.Account.Account_ID__c+'|'+prdEy.Product_ID__c+'|'
                +oppty.AccountBusinessPlan__r.Year__c+'|'+SPACY.Category__c+'|'+SPACategory; 
            
            SPAtoCreate.add(SPACY);
        }
        
        if(!SPAtoCreate.isEmpty()){
            try{ 
                SPAlstToInsert.addAll(SPAtoCreate);
                Database.upsert(SPAlstToInsert);
            }catch(Exception e){
                
            } 
        } 
        
    }
    
    
    /********************************************************************************************
* Method        updatOLIwithKeys()              Method to populate the OLI created form the grid with the matching key
* ------------------------------------------------------------------------------------------
* 19-Jan-2018    Sruthi Haridas                 Created
********************************************************************************************/
    public static void updatOLIwithKeys(List<OpportunityLineItem> oppOLIList){
        //setting up the variables for themethod
        Set<ID> prdIds = new Set<ID>();
        String previousYear ;
        String P_previousYear;
        String Type;
        String priceCategory;
        String Category;
        String priceCategoryNSP;
        List<OpportunityLineItem> OLIUpdated = new List<OpportunityLineItem> ();
        Set<Id> oppIds = new Set<Id>();
        
        if(!oppOLIList.isEmpty()){
            for(OpportunityLineItem oli : oppOLIList){ 
                oppIds.add(oli.OpportunityId);
                // prcEntryIds.add(oli.PricebookEntryId);
                prdIds.add(oli.Product2Id);
            }   
        }
        
        //getting the related opportunity details and adding that to map
        List<Opportunity> oppsRelated = [select id,AccountId,Account.Account_ID__c,CurrentBusinessPlanYear__c,AccountBusinessPlan__r.name,Product_Type__c,
                                         Territory__c,Territory__r.Name,AccountBusinessPlan__r.Year__c,RecordType.DeveloperName,year__c,RelatedDistributor__r.name,Related_Retailer__r.name 
                                         from Opportunity where id IN : oppIds]; 
        Map<Id,Opportunity> OppwithKey = new Map<Id,Opportunity>();
        if(!oppsRelated.isEmpty()){
            for(Opportunity opps: oppsRelated){
                OppwithKey.put(opps.id,opps);    
            }   
        }
        
        //getting the related prods details and adding that to map
        List<Product2> prodsRelated = [select id,Product_ID__c, Variety__c, Brand__c, Maturity_Group__c, Product_Line__c, Volume_L__c, Min_Saleable_UoM_Conversion__c 
                                       from Product2 where id IN : prdIds]; 
        Map<Id,Product2> prodwithKey = new Map<Id,Product2>();
        if(!prodsRelated.isEmpty()){
            for(Product2 prods: prodsRelated){
                prodwithKey.put(prods.id,prods);    
            }   
        }
        
        //populating the fields of the OLI that is going to be created
        for(OpportunityLineItem OLI:oppOLIList){
            Opportunity oppty = OppwithKey.get(OLI.OpportunityId);
            Product2 prodRelated = prodwithKey.get(OLI.Product2Id);
            if(oppty.recordtype.developerName != Label.CUSeedsAllocationRecordType && oppty.recordtype.developerName != Label.Seeds_Allocation_Dist_RT && oppty.recordtype.developerName != Label.Seeds_Allocation_Territory && oppty.recordtype.developerName != Label.Account_Seeds_Allocation)
            {
                if(oppty.AccountBusinessPlan__r.Year__c != '' && oppty.AccountBusinessPlan__r.Year__c != null){
                    previousYear = String.Valueof(Integer.valueof(oppty.AccountBusinessPlan__r.Year__c) -1);
                    P_previousYear = String.Valueof(Integer.valueof(oppty.AccountBusinessPlan__r.Year__c) -2); 
                }
                //previousYear = String.Valueof(Integer.valueof(oppty.AccountBusinessPlan__r.Year__c) -1);
                //P_previousYear = String.Valueof(Integer.valueof(oppty.AccountBusinessPlan__r.Year__c) -2);
                
                //Category population for the matching key
                if(oppty.RecordType.DeveloperName == Label.GrowerCPSalesPlanRecordType || oppty.RecordType.DeveloperName == Label.GrowerSeedsSalesPlanRecordType){
                    Category = 'Grower OTG Sales'; 
                    priceCategory = 'SGP';
                }else if(oppty.RecordType.DeveloperName == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || 
                         oppty.RecordType.DeveloperName == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name || 
                         oppty.RecordType.DeveloperName == Label.RetailerSalesPlanRecordType || oppty.RecordType.DeveloperName == Label.Retailer_Seed_Sales_Plan){
                             Category = 'Retail OTG Sales'; 
                             priceCategory = 'SDP';
                         }else if(oppty.RecordType.DeveloperName ==Label.CP_Distributor_Sales_Plan || Oppty.RecordType.developername==Label.Seeds_Distributor_Sales_Plan){
                             Category = 'Channel Sales';  
                             priceCategory = 'SDP';
                             priceCategoryNSP = 'Net Sales'; 
                         }
                else
                {
                    Category = 'Area Sales';  
                    priceCategory = 'SDP';
                    priceCategoryNSP = 'Net Sales';
                }
                
                // Record type population for the matching key
                if(oppty.Product_Type__c == 'CP'){
                    Type = label.CP_Sales; 
                }else{
                    Type = label.Seeds_Sales;
                }
                
                //Matching key population
                if(oppty.RelatedDistributor__r.name!=null)
                {
                  oli.RelatedParentAccount__c= oppty.RelatedDistributor__r.name;  
                }
                else if(oppty.Related_Retailer__r.name !=null)
                {
                  oli.RelatedParentAccount__c= oppty.Related_Retailer__r.name; 
                }
                
                OLI.Unique_Key__c = oppty.Id + '|' + prodRelated.Id;
                OLI.SP_Matching_Key__c = oppty.Account.Account_ID__c+'|'+prodRelated.Product_ID__c+'|'+oppty.AccountBusinessPlan__r.Year__c+'|'+Category+'|'+Type;
                OLI.SP_Matching_Key_1__c = oppty.Account.Account_ID__c+'|'+prodRelated.Product_ID__c+'|'+previousYear+'|'+Category+'|'+Type;
                OLI.SP_Matching_Key_2__c = oppty.Account.Account_ID__c+'|'+prodRelated.Product_ID__c+'|'+P_previousYear+'|'+Category+'|'+Type;
                OLI.PL_MatchingKey__c = 'CA|'+prodRelated.Product_ID__c+'|'+priceCategory+'|'+OLI.Commercial_Unit__c+'|'+oppty.CurrentBusinessPlanYear__c;
                
                
                if(Category == 'Channel Sales' || Category == 'Area Sales')
                    OLI.PL_NSP_Matching_Key__c = 'CA|'+prodRelated.Product_ID__c+'|'+priceCategoryNSP+'|'+OLI.Commercial_Unit__c+'|'+oppty.CurrentBusinessPlanYear__c;
                OLIUpdated.add(OLI);  
                
                
                OLI.OLIallocationmatchingkey__c = oppty.Account.Account_ID__c+'|'+ oppty.AccountBusinessPlan__r.Year__c + '|' + prodRelated.Variety__c;
                
                OLI.Brand__c = prodRelated.Brand__c;
                OLI.Product_Line__c = prodRelated.Product_Line__c;
                OLI.Maturity__c = prodRelated.Maturity_Group__c;
                OLI.Field_UOM_Conversion__c = prodRelated.Volume_L__c;
                OLI.MinSaleableUOMConversion__c = prodRelated.Min_Saleable_UoM_Conversion__c;
                
            }
        }
    }
    
    /********************************************************************************************
* Method        updateOLIwithSPALookUp()          to updatethe OLI with the salesplan actual newlycreated for the OLI
* ------------------------------------------------------------------------------------------
* 19-Jan-2018    Sruthi Haridas                 Created
********************************************************************************************/
    //@future
    Public static void updateOLIwithSPALookUp(List<Id> OLIIdsToCreateSPA){
        //System.debug('Inside future method');
        List <OpportunityLineItem> OLItoUpdate = new List<OpportunityLineItem>();
        List <OpportunityLineItem> OLIToCreateSPA = [Select id,SalesPlanActual__c,SP_Matching_Key__c,SP_Matching_Key_1__c,SP_Matching_Key_2__c,PL_NSP_Matching_Key__c,
                                                     Opportunityid,UnitPrice,PL_MatchingKey__c,Price_List_NSP__c,RelatedOpportunityRecordType__c,PriceList_Lookup__c,Product2Id
                                                     FROM OpportunityLineItem Where Id in:OLIIdsToCreateSPA];
        if(!OLIToCreateSPA.isEmpty()){
            for(OpportunityLineItem OLI:OLIToCreateSPA){
                /*Removing if test because SPA for current year will likely already be filled in 
                if(OLI.SalesPlanActual__c == null){*/
                    OLItoUpdate.add(OLI);    
                /*}    */
            }
            //System.debug('trying to update');
            if(!OLItoUpdate.isEmpty()){
                updateOLICYactualsales(OLItoUpdate);
                updatePrcLstMtchKey(OLItoUpdate);
            }
            Database.upsert(OLItoUpdate);
        }    
    }
    
    
    /********************************************************************************************
* Method        updatePrcLstMtchKey()    Populate pricelist Unique key for the OLI
* ------------------------------------------------------------------------------------------
* 19-Jan-2018    Sruthi Haridas                 Created
********************************************************************************************/
    public static void updatePrcLstMtchKey(List<OpportunitylineItem> olis){
        List <String> OLIKey = new List<String>();
        
        If(!olis.isEmpty()){
            for(OpportunityLineItem oli : olis){
                OLIKey.add(oli.PL_MatchingKey__c);
                OLIKey.add(oli.PL_NSP_Matching_Key__c);
                //System.debug('The NSP matching key is '+oli.PL_NSP_Matching_Key__c);
            } 
        }
        
        List<Price_List__c> pricelst = [select Id,Price__c,Uniquekey__c,Product__r.id from Price_List__c where Uniquekey__c in : OLIKey];
        Map<String, Price_List__c> matchingKeyWithOLI = new Map<String, Price_List__c>();
        
        if(!pricelst.isEmpty()){
            for(Price_List__c prcLst: pricelst){   
                matchingKeyWithOLI.put(prcLst.Uniquekey__c, prcLst);
            }
        }
        
        for(OpportunityLineItem oli : olis){
            if(matchingKeyWithOLI.get(oli.PL_MatchingKey__c)!=null){
                oli.PriceList_Lookup__c = matchingKeyWithOLI.get(oli.PL_MatchingKey__c).id;
            }
            if(matchingKeyWithOLI.get(oli.PL_NSP_Matching_Key__c) != null){
                oli.Price_List_NSP__c = matchingKeyWithOLI.get(oli.PL_NSP_Matching_Key__c).id;
            }    
        }
    } 
}