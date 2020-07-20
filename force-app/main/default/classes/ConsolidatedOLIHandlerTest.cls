/**************************************************************************************
* Apex Class Name    :     ConsolidatedOLIHandlerTest
* Version            :     1.0
* Created Date       :     11/June/2018
* Function           :     This is Test class for ConsolidatedOLIHandler Class
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     11/June/2018                Created.
*************************************************************************************/

@isTest
private class ConsolidatedOLIHandlerTest {
 /********************************************************************************************
 * Method   : testConsolidated
 * Description: To Test COnsolidated
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 11-June-2018  Srni       Created     
 ********************************************************************************************/
    @isTest static void testConsolidated()
    {
   // To insert data in Opportunity Line Item, Setting up Required dependent data
    Map<string,id> BPRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Business_Plan__c.SObjectType);  
    Map<string,id> AccRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Account.SObjectType);  
    Date closeDt = Date.Today();

    Account a1 = new Account(Name ='Retailer acc',RecordTypeId=AccRecordtypes.get(Label.Retailer));
    insert a1;
        
    Business_Plan__c b1=new Business_Plan__c(Account__c=a1.Id,Year__c='2018',Name='Retailer Business Plan 2018',RecordTypeId=BPRecordtypes.get(Label.Retail_Business_Plan));
        insert b1;
        
        opportunity oppr = new opportunity();
        oppr.Name='Retailer opp';
        oppr.AccountId= a1.Id;
        oppr.StageName = 'Won';
        oppr.CloseDate = closeDt;
        oppr.Year__c='2018';
        oppr.AccountBusinessPlan__c=b1.id;
        insert oppr;
      
        Test.startTest();
        PageReference pageRef = Page.ConsolidatedOLI;
        pageRef.getParameters().put('productType', 'CP');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con = new ApexPages.StandardController(b1);
        ConsolidatedOLIHandler cntr = new ConsolidatedOLIHandler(con);
        pageRef.getParameters().put('BpId', String.valueOf(b1.Id));
        Test.setCurrentPage(pageRef);
        cntr.salesPlanError();
        test.stopTest();
 }  
    /********************************************************************************************
 * Method   : testConsolidated1
 * Description: To Test COnsolidated
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 05-July-2018  Srni       Created     
 ********************************************************************************************/
    @isTest static void testConsolidated1()
    {
   // To insert data in Opportunity Line Item, Setting up Required dependent data
    Map<string,id> BPRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Business_Plan__c.SObjectType);  
    Map<string,id> AccRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Account.SObjectType);  
    Date closeDt = Date.Today();

    Account a1 = new Account(Name ='Retailer acc',RecordTypeId=AccRecordtypes.get(Label.Retailer));
    insert a1;
        
    Business_Plan__c b1=new Business_Plan__c(Account__c=a1.Id,Year__c='2018',Name='Retailer Business Plan 2018',RecordTypeId=BPRecordtypes.get(Label.Retail_Business_Plan));
        insert b1;
        
              
        Test.startTest();
        PageReference pageRef = Page.ConsolidatedOLI;
        pageRef.getParameters().put('productType', 'CP');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con = new ApexPages.StandardController(b1);
        ConsolidatedOLIHandler cntr = new ConsolidatedOLIHandler(con);
        pageRef.getParameters().put('BpId', String.valueOf(b1.Id));
        Test.setCurrentPage(pageRef);
        cntr.salesPlanError();
        test.stopTest();
 }  
}