@isTest
public class Test_Allocatesalesplanctr {
    Static User testUser;
    Static Territory__c cu;
    Static Territory__c district;
    Static Territory__c district1;
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
    Static SeedsAllocation__c sa;
    Static Opportunity cuOpp;
    Static Opportunity distOpp;
    Static Opportunity terrOpp;
    Static Opportunity accOpp;
    Static OpportunityLineItem oli1;
    Static OpportunityLineItem oli2;
    public static testMethod void testAllocatesalesplanctrController(){
        
        testUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        
        cu = TestDataFactory.createTestTerritoryRecords(testUser,'L1:Commercial unit','A633');
        district = TestDataFactory.createTestTerritoryRecords(testUser,'L2:District','A6332');
        district1 = TestDataFactory.createTestTerritoryRecords(testUser,'L2:District','A6331');
        territory = TestDataFactory.createTestTerritoryRecords(testUser,'L3:Territory','A6332A');
        System.debug('territory'+territory);
        List<String> recType = new List<String>();
        recType.add('Planning Account');
        recType.add('Planning Account');
        recType.add('Planning Account');
        recType.add('Retailer');
        recType.add('Planning Account');
        List<String> terrId = new List<String>();
        terrId.add(cu.Id);
        terrId.add(district.Id);
        terrId.add(territory.Id);
        terrId.add(territory.Id);
        terrId.add(district1.Id);
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
 
        Account acc = new Account();
        acc = accountList[0];
        cuOpp = TestDataFactory.createTestOpportunityRecords(Label.CUSeedsAllocationRecordType,pb.Id,'2018',cu.Id,testUser,acc.Id); 
        
        acc = accountList[1];
        distOpp = TestDataFactory.createTestOpportunityRecords(Label.DistrictSeedsAllocation,pb.Id,'2018',district.Id,testUser,acc.Id);
        
        acc = accountList[4];
        Opportunity distOpp1 = TestDataFactory.createTestOpportunityRecords(Label.DistrictSeedsAllocation,pb.Id,'2018',district1.Id,testUser,acc.Id);
        
        acc=accountList[3];
        accOpp = TestDataFactory.createTestOpportunityRecords(Label.Account_Seeds_Allocation,pb.Id,'2018',territory.Id,testUser,acc.Id);
        
       Opportunity cuOpp1 = [Select Id,Territory__r.Id,Name,Year__c,AccountId,Account.Account_Id__c,Territory__c,Territory__r.District__c,
                           RecordType.DeveloperName,RecordType.Name,RecordTypeId,OwnerId,territory__r.Assigned_Rep__c,territory__r.CommercialUnit__c,
                           territory__r.Assigned_Rep__r.Name,territory__r.Name,Account.Name From opportunity Where Id =: cuOpp.Id Limit 1];
        List<PriceBookEntry> pbe2 = [SELECT ID,Product2.Variety__c,Product2Id,PriceBook2Id,Product2.Species__c,Product2.Product_ID__c FROM PriceBookEntry Where ID =: pbe.ID OR ID =: pbe1.ID];
        
        List<Opportunity> disOpp2 = [Select Id,Territory__r.Id,Name,Year__c,AccountId,Account.Account_Id__c,Territory__c,Territory__r.District__c,
                           RecordType.DeveloperName,RecordType.Name,RecordTypeId,OwnerId,territory__r.Assigned_Rep__c,territory__r.CommercialUnit__c,
                           territory__r.Assigned_Rep__r.Name,territory__r.Name,Account.Name From opportunity Where Id =: distOpp.Id OR Id =: distOpp1.Id];
     
        oli1 = TestDataFactory.createTestOpportunityLineItemRecords(disOpp2[0],pbe2[0]);
        oli2 = TestDataFactory.createTestOpportunityLineItemRecords(disOpp2[0],pbe2[1]);
        
        Test.startTest();
        PageReference pageRef = Page.Allocatesalesplanvf;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con = new ApexPages.StandardController(cuOpp1);
        Allocatesalesplanctr asp = new Allocatesalesplanctr(con); 
        asp.getShowAllocateToTerritories();
        asp.AllocateToTerritories();
        con = new ApexPages.StandardController(disOpp2[0]);
        asp = new Allocatesalesplanctr(con);
        asp.AllocateToAccounts();
        test.stopTest();
        
        
    }
}