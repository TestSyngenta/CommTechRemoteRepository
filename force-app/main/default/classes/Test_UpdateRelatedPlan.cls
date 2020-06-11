@isTest
public class Test_UpdateRelatedPlan {
    Static User testUser;
    Static Territory__c cu;
    Static Territory__c district;
    Static Territory__c territory;
    Static Map<Account,Account_Territory__c> accAT1;
    Static Map<Account,Account_Territory__c> accAT2;
    Static Map<Account,Account_Territory__c> accAT3;
    Static Map<Account,Account_Territory__c> accAT4;
    Static Map<Account,Account_Territory__c> accAT5;
    Static PriceBook2 pb;
    Static String spb;
    Static Product2 prod;
    Static Product2 prod1;
    Static PriceBookEntry pbe;
    Static PriceBookEntry spbe;
    Static Opportunity retailrOpp;
    
    public static testMethod void testRelatedPlan(){
        testUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        cu = TestDataFactory.createTestTerritoryRecords(testUser,'L1:Commercial unit','A633');
        district = TestDataFactory.createTestTerritoryRecords(testUser,'L2:District','A6332');
        territory = TestDataFactory.createTestTerritoryRecords(testUser,'L3:Territory','A6332A');
        
        List<String> recType = new List<String>();
        recType.add('Planning Account');
        recType.add('Planning Account');
        recType.add('Planning Account');
        recType.add('Distributor');
        recType.add('Retailer');
        
        List<String> terrId = new List<String>();
        terrId.add(cu.Id);
        terrId.add(district.Id);
        terrId.add(territory.Id);
        terrId.add(territory.Id);
        terrId.add(territory.Id);
        
        List<Account> accountList = new List<Account>();
        accountList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(recType,testUser,terrId);
        
        pb = TestDataFactory.createTestPriceBookRecords('Seeds Price Book');
        prod = TestDataFactory.createTestProductRecords('Seeds Product','0256RR','Seeds');
        prod1 = TestDataFactory.createTestProductRecords('Seeds Product','SY087','Seeds');
        spb = Test.getStandardPricebookId();
        spbe = TestDataFactory.createTestPriceBookEntryRecords(prod,spb);
        PriceBookEntry spbe1 =  TestDataFactory.createTestPriceBookEntryRecords(prod1,spb);
        pbe = TestDataFactory.createTestPriceBookEntryRecords(prod,pb.Id);
        PriceBookEntry pbe1 =  TestDataFactory.createTestPriceBookEntryRecords(prod1,pb.Id);
        Id rt = [select id from Recordtype where developerName='RetailerCPSalesPlan' limit 1].Id;
        Id rt1 = [select id from Recordtype where developerName='DistributorCPSalesPlan' limit 1].Id;
        
        Map<string,id> ActRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Account.SObjectType);
        Id retrecordTypeId = ActRecordtypes.get(label.Retailer);
        Id disrecordTypeId = ActRecordtypes.get(label.Distributor);
        
        List<Account> accList = new List<Account>();
        Account a1 = new Account(Name ='testing account',recordtypeid = retrecordTypeId);
        //insert a1;
        
        Account a2 = new Account(Name ='test account',recordtypeid = retrecordTypeId);
        //insert a2;
        accList.add(a1);
        accList.add(a2);
        insert accList;
        
        Account_Territory__c accTerr = new Account_Territory__c();
        accTerr.account__c = accList[1].id;
        accTerr.Territory__c = territory.Id;
        accTerr.Head_Office_Account__c = accList[0].id;
        insert accTerr;
        RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
        Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2018', Account__c = accountList[4].id, RecordTypeId = rct.id, Country__c = 'CA');
        insert bp1;
        
        Opportunity opp1 = new Opportunity();
        
        opp1.Name = 'Retailer1 Opp';
        opp1.Year__c = '2018';
        opp1.StageName = 'Closed';
        opp1.OwnerId = testUser.Id;
        opp1.RecordTypeId = rt;
        opp1.Territory__c = territory.Id;
        opp1.CloseDate = System.today() + 90;
        opp1.AccountId = accountList[4].id;
        opp1.Pricebook2Id = pb.Id;
        opp1.Product_Type__c = 'CP';
        opp1.RelatedDistributor__c=accountList[3].id;
        opp1.AccountBusinessPlan__c = bp1.Id;
        
                    
        Test.startTest();
        insert opp1;
        update opp1;
        test.stopTest();
    }
    
    static TestMethod void UpdateDSPRelatedPlanTest2()
    {
       String recordtype = label.DistributorCPSalesPlan;
         RecordType rt;
        rt = [select id,developername from RecordType where developername =: recordtype limit 1];
        Test_UtilityClass.dataTestMethod();
         Opportunity opp = [select id,year__c,Territory__c,commercialunit__C,RelatedDistributor__c,RelatedDistributorPlan__c, product_type__c,Recordtype.Developername from opportunity where Name='testing opp1'];
        if(opp!=null){
            opp.product_type__c = 'CP';
            //opp.Territory__c = 'WCU';
            opp.Recordtypeid = rt.id;
            test.startTest();
                update opp;
                ToUpdateRelatedPlan.UpdateDSPRelatedPlan(opp);
            test.stopTest();
          }       
    }
    
    static TestMethod void UpdateDSPRelatedPlanTest3()
    {
       String recordtype = label.Territory_Sales_Plan;
         RecordType rt;
        //opp = [select id, recordtypeid from opportunity where recordtype.developername =: recordtype limit 1];
        rt = [select id,developername from RecordType where developername =: recordtype limit 1];
        Test_UtilityClass.dataTestMethod();
        Opportunity  opp = [select id,year__c,Territory__c,commercialunit__C,RelatedDistributor__c,RelatedDistributorPlan__c, product_type__c,Recordtype.Developername from opportunity where Name='testing opp1'];
        if(opp!=null){
            opp.product_type__c = 'CP';
            //opp.Territory__c = 'WCU';
            opp.Recordtypeid = rt.id;
            test.startTest();
                update opp;
                Opportunity opt = new Opportunity();
                ToUpdateRelatedPlan.UpdateDSPRelatedPlan(opp);
                String id = ApexPages.currentPage().getParameters().get('id');
                //System.assert('true',id==null);
            test.stopTest();
          }       
    }
    public static testMethod void testRelatedPlan2(){
        testUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        cu = TestDataFactory.createTestTerritoryRecords(testUser,'L1:Commercial unit','A633');
        district = TestDataFactory.createTestTerritoryRecords(testUser,'L2:District','A6332');
        territory = TestDataFactory.createTestTerritoryRecords(testUser,'L3:Territory','A6332A');
        
        List<String> recType = new List<String>();
        recType.add('Planning Account');
        recType.add('Planning Account');
        recType.add('Planning Account');
        recType.add('Distributor');
        recType.add('Retailer');
        
        List<String> terrId = new List<String>();
        terrId.add(cu.Id);
        terrId.add(district.Id);
        terrId.add(territory.Id);
        terrId.add(territory.Id);
        terrId.add(territory.Id);
        
        List<Account> accountList = new List<Account>();
        accountList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(recType,testUser,terrId);
        
        pb = TestDataFactory.createTestPriceBookRecords('Seeds Price Book');
        prod = TestDataFactory.createTestProductRecords('Seeds Product','0256RR','Seeds');
        prod1 = TestDataFactory.createTestProductRecords('Seeds Product','SY087','Seeds');
        spb = Test.getStandardPricebookId();
        spbe = TestDataFactory.createTestPriceBookEntryRecords(prod,spb);
        PriceBookEntry spbe1 =  TestDataFactory.createTestPriceBookEntryRecords(prod1,spb);
        pbe = TestDataFactory.createTestPriceBookEntryRecords(prod,pb.Id);
        PriceBookEntry pbe1 =  TestDataFactory.createTestPriceBookEntryRecords(prod1,pb.Id);
        Id rt = [select id from Recordtype where developerName='RetailerCPSalesPlan' limit 1].Id;
        Id rt1 = [select id from Recordtype where developerName='DistributorCPSalesPlan' limit 1].Id;
        
        Map<string,id> ActRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Account.SObjectType);
        Id retrecordTypeId = ActRecordtypes.get(label.Retailer);
        Id disrecordTypeId = ActRecordtypes.get(label.Distributor);
        
        List<Account> accList = new List<Account>();
        Account a1 = new Account(Name ='testing account',recordtypeid = retrecordTypeId);
        //insert a1;
        
        Account a2 = new Account(Name ='test account',recordtypeid = retrecordTypeId);
        //insert a2;
        accList.add(a1);
        accList.add(a2);
        insert accList;
        
        Account_Territory__c accTerr = new Account_Territory__c();
        accTerr.account__c = accList[1].id;
        accTerr.Territory__c = territory.Id;
        accTerr.Head_Office_Account__c = accList[0].id;
        insert accTerr;
        
        RecordType rct = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
        Business_Plan__c bp = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2018', Account__c = accList[1].id, RecordTypeId = rct.id, Country__c = 'CA');
        
        insert bp;
        Opportunity opp = new Opportunity();
        
        opp.Name = 'Retailer Opp';
        opp.Year__c = '2018';
        opp.StageName = 'Closed';
        opp.OwnerId = testUser.Id;
        opp.RecordTypeId = rt;
        opp.Territory__c = territory.Id;
        opp.CloseDate = System.today() + 90;
        opp.AccountId = accList[1].id;
        opp.Pricebook2Id = pb.Id;
        opp.Product_Type__c = 'CP';
        opp.Account_Territory__c=accTerr.id;
        opp.RelatedDistributor__c=accountList[3].id;
        opp.AccountBusinessPlan__c = bp.Id;
      
                    
        Test.startTest();
       insert opp;
        update opp;
        test.stopTest();
    }
}