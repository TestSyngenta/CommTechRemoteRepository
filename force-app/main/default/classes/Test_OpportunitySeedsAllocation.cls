/***************************************************************************************
* Apex Class Name    :     Test_OpportunitySeedsAllocation
* Version            :     1.0
* Created Date       :     05/Jan/2018
* Function           :     This is Test class for OpportunitySeedsAllocation class
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     05/Jan/2018                Created.
* Vijay                    23/Mar/2018                Modified.
*************************************************************************************/
@isTest(isParallel=false)
private class Test_OpportunitySeedsAllocation {

public static TestMethod void testOpportunitySeedsAllocation(){
    Integer currYear = System.Today().year();
    User RunningUser = TestDataFactory.createTestUserRecords('A100','System Administrator - Canada');
    System.runAs(RunningUser)
        {  
    Test.startTest();
    Territory__c L2 = TestDataFactory.createTestTerritoryRecords(RunningUser, 'L2:District', 'A1001');
    List<Account> accList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(new List<String>{'Planning Account','Planning Account'}, RunningUser, new List<String>{L2.CommercialUnit__c,L2.Id});
    Product2 p1 = TestDataFactory.createTestProductRecords('Seeds Product', 'N04A', 'Seed');
    PriceBook_for_SalesPlan__mdt custommetadata = [select id,DeveloperName,Seeds_Price_BookID__c,CPPriceBookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
    Pricebook2 seedpricebook = new Pricebook2(id = custommetadata.Seeds_Price_BookID__c, name='Seeds',IsActive = true);
    //upsert seedpricebook;
    
    //PriceBook_for_SalesPlan__mdt custommetadata = new PriceBook_for_SalesPlan__mdt(DeveloperName='PriceBookData', SeedsPriceBook__c='Seeds Price Book', Seeds_Price_BookID__c = seedpricebook.Id);        
    id stdpricebook = Test.getStandardPricebookId();
            
    List<PricebookEntry> pbelist = new List<PricebookEntry>();
    pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p1, stdpricebook));
    pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p1, seedpricebook.Id));
            
    /*Business_Plan__c bp = TestDataFactory.createTestBusinessPlan(accList[1].Id,'District Business Plan',String.valueOf(currYear));*/
    Opportunity oppr = TestDataFactory.createTestOpportunityRecords('District_Seeds_Sales_Plan',seedpricebook.Id, String.valueOf(currYear), L2.Id, RunningUser, accList[1].Id);
    opportunityLineItem oli = TestDataFactory.createTestOpportunityLineItemRecord(oppr,pbeList[1],Label.SeedsSales,'Area Sales');
            
    Map<string,id> salesPlanRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Sales_Plan_Actual__c.SObjectType);
    Id salesPlanRecTypeId= salesPlanRecordtypes.get(Label.SeedsSales);
    Account acc = [select id,Account_Id__C from Account where id=:accList[1].Id limit 1];
    
    Sales_Plan_Actual__c SPARecord = TestDataFactory.createTestSalesPlanActualRecord(accList[1].Id,p1.Id, String.valueOf(currYear));
    /*Sales_Plan_Actual__c SPARecord_1 = TestDataFactory.createTestSalesPlanActualRecord(accList[1].Id,p1.Id, String.valueOf(currYear-1));*/
    /*Sales_Plan_Actual__c SPARecord_2 = TestDataFactory.createTestSalesPlanActualRecord(accList[1].Id,p1.Id, String.valueOf(currYear-2));*/
    SPARecord.RecordTypeId = salesPlanRecTypeId;
    SPARecord.UniqueKey__c = ''+String.valueOf(acc.Account_Id__C)+'|'+p1.Product_ID__c+'|'+String.valueOf(currYear)+'|Area Sales|'+label.Seeds_Sales+'';
    update SPARecord;
    SeedsAllocation__c allocations  = TestDataFactory.createTestSeedsAllocationRecord(L2.CommercialUnit__r.Name, L2.Id, 1000,'N04A', String.valueOf(currYear));
    insert allocations;
            
    List<OpportunityLineItem> OLIInserted = [select id from OpportunityLineItem where Opportunity.AccountId=:accList[1].Id];
    System.assertEquals(2,OLIInserted.size());
    Test.stopTest();
            
        }

}    
}