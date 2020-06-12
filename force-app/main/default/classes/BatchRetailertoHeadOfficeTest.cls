@isTest
public class BatchRetailertoHeadOfficeTest {
    public Static Opportunity oppr;
    
    static TestMethod void BatchRetailertoHeadOfficeTest(){
        
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            OpportunityLineItem opplnitem = insertTestData(RunningUser,true);
            test.startTest();
            opplnitem.AllocatedBaselineUnits__c = 5000 ;
            update opplnitem;
            set<Id> prodids=new set<Id>();
            prodids.add(opplnitem.Product2Id);
            RetailertoHeadOfficeNoBatch BIO = new RetailertoHeadOfficeNoBatch(oppr.Id,prodids);
            BIO.start();
            test.stopTest();
            
        }
    }
    
    static TestMethod void BatchRetailertoHeadOfficeTest1(){
        
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            OpportunityLineItem opplnitem = insertTestData(RunningUser,false);
            test.startTest();
            set<Id> prodids=new set<Id>();
            prodids.add(opplnitem.Product2Id);
            RetailertoHeadOfficeNoBatch BIO = new RetailertoHeadOfficeNoBatch(oppr.Id,prodids);
            BIO.start();
            test.stopTest();
        }
    }
    
    static TestMethod void BatchRetailertoHeadOfficeTest2(){
        
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {   
            /* OpportunityLineItem opplnitem = insertTestData(RunningUser,true);
Set<Id> oli = new Set<Id>();
oli.add(opplnitem.Product2Id);*/
            Id accRecType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
            Account acc = new Account(Name='Test Account',RecordtypeId = accRecType);
            insert acc;
            test.startTest();
            try{
                set<Id> prodids=new set<Id>();
                RetailertoHeadOfficeNoBatch BIO = new RetailertoHeadOfficeNoBatch(acc.Id,prodids);
                BIO.start();
                
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
        
        RecordType accrct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
        Account a1 = new Account(Name ='Test1', RecordTypeId = accrct.Id);
        insert a1;            
        
        Account a2 = new Account(Name ='Test2', RecordTypeId = accrct.Id);
        insert a2;
        
        Account_Territory__c acctrr=new Account_Territory__c();
        acctrr.Account__c=a1.id;
        acctrr.Territory__c=l3.Id;
        insert acctrr;
        
        Account_Territory__c acctrr1=new Account_Territory__c();
        acctrr.Account__c=a2.id;
        acctrr.Territory__c=l3.Id;
        acctrr.Head_Office_Account__c = a1.id;
        insert acctrr1;
        
        
        Date closeDt = Date.Today();
        
        Business_Plan__c bp = TestDataFactory.createTestBusinessPlan(a1.Id,'Retailer Business Plan', '2018');
        oppr = new opportunity();
        oppr = TestDataFactory.createTestOpportunityRecords(Label.Retailer_Seed_Sales_Plan, seedpricebook.id, String.valueOf(closeDt.year()) , L3.Id, RunningUser, a1.Id);
        oppr.AccountBusinessPlan__c = bp.id;
        oppr.Product_Type__c = (seedProduct==true)?'Seeds':'CP';
        
        update oppr;
        
        List<Opportunity> updateopp=[select id, Name, RecordTypeId from Opportunity where id =: oppr.Id];
        system.debug('**************************'+updateopp);
        
        Business_Plan__c bp1 = TestDataFactory.createTestBusinessPlan(a2.Id,'Retailer Business Plan','2018');
        
        opportunity oppr1 = TestDataFactory.createTestOpportunityRecords(Label.Retailer_Seed_Sales_Plan, seedpricebook.id, String.valueOf(closeDt.year()) , L2.Id, RunningUser, a2.Id);
        oppr1.AccountBusinessPlan__c = bp1.id;
        oppr1.RelHeadOfficePlan__c = oppr.id;
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
            opplnitem.CY_Planned_Sales1__c = 6000 ;
            opplnitem.CY_1_Forecast_Sales__c = 8000; 
            opplnitem.Ending_Inventory_CY_1__c = 1234 ;
            opplnitem.FNS_CY_ALCTD__c = 3456 ;
            opplnitem.FNS_CY__c = 2345 ;
            opplnitem.OTG_FRCST_CY__c = 200 ;
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
            oli.add(opplnitem);
        }
        
        insert oli;  
        List<OpportunityLineItem> updateoliList=[select id,product2id,SP_Matching_Key__c,SP_Matching_Key_1__c,SP_Matching_Key_2__c,PL_MatchingKey__c,PL_NSP_Matching_Key__c from OpportunityLineItem where opportunityid=:oppr1.Id]; 
        system.debug('OpportunityLineItem Pratibha'+updateoliList);
        return oli[1];
    }
    
   static TestMethod void RetailertoHeadOfficeTest1(){
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        System.runAs(RunningUser)
        {
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            insert p1;
            Insert p2;
            
            PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
            
            Pricebook2 seedpricebook = new Pricebook2(id=custommetadata.seeds_price_bookId__c,name='Seeds Price Book',IsActive = true);
            upsert seedpricebook;
            
            id stdpricebook = Test.getStandardPricebookId();
            
            PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe3=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=stdpricebook,IsActive=true);
            PricebookEntry pbe4=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=stdpricebook,IsActive=true);    
            
            insert pbe3;
            insert pbe4;
            insert pbe2;
            insert pbe1;
            
            Date closeDt = Date.Today();
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.Id );
            insert a1;            
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct5.Id );
            insert a2;
            
            
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l1.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1=new Account_Territory__c();
            acctrr1.Account__c=a2.id;
            acctrr1.Territory__c=l2.Id;
            acctrr1.Head_Office_Account__c = a1.id;
            insert acctrr1; 
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp1;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp1.id;
            oppr.CloseDate = closeDt;
            oppr.Product_Type__c = 'CP';
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L3.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp2;
            RecordType rct3 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp4';
            oppr1.AccountId= a2.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp2.id;
            oppr1.CloseDate = closeDt;
            oppr1.Product_Type__c = 'CP';
            oppr1.RecordTypeId =rct3.id;
            oppr1.Year__c='2018'; 
            oppr1.Territory__c=L3.id;
            oppr1.PriceBook2Id = seedpricebook.id;
            oppr1.RelHeadOfficePlan__c = oppr.id;
            insert oppr1;  
            
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.Product_Line__c = 'Seed';
            opplnitem.Product2Id = p1.Id ;
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
            
            Test.startTest();
            insert opplnitem;
            Test.stopTest();
            
        }
    }
    
       static TestMethod void RetailertoHeadOfficeTest(){
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        System.runAs(RunningUser)
        {
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            insert p1;
            Insert p2;
            
            PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
            
            Pricebook2 seedpricebook = new Pricebook2(id=custommetadata.seeds_price_bookId__c,name='Seeds Price Book',IsActive = true);
            upsert seedpricebook;
            
            id stdpricebook = Test.getStandardPricebookId();
            
            PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe3=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=stdpricebook,IsActive=true);
            PricebookEntry pbe4=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=stdpricebook,IsActive=true);    
            
            insert pbe3;
            insert pbe4;
            insert pbe2;
            insert pbe1;
            
            Date closeDt = Date.Today();
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.Id );
            insert a1;            
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct5.Id );
            insert a2;
            
            
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l1.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1=new Account_Territory__c();
            acctrr1.Account__c=a2.id;
            acctrr1.Territory__c=l2.Id;
            acctrr1.Head_Office_Account__c = a1.id;
            insert acctrr1; 
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp1;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp1.id;
            oppr.CloseDate = closeDt;
            oppr.Product_Type__c = 'CP';
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L3.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp2;
            RecordType rct3 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp4';
            oppr1.AccountId= a2.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp2.id;
            oppr1.CloseDate = closeDt;
            oppr1.Product_Type__c = 'CP';
            oppr1.RecordTypeId =rct3.id;
            oppr1.Year__c='2018'; 
            oppr1.Territory__c=L3.id;
            oppr1.PriceBook2Id = seedpricebook.id;
            oppr1.RelHeadOfficePlan__c = oppr.id;
            insert oppr1;  
            
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.Product_Line__c = 'Seed';
            opplnitem.Product2Id = p1.Id ;
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
            
            Set<Id> oli = new Set<Id>();
            oli.add(opplnitem.Product2Id);
            Test.startTest();
              
            try{
                set<Id> prodids=new set<Id>();
                RetailertoHeadOfficeNoBatch BIO = new RetailertoHeadOfficeNoBatch(a1.Id,prodids);
                BIO.start();
            }
            catch(Exception e){
                System.assertEquals('Attempt to de-reference a null object', e.getMessage());
            }
            
            Test.stopTest();
            
        }
    }
    
}