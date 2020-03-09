@isTest
public class SalesPlanControllerTest {
    public static Profile pf= [Select Id from profile where Name='System Administrator - Canada']; 
    
    public static String orgId=UserInfo.getOrganizationId(); 
    public static String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
    
    public static Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
    public static String uniqueName=orgId+dateString+RandomId; 
    
    public static User loggedinUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
    
    public static Account a1 = new Account(name = 'TestAcc');
    public static Account a2 = new Account(name = 'TestAcc1');  
    public static Business_Plan__c bp = new Business_Plan__c();
    public static opportunity oppr = new opportunity();
    public static Date closeDt = Date.Today();
    public static Pricebook2 seedpricebook = new Pricebook2();
    public static Territory__c L1 = new Territory__c();
    
    public static TestMethod void SalesPlanControllerTest(){
        System.runAs(loggedinUser)
        {
            // ApexPages.StandardController controller = new ApexPages.StandardController(bp);
            //SalesPlanController bpcontroller = new SalesPlanController(controller);
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=loggedinUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=loggedinUser.Id,CommercialUnit__c=L1.Id);
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=loggedinUser.Id,CommercialUnit__c=L1.Id);
            List<Territory__c> Terr = new List<Territory__c>();
            Terr.add(L1);
            Terr.add(L2);
            Terr.add(L3);
            insert Terr;
            
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
            
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            List<Product2> prod = new List<Product2>();
            prod.add(p1);
            prod.add(p2);
            insert prod;
            
            PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
            
            Pricebook2 seedpricebook = new Pricebook2(id=custommetadata.seeds_price_bookId__c,name='Seeds Price Book',IsActive = true);
            upsert seedpricebook;
            
            id stdpricebook = Test.getStandardPricebookId();
            
            PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe3=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=stdpricebook,IsActive=true);
            PricebookEntry pbe4=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=stdpricebook,IsActive=true);    
            
            List<PricebookEntry> pbelist = new List<PricebookEntry>();
            pbelist.add(pbe4);
            pbelist.add(pbe3);
            pbelist.add(pbe2);
            pbelist.add(pbe1);
            insert pbelist;
            
            
            
            
            RecordType accrct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a1 = new Account(name = 'TestAcc', RecordTypeId = accrct.Id);
            Account a2 = new Account(name = 'TestAcc1', RecordTypeId = accrct.Id);
            List<Account> acc = new List<Account>();
            acc.add(a1);
            acc.add(a2);
            insert acc;
            
            Account_Territory__c acctrr=new Account_Territory__c();
            acctrr.Account__c=a1.id;
            acctrr.Territory__c=l2.Id;
            insert acctrr;
            
            Account_Territory__c acctrr1 =new Account_Territory__c();
            acctrr1.Account__c=a2.id;
            acctrr1.Territory__c=l2.Id;
            acctrr1.Head_Office_Account__c = a1.id;
            insert acctrr1;
            
            
            RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            Business_Plan__c bp = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2018', Account__c = a1.id, RecordTypeId = rct.id, Country__c = 'CA');  
            Insert bp;
            RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'SeedsRetailerHeadOfficeSalesPlan'];       
            system.debug('Recordtypeopportunity1***********'+rct1);
            oppr.Name='testing opp';
            oppr.AccountId= a1.Id;
            oppr.StageName = 'Won';
            oppr.CloseDate = closeDt;
            oppr.Territory__c=L3.id;
            oppr.RecordTypeId= rct1.Id;
            oppr.Product_Type__c = 'Seeds';
            oppr.AccountBusinessPlan__c = bp.id;
            oppr.PriceBook2Id = seedpricebook.id;
            oppr.Year__c='2018';
            
            PageReference pageRef = Page.SalesPlanDispatcher;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c);
            System.runAs(loggedinUser)
            {
                Test.startTest();
                SalesPlanController spc = new SalesPlanController(sc);        
                ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
                ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c);
                ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
                ApexPages.currentPage().getParameters().put('BPId',bp.Id);
                spc.redirectURL();
                spc.redirect();     
                spc.checkForCreateAccess(loggedinUser,oppr.RecordType.DeveloperName);
                Test.stopTest();
            }
            
        }
    }
    
    public static TestMethod void SalesPlanControllerTest1(){
        
        Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=loggedinUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
        

        RecordType rct1 = [Select Id,Name,DeveloperName From RecordType Where DeveloperName = 'SeedsRetailerHeadOfficeSalesPlan'];       
        system.debug('Recordtypeopportunity1***********'+rct1);
        opportunity oppr = new opportunity();
        oppr.Name='testing opp';
        oppr.AccountId= a1.Id;
        oppr.StageName = 'Won';
        oppr.CloseDate = closeDt;
        oppr.Territory__c=L3.id;
        oppr.RecordTypeId= rct1.Id;
        // oppr.Product_Type__c = 'Seeds';
        oppr.AccountBusinessPlan__c = bp.id;
        oppr.PriceBook2Id = seedpricebook.id;
        oppr.Year__c='2018';
        
        
        
        PageReference pageRef = Page.SalesPlanDispatcher;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
        ApexPages.currentPage().getParameters().put('Id',oppr.Id);
        ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
        ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c);
        System.runAs(loggedinUser)
        {
            Test.startTest();
            SalesPlanController spc = new SalesPlanController(sc);        
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
            ApexPages.currentPage().getParameters().put('BPId',bp.Id);
            spc.redirectURL();
            spc.redirect();    
            spc.checkForCreateAccess(loggedinUser,oppr.RecordType.DeveloperName);
            Test.stopTest();    
            
            
        }
    }
    static TestMethod void SalesPlanControllerTest2(){
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        System.runAs(RunningUser)
        {
            List<Account> aList = new List<Account>();
            List<Opportunity> oList = new List<Opportunity>();
            
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
            /*insert a1;*/
            aList.add(a1);
            RecordType rct6 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'CA_Retailer'];
            Account a2 = new Account(Name ='testing acc', RecordTypeId = rct6.Id );
            /*insert a2;*/
            aList.add(a2);
            insert aList;
            
            
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
            /*insert oppr;*/
            oList.add(oppr);
            
            
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
            /*insert oppr1;  */
            oList.add(oppr1);
            insert oList;
            
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
            
            
            List<opportunityLineItem> oli = new List<opportunityLineItem>();
            oli.add(opplnitem);
            insert oli;    
            
            PageReference pageRef = Page.SalesPlanDispatcher;
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController sc = new ApexPages.StandardController(oppr);
            ApexPages.currentPage().getParameters().put('Id',oppr.Id);
            ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
            ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c);
            System.runAs(loggedinUser)
            {
                Test.startTest();
                SalesPlanController spc = new SalesPlanController(sc);        
                ApexPages.currentPage().getParameters().put('RecordType',oppr.RecordTypeId);
                ApexPages.currentPage().getParameters().put('ProdType',oppr.Product_Type__c);
                ApexPages.currentPage().getParameters().put('RecTypeDeveloperName',oppr.RecordType.DeveloperName);
                ApexPages.currentPage().getParameters().put('BPId',bp.Id);
                spc.redirectURL();
                spc.redirect();     
                spc.checkForCreateAccess(loggedinUser,oppr.RecordType.DeveloperName);
                Test.stopTest();
                
                
            }
        }
        
    }
    
}