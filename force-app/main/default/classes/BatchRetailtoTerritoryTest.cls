@isTest
public class BatchRetailtoTerritoryTest {
    public Static Opportunity oppr;
    static TestMethod void BatchRetailtoTerritoryTest(){
        
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            OpportunityLineItem opplnitem = insertTestData(RunningUser,true);
            test.startTest();
            opplnitem.AllocatedBaselineUnits__c = 5000 ;
            update opplnitem;
            BatchRetailtoTerritory BIO = new BatchRetailtoTerritory(oppr.Id);
            Database.executeBatch(BIO);
            test.stopTest();
            
        }
    }
    
    static TestMethod void BatchRetailtoTerritoryTest1(){
       
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            OpportunityLineItem opplnitem = insertTestData(RunningUser,false);
            test.startTest();
            BatchRetailtoTerritory BIO = new BatchRetailtoTerritory(oppr.Id);
            Database.executeBatch(BIO);
            test.stopTest();
        }
    }
    
    static TestMethod void BatchRetailtoTerritoryTest2(){
       
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            Id accRecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
            Account acc = new Account(Name='Test Account',RecordtypeId = accRecType);
            insert acc;
            test.startTest();
            try{
                BatchRetailtoTerritory BIO = new BatchRetailtoTerritory(acc.Id);
                Database.executeBatch(BIO);
            }
            catch(Exception e){
                System.assertEquals('Attempt to de-reference a null object', e.getMessage());
            }
            test.stopTest();
        }
    }
    
    
    static OpportunityLineItem insertTestData(User RunningUser, Boolean seedProduct){
        Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
        
        Product2 p1 = TestDataFactory.createTestProductRecords((seedProduct == true)?'Seeds Product':'CP Product', 'SY ROWYN', 'Seed');
        Product2 p2 = TestDataFactory.createTestProductRecords((seedProduct == true)?'Seeds Product':'CP Product', 'SY087', 'Seed');
        
            PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c,CPPriceBookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
            
            Pricebook2 seedpricebook = (seedProduct == true)?new Pricebook2(id=custommetadata.seeds_price_bookId__c,name='Seeds Price Book',IsActive = true):new Pricebook2(id=custommetadata.CPPriceBookID__c,name='CP and SeedCare Price Book',IsActive = true);
            upsert seedpricebook;
            
            id stdpricebook = Test.getStandardPricebookId();
            
            List<PricebookEntry> pbelist = new List<PricebookEntry>();
            pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p1, stdpricebook));
            pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p2, stdpricebook));
            pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p1, seedpricebook.Id));
            pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p2, seedpricebook.Id));
        
        List<Account> accList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(new List<String>{'Retailer','Planning Account'}, RunningUser, new List<String>{L3.Id,L3.Id});
            
            Date closeDt = Date.Today();
            
            Business_Plan__c bp = TestDataFactory.createTestBusinessPlan(accList[1].Id,'Territory Business Plan', '2018');
        oppr = new opportunity();
            oppr = TestDataFactory.createTestOpportunityRecords(Label.Territory_Seeds_Sales_Plan, seedpricebook.id, String.valueOf(closeDt.year()) , L3.Id, RunningUser, accList[1].Id);
            oppr.AccountBusinessPlan__c = bp.id;
            oppr.Product_Type__c = (seedProduct==true)?'Seeds':'CP';
            
            update oppr;
            
            List<Opportunity> updateopp=[select id, Name, RecordTypeId from Opportunity where id =: oppr.Id];
            system.debug('**************************'+updateopp);
            
            Business_Plan__c bp1 = TestDataFactory.createTestBusinessPlan(accList[0].Id,'Retailer Business Plan', '2018');
        
            opportunity oppr1 = TestDataFactory.createTestOpportunityRecords(Label.Retailer_Seed_Sales_Plan, seedpricebook.id, String.valueOf(closeDt.year()) , L3.Id, RunningUser, accList[0].Id);
            oppr1.AccountBusinessPlan__c = bp1.id;
            oppr1.RelatedTerritoryPlan__c =oppr.id;
            oppr1.Product_Type__c = (seedProduct==true)?'Seeds':'CP';
            
            update oppr1;
        List<opportunityLineItem> oli = new List<opportunityLineItem>();
        for(Integer i=1;i<4;i++){
           
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=(i==1)?oppr.Id:oppr1.Id;
            opplnitem.PriceBookEntryId=(i==1)?pbeList[2].Id:pbeList[i].Id;
            opplnitem.Product_Line__c = 'Seed';
            opplnitem.Actual_QTY__c = 1000;
            opplnitem.AllocatedBaselineUnits__c = 5000.0 ;
            opplnitem.Ending_Inventory_CY__c = 500 ;
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
            /*opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            oli.add(opplnitem);
        }
        
            insert oli;  
            List<OpportunityLineItem> updateoliList=[select id,product2id,SP_Matching_Key__c,SP_Matching_Key_1__c,SP_Matching_Key_2__c,PL_MatchingKey__c,PL_NSP_Matching_Key__c from OpportunityLineItem where opportunityid=:oppr1.Id]; 
            system.debug('OpportunityLineItem Pratibha'+updateoliList);
            return oli[1];
    }
    
}