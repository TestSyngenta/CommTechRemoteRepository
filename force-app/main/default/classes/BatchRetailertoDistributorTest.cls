@isTest

Public class BatchRetailertoDistributorTest {
    static TestMethod void BatchRetailertoDistributorTest(){
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
            
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Distributor'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.Id );
            insert a1;            
            RecordType rct6 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct6.Id );
            insert a2;
            
        
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l3.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1=new Account_Territory__c();
            acctrr.Account__c=a2.id;
            acctrr.Territory__c=l3.Id;
            insert acctrr1;
            
            
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Distributor_Business_Plan'];
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp2;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'DistributorSeedsSalesPlan'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp2.id;
            oppr.CloseDate = closeDt;
            oppr.Product_Type__c = 'Seeds';
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L3.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            
            RecordType rct3 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP2' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct3.id, Country__c = 'CA');  
            Insert bp1;
            
            RecordType rct4 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp3';
            oppr1.AccountId= a2.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp1.id;
            oppr1.CloseDate = closeDt;
            oppr1.RecordTypeId =rct4.id;
            oppr1.Year__c='2018'; 
            oppr1.Territory__c=L3.id;
            oppr1.Product_Type__c = 'Seeds';
            oppr1.PriceBook2Id = seedpricebook.id;
            oppr1.RelatedDistributor__c = a1.Id;
            oppr1.RelatedDistributorPlan__c = oppr.id;
            insert oppr1;  
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.Actual_QTY__c = 1000;
            opplnitem.AllocatedBaselineUnits__c = 5000.0 ;
            opplnitem.Ending_Inventory_CY__c = 500 ;
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
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
                       
            
            
            
            test.startTest();
            insert oli; 
            /*opplnitem.Actual_QTY__c = 2000;
            update oli;            */
            /*BatchRetailertoDistributor BIO = new BatchRetailertoDistributor(oppr.Id);
            Database.executeBatch(BIO);*/
            test.stopTest();
        }
    }
    static TestMethod void BatchRetailertoDistributorTest1(){
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Distributor'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.Id );
            insert a1;  
            
            test.startTest();
            try{
                BatchRetailertoDistributor BIO = new BatchRetailertoDistributor(a1.Id);
                Database.executeBatch(BIO);
            }
            catch(Exception e){
                System.assertEquals('Attempt to de-reference a null object', e.getMessage());
            }
            test.stopTest();
        }
    }

}