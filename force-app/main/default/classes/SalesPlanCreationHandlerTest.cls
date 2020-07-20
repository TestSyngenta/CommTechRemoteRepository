@isTest
public class SalesPlanCreationHandlerTest {    
    public static Id RecordTypeId;
    public Static Opportunity opp;
    Public Static String recordtype;
    Private static Integer currYear = System.Today().year();
   public static TestMethod void testSalesPlanCreationHandler(){
        User RunningUser = TestDataFactory.createTestUserRecords('A6332','System Administrator - Canada');
        System.runAs(RunningUser)
        {   
            Territory__c L2 = TestDataFactory.createTestTerritoryRecords(RunningUser, 'L2:District', 'A6332');
            List<Account> accList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(new List<String>{'Planning Account'}, RunningUser, new List<String>{L2.Id});
            Business_Plan__c bp = TestDataFactory.createTestBusinessPlan(accList[0].Id,'CU Business Plan',String.valueOf(currYear));
            ApexPages.currentPage().getParameters().put('ProdType','Seeds');
            ApexPages.currentPage().getParameters().put('OppRecType', Label.District_Seeds_Sales_Plan);
            ApexPages.currentPage().getParameters().put('BPId',bp.Id);
            Test.startTest();
            String result = SalesPlanCreationHandler.createSPHeader();
            
            Id opprId = [select id from opportunity where accountId=:accList[0].id and AccountBusinessPlan__c=:bp.Id and recordtype.developerName=:Label.District_Seeds_Sales_Plan limit 1].Id;
            System.assertEquals('/'+String.valueOf(opprId), result);
        }
            
            Territory__c L2 = TestDataFactory.createTestTerritoryRecords(RunningUser, 'L2:District', 'A6332');
            User loggedUser  = new  User(Id = UserInfo.getUserId());
            List<Account> accList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(new List<String>{'Planning Account'}, loggedUser, new List<String>{L2.Id});
            Business_Plan__c bp = TestDataFactory.createTestBusinessPlan(accList[0].Id,'CU Business Plan',String.valueOf(currYear));
            ApexPages.currentPage().getParameters().put('ProdType','Seeds');
            ApexPages.currentPage().getParameters().put('OppRecType', Label.District_Seeds_Sales_Plan);
            ApexPages.currentPage().getParameters().put('BPId',bp.Id);
                
            String result1 = SalesPlanCreationHandler.createSPHeader();
            Test.stopTest();
     }
     public static TestMethod void testSalesPlanCreation(){
       User RunningUser = TestDataFactory.createTestUserRecords('A6332A','System Administrator - Canada');
       System.runAs(RunningUser){
           Test.startTest();
           Territory__c L3 = TestDataFactory.createTestTerritoryRecords(RunningUser, 'L3:Territory', 'A6332A');
           List<Account> accList = TestDataFactory.createTestAccountsAndAccountTerritoryRecord(new List<String>{'Distributor','Planning Account'}, RunningUser, new List<String>{L3.Id,L3.District__c});
           Business_Plan__c bp = TestDataFactory.createTestBusinessPlan(accList[0].Id,'Distributor Business Plan',String.valueOf(currYear));
           Business_Plan__c bp1 = TestDataFactory.createTestBusinessPlan(accList[0].Id,'Distributor Business Plan',String.valueOf(currYear-1));
           PageReference salesPage = Page.SalesPlanDispatcher;
           Test.setCurrentPage(salesPage);
           salesPage.getParameters().put('ProdType','CP');
           salesPage.getParameters().put('OppRecType', Label.DistributorCPSalesPlan);
           salesPage.getParameters().put('BPId',bp.Id);
           String result = SalesPlanCreationHandler.createSPHeader();
           Product2 p1 = TestDataFactory.createTestProductRecords('CP Product', 'SY ROWYN', 'Seedcare');
           Product2 p2 = TestDataFactory.createTestProductRecords('CP Product', 'SY087', 'Seedcare');
        
            PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c,CPPriceBookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
            Pricebook2 cppricebook = new Pricebook2(id=custommetadata.CPPriceBookID__c,name='CP and SeedCare Price Book',IsActive = true);
            
            id stdpricebook = Test.getStandardPricebookId();
            
            List<PricebookEntry> pbelist = new List<PricebookEntry>();
            
            PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.Id,Pricebook2Id=stdpricebook,IsActive=true);
            PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p2.Id,Pricebook2Id=stdpricebook,IsActive=true);
            PricebookEntry pbe3=new PricebookEntry(UnitPrice=1,Product2Id=p1.Id,Pricebook2Id=cppricebook.Id,IsActive=true);
            PricebookEntry pbe4=new PricebookEntry(UnitPrice=1,Product2Id=p2.Id,Pricebook2Id=cppricebook.Id,IsActive=true);
            pbelist.add(pbe1);
            pbelist.add(pbe2);
            pbelist.add(pbe3);
            pbelist.add(pbe4);
            insert pbelist;
            /*pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p2, stdpricebook));
            pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p1, cppricebook.Id));
            pbelist.add(TestDataFactory.createTestPriceBookEntryRecords(p2, cppricebook.Id));*/
           Opportunity oppr = TestDataFactory.createTestOpportunityRecords(Label.CP_Distributor_Sales_Plan,cppricebook.Id, String.valueOf(currYear), L3.Id, RunningUser, accList[0].Id);
           Opportunity prevYrOppr = TestDataFactory.createTestOpportunityRecords(Label.CP_Distributor_Sales_Plan,cppricebook.Id, String.valueOf(currYear-1), L3.Id, RunningUser, accList[0].Id);
           oppr.AccountBusinessPlan__c = bp.Id;
           List<Opportunity> oList = new List<Opportunity>();
           oList.add(oppr);
           prevYrOppr.AccountBusinessPlan__c = bp1.Id;
           oList.add(prevYrOppr);
           update oList;
           List<OpportunityLineItem> opplnitemList = new List<OpportunityLineItem>();
           opplnitemList.add(TestDataFactory.createTestOpportunityLineItemRecord(prevYrOppr,pbeList[2],Label.CP_Sales,'Channel Sales'));
           Sales_Plan_Actual__c SPARecord = TestDataFactory.createTestSalesPlanActualRecord(accList[0].Id,p2.Id, String.valueOf(currYear-1));
           List<OpportunityLineItem> getInsertList = SalesPlanCreationHandler.getInsertOLIList(oppr, new Set<Id>{}, false, true);
           /*System.Debug(getInsertList[0].PricebookEntryId + ' ' + pbeList[2].Id);*/
           Test.stopTest();
           System.assertEquals(1, getInsertList.size());
       }
       
   }
    static TestMethod void UpdateDSPRelatedPlanTest()
    {
        recordtype = label.DistributorCPSalesPlan;
         RecordType rt;
        //opp = [select id, recordtypeid from opportunity where recordtype.developername =: recordtype limit 1];
        rt = [select id,developername from RecordType where developername =: recordtype limit 1];
        Test_UtilityClass.dataTestMethod();
          opp = [select id,year__c,Territory__c,commercialunit__C,RelatedDistributor__c,RelatedDistributorPlan__c, product_type__c,Recordtype.Developername from opportunity where Name='testing opp1'];
        if(opp!=null){
            opp.product_type__c = 'CP';
            //opp.Territory__c = 'WCU';
            opp.Recordtype.Developername = rt.developername;
            test.startTest();
                update opp;
                Opportunity opt = new Opportunity();
                PageReference myVfPage = Page.SalesPlanDispatcher;
                ApexPages.currentPage().getParameters().put('OppRecType',rt.developername);
                System.debug('ApexPages.currentPage().getParameters()'+ApexPages.currentPage().getParameters().get('OppRecType'));
                Test.setCurrentPage(myVfPage);
                ToUpdateRelatedPlan.UpdateDSPRelatedPlan(opp);
                String id = ApexPages.currentPage().getParameters().get('id');
                //System.assert('true',id==null);
            test.stopTest();
          }       
    }
}