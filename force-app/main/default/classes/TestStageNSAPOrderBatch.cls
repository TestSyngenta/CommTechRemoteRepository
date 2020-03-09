@isTest
public class TestStageNSAPOrderBatch {

    static testmethod void theTest(){
        Test.startTest();
        Stage_NSAP_Order__c fnd = new Stage_NSAP_Order__c(PO_Number__c = '12345');
        insert fnd;
        Database.executeBatch(new StageNSAPOrderBatch());
        Test.stopTest();
    }
    
}