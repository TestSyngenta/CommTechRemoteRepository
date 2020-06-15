@isTest
public class populateOLIHandlerTest {
    static User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
    static TestMethod void populateOLIHandlerTest(){      
        
        System.runAs(RunningUser)
        {
             
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='A633',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            List<Territory__c> Terr = new List<Territory__c>();
            /*Terr.add(L1);*/
            Terr.add(L2);
            Terr.add(L3);
            insert Terr;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Crop_Group__c cg = new Crop_Group__c();
            cg.Name= 'Corn';
            cg.Description__c = 'Grouped with Acorn, Almond, Beech, Brazil nut, Candlenut';
            insert cg;
            
            Crop_Return_Provision__c crp = new Crop_Return_Provision__c();
            crp.CropGroup__c = cg.Id ;
            crp.ECUReturnProvision__c = 0.06;
            crp.WCUReturnProvision__c = 0.02;
            insert crp;
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true, PrimaryECUCrop__c = cg.id, PrimaryWCUCrop__c = cg.id);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true, PrimaryECUCrop__c = cg.id, PrimaryWCUCrop__c = cg.id);
            List<Product2> prod = new List<Product2>();
            prod.add(p1);
            prod.add(p2);
            insert prod;
            
            List<Product2> productlist = new List<Product2>();
            for (Integer i=0; i<102; i++){
                Product2 p = new Product2(Product_ID__c='123'+i,Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
                productlist.add(p);                
            }
            insert productlist;
            system.debug('productlist'+productlist);
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
            
            
            List<PricebookEntry> pbeList1 = new List<PricebookEntry>();
            For(Product2 Pr: productlist){
                PricebookEntry pricebook=new PricebookEntry(UnitPrice=1,Product2Id=pr.id,Pricebook2Id=stdpricebook,IsActive=true); 
                pbeList1.add(pricebook);  
            }
            insert pbeList1;
            
            
            Date closeDt = Date.Today();
            
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Distributor'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.Id );
            insert a1;            
            RecordType rct6 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct6.Id );
            insert a2;
            
            
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l1.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1=new Account_Territory__c();
            acctrr.Account__c=a2.id;
            acctrr.Territory__c=l2.Id;
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
            
            OpportunityLineItem opplnitem1=new OpportunityLineItem();
            opplnitem1.CY_Planned_Sales1__c=1000;
            opplnitem1.CY_1_Forecast_Sales__c=2000;
            opplnitem1.OpportunityId=oppr.Id;
            opplnitem1.PriceBookEntryId=pbe2.Id;
            opplnitem1.Product_Line__c = 'Seed';
            opplnitem1.Actual_QTY__c = 1000;
            opplnitem1.AllocatedBaselineUnits__c = 5000 ;
            opplnitem1.Ending_Inventory_CY__c = 500 ;
            opplnitem1.CY_Planned_Sales1__c = 6000 ;
            opplnitem1.CY_1_Forecast_Sales__c = 8000; 
            opplnitem1.Ending_Inventory_CY_1__c = 1234 ;
            opplnitem1.FNS_CY_ALCTD__c = 3456 ;
            opplnitem1.FNS_CY__c = 2345 ;
            opplnitem1.OTG_FRCST_CY__c = 200 ;
            //opplnitem.OTGForecastLitresCY__c = 2000 ;
            opplnitem1.PreviousUpdatedUnits__c = 3500 ;
            opplnitem1.Q4_Planned_Ship_CY__c = 3500 ;
            opplnitem1.Updated_OTG_Forecast_CY__c = 4000 ;
            opplnitem1.Volume_Estimate_CY_1__c = 6500 ;
            opplnitem1.Ending_Inventory_Projection_CY__c = 6000 ;
            //opplnitem.OTG_Growth_PER__c = 5 ;
            opplnitem1.CY_1_Planned_Sales__c = 3500 ;
            opplnitem1.CY_1_Whole_Sale_OTG_Units__c  = 4500 ;
            opplnitem1.CY_1_Wholesale_Inventory_Units__c = 6800 ;
            opplnitem1.plnd_CY_stock_odr__c = 8654 ;
            opplnitem1.CY_Stock_Odr__c = 543 ;
            opplnitem1.Rolled_up_CY_Planned_Sales__c = 567 ;
            opplnitem1.Rolled_up_CY_1_Forecast_Sales__c = 4321 ;
            opplnitem1.Rolled_Up_Ending_Inventory_CY_1__c = 346 ;
            opplnitem1.Rtlr_CY_Alctd__c = 560 ;
            opplnitem1.Rtlr_Plnd_CY_Q4_Ship__c = 654 ;
            /*opplnitem1.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem1.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem1.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            opplnitem1.Crop_Return_Provision__c = crp.Id;
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
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
            /*opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            opplnitem.Crop_Return_Provision__c = crp.id;
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            oli.add(opplnitem1);
            insert oli;         
            
            PageReference pageRef = Page.PopulateOli;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c); 
            
            
            
            Test.startTest();
            PopulateOLIHandler spc = new PopulateOLIHandler(sc);     
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp2.Id);
            spc.createOlis();
            spc.createOlisFromPastData();
            PopulateOLIHandler.populateCropProvision(oli);
            Test.stopTest();
        }
        
        
    }
    static TestMethod void populateOLIHandlerTest1(){
        
        System.runAs(RunningUser)
        {
            
            /*Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'*/
            
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='A633',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            insert p1;
            Insert p2;
            
            /*List<Product2> productlist = new List<Product2>();
for (Integer i=0; i<102; i++){
Product2 p = new Product2(Product_ID__c='123'+i,Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
productlist.add(p);                
}
insert productlist;*/
            
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
            
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'PlanningAccount'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.id);
            insert a1;                        
            
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct5.id);
            insert a2;
            
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'District_Business_Plan'];
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp2;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'District_Seeds_Sales_Plan'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp2.id;
            oppr.CloseDate = closeDt;
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L2.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            
            RecordType rct2 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Territory_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP2' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct2.id, Country__c = 'CA');  
            Insert bp1;
            
            RecordType rct3 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'Territory_Seeds_Sales_Plan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp3';
            oppr1.AccountId= a2.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp1.id;
            oppr1.CloseDate = closeDt;
            oppr1.RecordTypeId =rct3.id;
            oppr1.Territory__c=L3.id;
            oppr1.PriceBook2Id = seedpricebook.id;
            oppr1.RelatedTerritoryPlan__c = oppr.id;
            oppr1.Year__c='2018';
            insert oppr1;         
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.Product_Line__c = 'Seed';
            //opplnitem.Product2Id = 'p1.Id' ;
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
            /*opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            // oli.add(opplnitem1);
            insert oli;
            
            PageReference pageRef = Page.PopulateOli;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c); 
            
            
            
            Test.startTest();
            PopulateOLIHandler spc = new PopulateOLIHandler(sc);     
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp2.Id);
            spc.createOlis();
            spc.createOlisFromPastData();
            PopulateOLIHandler.populateCropProvision(oli);
            Test.stopTest();
            
        }
    }
    
    static TestMethod void populateOLIHandlerTest2(){
        
        System.runAs(RunningUser)
        {
            
            
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='A633',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
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
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'PlanningAccount'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct5.Id );
            insert a1;            
            RecordType rct6 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Distributor'];
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct6.Id );
            insert a2;
            
            
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l1.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1=new Account_Territory__c();
            acctrr.Account__c=a2.id;
            acctrr.Territory__c=l2.Id;
            insert acctrr1; 
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CU_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp1;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'CUSeedsSalesPlan'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp1.id;
            oppr.CloseDate = closeDt;
            oppr.Product_Type__c = 'Seeds';
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L3.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            
            RecordType rct2 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Distributor_Business_Plan'];
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP5' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct2.id, Country__c = 'CA');  
            Insert bp2;
            RecordType rct3 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'DistributorSeedsSalesPlan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp4';
            oppr1.AccountId= a1.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp2.id;
            oppr1.CloseDate = closeDt;
            oppr1.Product_Type__c = 'Seeds';
            oppr1.RecordTypeId =rct3.id;
            oppr1.Year__c='2018'; 
            oppr1.Territory__c=L3.id;
            oppr1.PriceBook2Id = seedpricebook.id;
            oppr1.RelatedCUPlan__c = oppr.id;
            insert oppr1;  
            
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.Product_Line__c = 'Seed';
            //opplnitem.Product2Id = 'p1.Id' ;
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
            /*opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            insert oli;
            
            PageReference pageRef = Page.PopulateOli;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c); 
            
            
            
            Test.startTest();
            PopulateOLIHandler spc = new PopulateOLIHandler(sc);     
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp1.Id);
            spc.createOlis();
            spc.createOlisFromPastData();
            PopulateOLIHandler.populateCropProvision(oli);
            Test.stopTest();
            
        }
    }
    static TestMethod void populateOLIHandlerTest3(){
        
        System.runAs(RunningUser)
        {
            
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='A633',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
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
            
            RecordType rct7 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a1 = new Account(Name ='testing account', RecordTypeId = rct7.id);
            insert a1;            
            RecordType rct5 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'PlanningAccount'];
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct5.id);
            insert a2;
            
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l3.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1=new Account_Territory__c();
            acctrr.Account__c=a2.id;
            acctrr.Territory__c=l3.Id;
            insert acctrr1;
            
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Territory_Business_Plan'];   
            Business_Plan__c bp = new Business_Plan__c(name = 'TestBP' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'Territory_Seeds_Sales_Plan'];       
            opportunity oppr = new opportunity();
            oppr.Name='testing opp2';
            oppr.AccountId= a2.Id;
            oppr.StageName = 'Won';
            oppr.CloseDate = closeDt;
            oppr.RecordTypeId= rct1.Id;
            oppr.Product_Type__c = 'Seeds';
            oppr.Year__c = '2018';
            oppr.Territory__c=L3.id;
            oppr.AccountBusinessPlan__c = bp.id;
            insert oppr;
            
            List<opportunity> opprlist = [select id,CommercialUnit__c,Year__c,RecordType.DeveloperName,Product_Type__c,Account.Account_ID__c from opportunity where id=:oppr.id];
            system.debug('List of Opportunity'+opprlist);
            
            RecordType rct3 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP2' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct3.id, Country__c = 'CA');  
            Insert bp1;
            
            RecordType rct4 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp3';
            oppr1.AccountId= a1.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp1.id;
            oppr1.CloseDate = closeDt;
            oppr1.RecordTypeId =rct4.id;
            oppr1.Year__c='2018';
            oppr1.Product_Type__c = 'Seeds';
            oppr1.Territory__c=L3.id;
            oppr1.PriceBook2Id = seedpricebook.id;
            oppr1.RelatedTerritoryPlan__c = oppr.id;
            insert oppr1;
            
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.CY_Planned_Sales1__c=1000;
            opplnitem.CY_1_Forecast_Sales__c=2000;
            opplnitem.OpportunityId=oppr1.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.Product_Line__c = 'Seed';
            //opplnitem.Product2Id = 'p1.Id' ;
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
            /*opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            insert oli; 
            
            PageReference pageRef = Page.PopulateOli;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c); 
            
            
            
            Test.startTest();
            PopulateOLIHandler spc = new PopulateOLIHandler(sc);     
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp.Id);
            spc.createOlis();
            spc.createOlisFromPastData();
            PopulateOLIHandler.populateCropProvision(oli);
            Test.stopTest();
        }
    }
    static TestMethod void populateOLIHandlerTest4(){
        
        System.runAs(RunningUser)
        {
            
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='A633',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
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
            
            List<Syngenta_Product__c> spList = new List<Syngenta_Product__c>();        
            Syngenta_Product__c sp1 = new Syngenta_Product__c(Products__c = p1.Id, Year__c = '2018',Commercial_Unit__c='A633',ProductType__c='Seeds');
            Syngenta_Product__c sp2 = new Syngenta_Product__c(Products__c = p2.Id, Year__c = '2018',Commercial_Unit__c='A633',ProductType__c='Seeds');
            spList.add(sp1);
            spList.add(sp2);
            insert spList;  
            
            Date closeDt = Date.Today();
            
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
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp1;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp1.id;
            oppr.CloseDate = closeDt;
            oppr.Product_Type__c = 'Seeds';
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L3.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2018', Account__c = a2.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp2;
            RecordType rct3 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'RetailerSeedsSalesPlan'];
            opportunity oppr1 = new opportunity();
            oppr1.Name='testing opp4';
            oppr1.AccountId= a2.Id;
            oppr1.StageName = 'Acquire';
            oppr1.AccountBusinessPlan__c = bp2.id;
            oppr1.CloseDate = closeDt;
            oppr1.Product_Type__c = 'Seeds';
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
            //opplnitem.Product2Id = 'p1.Id' ;
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
            /*opplnitem.CYProjectedEndingInventoryUnits__c = 533 ;*/
            opplnitem.Rolled_Up_CY_1_OTG_Sales_c__c = 33 ;
            opplnitem.Rolled_Up_CY_2_OTG_Sales_c__c = 60;
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            insert oli; 
            
            
                 
            
            
            /*Sales_Plan_Actual__c spa4 = new Sales_Plan_Actual__c(Account__c=a2.Id , Product__c=p1.Id , Year__c = '2017', Units__c = 5);
            Sales_Plan_Actual__c spa5 = new Sales_Plan_Actual__c(Account__c=a2.Id , Product__c=p1.Id , Year__c = '2018', Units__c = 6);
            List<Sales_Plan_Actual__c> spaList = new List<Sales_Plan_Actual__c>();
            spaList.add(spa4);
            spaList.add(spa5);
            
            insert spaList;*/
            
            PageReference pageRef = Page.PopulateOli;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c); 
            
            
            
            Test.startTest();
            PopulateOLIHandler spc = new PopulateOLIHandler(sc);     
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp1.Id);
            spc.createOlis();
            spc.createOlisFromPastData();
            PopulateOLIHandler.populateCropProvision(oli);
            Test.stopTest();
        }
    }
    
    
    static TestMethod void populateOLIHandlerTest5(){      
        
    System.runAs(RunningUser)
    {
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='A633',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Quantity_Acres_Conversion_A633__c=14,Quantity_Acres_Conversion_A623__c=14,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
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
            
            RecordType accrct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'PlanningAccount'];
            Account a1 = new Account(Name ='Test5a', RecordTypeId = accrct.Id);
            insert a1;            
                       
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l3.Id;
            insert acctrr;
                        
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'District_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp1;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'District_OTG_LE'];
            opportunity oppr = new opportunity();
            oppr.Name='testing opp4';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Acquire';
            oppr.AccountBusinessPlan__c = bp1.id;
            oppr.CloseDate = closeDt;
            oppr.Product_Type__c = 'Seeds';
            oppr.RecordTypeId =rct1.id;
            oppr.Year__c='2018'; 
            oppr.Territory__c=L3.id;
            oppr.PriceBook2Id = seedpricebook.id;
            insert oppr;
            
            ToUpdateRelatedPlan.UpdateDSPRelatedPlan(oppr);
                        
            OpportunityLineItem opplnitem=new OpportunityLineItem();
            opplnitem.OpportunityId=oppr.Id;
            opplnitem.PriceBookEntryId=pbe2.Id;
            opplnitem.LE_March_Quantity__c=1000;

            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            insert oli; 
            
            
            
            PageReference pageRef = Page.PopulateOli;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c); 
            
            
            
            Test.startTest();
            PopulateOLIHandler spc = new PopulateOLIHandler(sc);     
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp1.Id);
            PopulateOLIHandler.copyLastMonthToNextMonth();
            PopulateOLIHandler.copyLastMonthToNextMonth();
            PopulateOLIHandler.copyLastMonthToNextMonth();
            PopulateOLIHandler.copyLastMonthToNextMonth();
            PopulateOLIHandler.copyLastMonthToNextMonth();
            PopulateOLIHandler.copyLastMonthToNextMonth();
            Test.stopTest();
        }
    
    }

    
    
}