@isTest
public class TestStageChannelAccountNSAPBatch {

    static testmethod void theTest(){
        Test.startTest();
        Stage_Channel_Account_NSAP__c fnd = new Stage_Channel_Account_NSAP__c(NSAP_ECC_ID__c = '12345');
        insert fnd;
        Database.executeBatch(new StageChannelAccountNSAPBatch());
        Test.stopTest();
    }
    
}