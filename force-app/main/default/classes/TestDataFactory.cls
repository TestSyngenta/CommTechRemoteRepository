@isTest
public class TestDataFactory {
    
    public static Territory__c createTestTerritoryRecords(user assRep,String terrLevel,String nameTerr){
        if(terrLevel == 'L1:Commercial unit'){
            
            List<Territory__c> terr = new List<Territory__c>();
            terr = [Select Id,TerritoryLevel__c,Sales_Org__c,name,Assigned_Rep__c From Territory__c Where TerritoryLevel__c =: terrLevel AND name =: nameTerr Limit 1];
            if(terr.isEmpty()){
                Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name=nameTerr,Assigned_Rep__c=assRep.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
                insert L1;
                System.debug('L1.0::'+L1);
                return L1;
            }
            return terr[0];
        }
        
        else if(terrLevel == 'L2:District'){
            List<Territory__c> terr = new List<Territory__c>();
            terr = [Select Id,TerritoryLevel__c,Sales_Org__c,name,Assigned_Rep__c,CommercialUnit__c From Territory__c Where TerritoryLevel__c =: terrLevel AND name =: nameTerr Limit 1];
            if(terr.isEmpty()){
                String cuName = nameTerr.substring(0,nameTerr.length()-1);
                System.debug('cuName:::'+cuName);
                List<Territory__c> cuTerr = new List<Territory__c>();
                cuTerr = [Select Id,TerritoryLevel__c,Sales_Org__c,name,Assigned_Rep__c,CommercialUnit__c From Territory__c Where TerritoryLevel__c ='L1:Commercial unit' AND name =: cuName Limit 1];
                System.debug('cuTerr.0::'+cuTerr);
                if(cuTerr.isEmpty()){
                    Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name=cuName,Assigned_Rep__c=assRep.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
                    insert L1;
                    System.debug('L1.1::'+L1);
                    Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name=nameTerr,Assigned_Rep__c=assRep.Id,CommercialUnit__c=L1.Id);
                    
                    insert L2;
                    System.debug('L2.0::'+L2);
                    return L2;
                }
                else{
                    Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name=nameTerr,Assigned_Rep__c=assRep.Id,CommercialUnit__c=cuTerr[0].Id);
                    insert L2;
                    return L2;
                }
            }
            return terr[0];
        }
        
        else{
            List<Territory__c> terr = new List<Territory__c>();
            terr = [Select Id,TerritoryLevel__c,Sales_Org__c,name,Assigned_Rep__c,CommercialUnit__c From Territory__c Where TerritoryLevel__c =: terrLevel AND name =: nameTerr Limit 1];
            if(terr.isEmpty()){
                String cuName = nameTerr.substring(0,nameTerr.length()-2);
                String distName = nameTerr.substring(0,nameTerr.length()-1);
                System.debug('cuName.1:::'+cuName);
                System.debug('distName.1:::'+distName);
                List<Territory__c> cuTerr = new List<Territory__c>();
                cuTerr = [Select Id,TerritoryLevel__c,Sales_Org__c,name,Assigned_Rep__c,CommercialUnit__c From Territory__c Where TerritoryLevel__c ='L1:Commercial unit' AND name =: cuName Limit 1];
                List<Territory__c> disTerr = new List<Territory__c>();
                disTerr = [Select Id,TerritoryLevel__c,Sales_Org__c,name,Assigned_Rep__c,CommercialUnit__c From Territory__c Where TerritoryLevel__c ='L2:District' AND name =: distName Limit 1];
                System.debug('cuTerr.1::'+cuTerr);
                System.debug('disTerr.0::'+disTerr);
                if(cuTerr.isEmpty()){
                    Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name=cuName,Assigned_Rep__c=assRep.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
                    
                    insert L1;
                    System.debug('L1.2::'+L1);
                    Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name=distName,Assigned_Rep__c=assRep.Id,CommercialUnit__c=L1.Id);
                    
                    insert L2;
                    System.debug('L2.1::'+L2);
                    Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='1000',name=nameTerr,Assigned_Rep__c=assRep.Id,District__c=L2.Id,CommercialUnit__c=L1.Id);
                    insert L3;
                    System.debug('L3.0::'+L3);
                    return L3;
                }
                else if(!cuTerr.isEmpty() && disTerr.isEmpty()){
                    Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name=distName,Assigned_Rep__c=assRep.Id,CommercialUnit__c=cuTerr[0].Id);
                    insert L2;
                    System.debug('L2.2::'+L2);
                    Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='1000',name=nameTerr,Assigned_Rep__c=assRep.Id,District__c=L2.Id,CommercialUnit__c=cuTerr[0].Id);
                    insert L3;
                    System.debug('L3.1::'+L3);
                    return L3;
                }
                else{
                    Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='1000',name=nameTerr,Assigned_Rep__c=assRep.Id,District__c=disTerr[0].Id,CommercialUnit__c=cuTerr[0].Id);
                    insert L3;
                    System.debug('L3.2::'+L3);
                    return L3; 
                }
            }
            
            return terr[0];
        }
        
    }
    
    public static User createTestUserRecords(String terrCode,String profileName){
        //'System Administrator - Canada'
        Profile pf= [Select Id from profile where Name =: profileName];
        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        
        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        
        User RunningUser = new User(firstname = 'ABC', 
                                    lastName = 'XYZ', 
                                    email = uniqueName + '@test' + orgId + '.org', 
                                    Username = uniqueName + '@test' + orgId + '.org', 
                                    EmailEncodingKey = 'ISO-8859-1', 
                                    Alias = uniqueName.substring(18, 23), 
                                    TimeZoneSidKey = 'America/New_York', 
                                    LocaleSidKey = 'en_CA', 
                                    LanguageLocaleKey = 'en_US', 
                                    ProfileId = pf.Id, 
                                    user_country__c = 'CA',
                                    Territory_Code__c = terrCode
                                   ); 
        insert RunningUser;
        return RunningUser;
    }
    
    
    /*public static Map<Account,Account_Territory__c> createTestAccountRecords(String RecordTypeName,User testUser,String terrId){

Id recTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(RecordTypeName).getRecordTypeId();
Map<Account,Account_Territory__c> accAT = new Map<Account,Account_Territory__c>();
Account acc = new Account();
acc.Name = 'test_'+RecordTypeName+'_Account';
acc.RecordTypeId = recTypeId;
acc.OwnerId = testUser.Id;
acc.Territory_Lookup__c = terrId;
insert acc;

Account_Territory__c accTerr = new Account_Territory__c();
accTerr.account__c = acc.Id;
accTerr.Territory__c = terrId;
insert accTerr;

accAT.put(acc, accTerr);
return accAT;
}*/
    
    public static List<Account> createTestAccountsAndAccountTerritoryRecord(List<String> RecTypeName,User testUser,List<String> terrId){
        
        Map<Account,Account_Territory__c> accAT = new Map<Account,Account_Territory__c>();
        List<Account> accList = new List<Account>();
        if(RecTypeName.size()>0 && terrId.size()>0 && RecTypeName.size()==terrId.size()){
            for(Integer i=0;i<RecTypeName.size();i++){
                Id recTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get(RecTypeName[i]).getRecordTypeId();
                Account acc = new Account();
                acc.Name = 'test_'+RecTypeName[i]+'_Account';
                acc.RecordTypeId = recTypeId;
                acc.OwnerId = testUser.Id;
                acc.Territory_Lookup__c = terrId[i];
                acc.AllowSeedsplanning__c=true;
                acc.NSAP_ID__c  = String.valueOf(Math.round(Math.random()*10000000));
                accList.add(acc);
            }
        }
        insert accList;
        List<Account_Territory__c> accTerrList = new List<Account_Territory__c>();
        if(accList.size()>0){
            for(Integer i=0;i<accList.size();i++){
                Account_Territory__c accTerr = new Account_Territory__c();
                accTerr.account__c = accList[i].Id;
                accTerr.Territory__c = terrId[i];
                accTerrList.add(accTerr);
            }
        }
        insert accTerrList;
        
        return accList;
    }
    
    public static Pricebook2 createTestPriceBookRecords(String pbName){
        
        Pricebook2 pricebook = new Pricebook2(name = pbName,IsActive = true);
        insert pricebook;
        return pricebook;
    }
    
    public static Product2 createTestProductRecords(String recTypeName,String variety,String prodLine){
        Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();
        Product2 p1 = new Product2(Product_ID__c=String.valueOf(Math.round(Math.random()*10000000)),Volume_L__c=22.7,Variety__c=variety,Product_Line__c=prodLine,Product_Country__c='CA',Package_UOM__c='LT',Name='Test Product',Min_Saleable_UoM__c='LT',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
        insert p1;
        return p1;
    }
    
    public static SeedsAllocation__c createTestSeedsAllocationRecords(Territory__c l2Level,String variety,String year){
        SeedsAllocation__c seedAllo = new SeedsAllocation__c();
        seedAllo.district__c = l2Level.Id;
        seedAllo.Year__c = year;
        seedAllo.SeedAllocation__c = 1000;
        seedAllo.SeedsVariety__c = variety;
        insert seedAllo;
        return seedAllo;
    }
    
    public static PricebookEntry createTestPriceBookEntryRecords(Product2 prod,String pb){
        PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=prod.id,Pricebook2Id=pb,IsActive=true);
        insert pbe1;
        return pbe1;
    }
    
    public static Business_Plan__c createTestBusinessPlan(Id accId, String recTypeName,String year)
    {
        Id recTypeId = Schema.SObjectType.Business_Plan__c.getRecordTypeInfosByName().get(recTypeName).getRecordTypeId();
        Business_Plan__c bp = new Business_Plan__c(name = 'TestBP1' ,Year__c = year, Account__c = accId, RecordTypeId = recTypeId, Country__c = 'CA');  
        Insert bp;
        return bp;
    }
    
    public static Opportunity createTestOpportunityRecords(String recTypeName,String pbId,String Year,String terrId,User oppOwner,String accId){
        
        Id rt = [select id from Recordtype where developerName=:recTypeName limit 1].Id;
        Opportunity opp = new Opportunity();
        
        opp.Name = 'Test Opp';
        opp.Year__c = year;
        opp.StageName = 'Closed';
        opp.OwnerId = oppOwner.Id;
        opp.RecordTypeId = rt;
        opp.Territory__c = terrId;
        opp.CloseDate = System.today() + 90;
        opp.AccountId = accId;
        opp.Pricebook2Id = pbId;
        opp.Product_Type__c = 'CP';
        insert opp;
        return opp;
    }
    
    public static List<Opportunity> createTestOpportunityRecords(List<String> recTypeName,List<String> pbId,List<String> Year,List<String> terrId,List<User> oppOwner,List<String> accId){
        
        
        List<Opportunity> oppList = new List<Opportunity>();
        if(recTypeName.size() > 0 && pbId.size() > 0 && Year.size() > 0 && terrId.size() > 0 && oppOwner.size() > 0 && accId.size() > 0){
            for(Integer i=0;i < recTypeName.size();i++){
                Opportunity opp = new Opportunity();
                System.debug('recTypeName[i]:::'+recTypeName[i]);
                Id rt = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(recTypeName[i]).getRecordTypeId();
                opp.Name = 'Test Opp '+i;
                opp.Year__c = Year[i];
                opp.StageName = 'Closed';
                opp.OwnerId = oppOwner[i].Id;
                opp.RecordTypeId = rt;
                opp.Territory__c = terrId[i];
                opp.CloseDate = System.today() + 90;
                opp.AccountId = accId[i];
                opp.Pricebook2Id = pbId[i];
                oppList.add(opp);
            }
        }
        insert oppList;
        return oppList;
    }
    
    public static OpportunityLineItem createTestOpportunityLineItemRecords(Opportunity opp,PriceBookEntry pbe){
        OpportunityLineItem oli = new OpportunityLineItem();
        String Category = label.SeedsAllocation_Category;
        String Record_type = label.Seeds_Sales;
        if(opp.RecordType.Name == 'District Seeds Allocation'){
            oli.District__c = opp.Territory__c;
        }
        else{
            oli.Territory__c = opp.Territory__c;
        }
        oli.AllocatedBaselineUnits__c = 100;
        oli.OpportunityId = opp.Id;
        oli.OliMatchingKey__c = opp.AccountId+'|'+opp.Year__c+'|'+pbe.Product2.Variety__c;
        oli.SP_Matching_Key__c = opp.Account.Account_Id__c+'|'+pbe.Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c))+'|'+Category+'|'+Record_type;
        oli.SP_Matching_Key_1__c = opp.Account.Account_Id__c+'|'+pbe.Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c)-1)+'|'+Category+'|'+Record_type;
        oli.SP_Matching_Key_2__c = opp.Account.Account_Id__c+'|'+pbe.Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c)-2)+'|'+Category+'|'+Record_type;
        oli.PricebookEntryId = pbe.Id;
        oli.product2ID = pbe.Product2Id;
        oli.Quantity = Decimal.valueOf(1);
        oli.TotalPrice = Decimal.valueOf(1);
        oli.variety__c =pbe.Product2.Variety__c;
        
        insert oli;
        return oli;
    }
    
    public static List<OpportunityLineItem> createTestOpportunityLineItemListRecords(List<Opportunity> oppList,List<PriceBookEntry> pbe){
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        String Category = label.SeedsAllocation_Category;
        String Record_type = label.Seeds_Sales;
        Integer i = 0;
        for(Opportunity opp:oppList){
            OpportunityLineItem oli = new OpportunityLineItem();
            if(opp.RecordType.Name == 'District Seeds Allocation'){
                oli.District__c = opp.Territory__c;
            }
            else{
                oli.Territory__c = opp.Territory__c;
            }
            oli.AllocatedBaselineUnits__c = 100;
            oli.OpportunityId = opp.Id;
            oli.OliMatchingKey__c = opp.AccountId+'|'+opp.Year__c+'|'+pbe[i].Product2.Variety__c;
            oli.SP_Matching_Key__c = opp.Account.Account_Id__c+'|'+pbe[i].Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c))+'|'+Category+'|'+Record_type;
            oli.SP_Matching_Key_1__c = opp.Account.Account_Id__c+'|'+pbe[i].Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c)-1)+'|'+Category+'|'+Record_type;
            oli.SP_Matching_Key_2__c = opp.Account.Account_Id__c+'|'+pbe[i].Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c)-2)+'|'+Category+'|'+Record_type;
            oli.PricebookEntryId = pbe[i].Id;
            oli.product2ID = pbe[i].Product2Id;
            oli.Quantity = Decimal.valueOf(1);
            oli.TotalPrice = Decimal.valueOf(1);
            oli.variety__c =pbe[i].Product2.Variety__c;
            i++;
            oliList.add(oli);
        }
        
        insert oliList;
        return oliList;
    }
    public static OpportunityLineItem createTestOpportunityLineItemRecord(Opportunity opp, PriceBookEntry pbe,String SPrecType, String category){
        OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=opp.Id;
            opplnitem.PriceBookEntryId=pbe.Id;
            opplnitem.Product_Line__c = 'Seed';
            opplnitem.Actual_QTY__c = 1000;
            opplnitem.AllocatedBaselineUnits__c = 5000.0 ;
            opplnitem.Ending_Inventory_CY__c = 500 ;
            opplnitem.CY_Planned_Sales1__c = 6000 ;
            opplnitem.CY_1_Forecast_Sales__c = 8000; 
            opplnitem.Ending_Inventory_CY_1__c = 1234 ;
            opplnitem.FNS_CY_ALCTD__c = 3456 ;
            opplnitem.FNS_CY__c = 2345 ;
            opplnitem.OTG_FRCST_CY__c = 200 ;
            //opplnitem.OTGForecastLitresCY__c = 2000 ;
            opplnitem.PreviousUpdatedUnits__c = 3500 ;
            opplnitem.Q4_Planned_Ship_CY__c = 3500 ;
            opplnitem.Updated_OTG_Forecast_CY__c = 4000 ;
            opplnitem.Volume_Estimate_CY_1__c = 6500 ;
            opplnitem.Ending_Inventory_Projection_CY__c = 6000 ;
            opplnitem.OTG_Growth_PER__c = 5 ;
            opplnitem.CY_1_Planned_Sales__c = 3500 ;
            opplnitem.CY_1_Whole_Sale_OTG_Units__c  = 4500 ;
            opplnitem.CY_1_Wholesale_Inventory_Units__c = 6800 ;
            opplnitem.plnd_CY_stock_odr__c = 8654 ;
            opplnitem.CY_Stock_Odr__c = 543 ;
            opplnitem.Rolled_up_CY_Planned_Sales__c = 567 ;
            opplnitem.Rolled_up_CY_1_Forecast_Sales__c = 4321 ;
            opplnitem.Rolled_Up_Ending_Inventory_CY_1__c = 346 ;
            opplnitem.Rtlr_CY_Alctd__c = 560 ;
            opplnitem.Rtlr_Plnd_CY_Q4_Ship__c = 654 ;
            opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            opplnitem.OliMatchingKey__c = opp.AccountId+'|'+opp.Year__c+'|'+pbe.Product2.Variety__c;
        opplnitem.SP_Matching_Key__c = opp.Account.Account_Id__c+'|'+pbe.Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c))+'|'+category+'|'+SPrecType;
        opplnitem.SP_Matching_Key_1__c = opp.Account.Account_Id__c+'|'+pbe.Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c)-1)+'|'+category+'|'+SPrecType;
        opplnitem.SP_Matching_Key_2__c = opp.Account.Account_Id__c+'|'+pbe.Product2.Product_ID__c+'|'+(Integer.valueOf(opp.Year__c)-2)+'|'+category+'|'+SPrecType;
        opplnitem.PricebookEntryId = pbe.Id;
        opplnitem.product2ID = pbe.Product2Id;
        opplnitem.Quantity = Decimal.valueOf(1);
        opplnitem.TotalPrice = Decimal.valueOf(1);
        opplnitem.variety__c =pbe.Product2.Variety__c;

        Insert opplnitem;
        return opplnitem;
        
    }
    public static Sales_Plan_Actual__c createTestSalesPlanActualRecord (String accId, String prodId, String year)
    {
        Sales_Plan_Actual__c spaRecord = new Sales_Plan_Actual__c();
        spaRecord.Account__c = accId;
        spaRecord.Year__c = year;
        spaRecord.Product__c = prodId;
        spaRecord.Units__c = 1;
        insert spaRecord;
        /*Sales_Plan_Actual__c spaRecord2 = [select Account__c, Year__c, Product__c, Units__c, Blank_SPA_Filter__c from Sales_Plan_Actual__c where Id=:spaRecord.Id];*/
        return spaRecord;
    }
    
    
   public static SeedsAllocation__c createTestSeedsAllocationRecord(String CommercialUnit,Id districtId,Double seedAllocations, String seedsVariety,String year){
       SeedsAllocation__c seedsAlloc = new SeedsAllocation__c(CommercialUnit1__c = CommercialUnit,District__c = districtId,SeedAllocation__c = seedAllocations,SeedsVariety__c = seedsVariety, Year__c = year);
                return seedsAlloc;
    }
    
}