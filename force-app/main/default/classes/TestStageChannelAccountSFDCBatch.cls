@isTest
public class TestStageChannelAccountSFDCBatch {

    static testmethod void theTest(){
        Test.startTest();
        Stage_Channel_Account_SFDC__c fnd = new Stage_Channel_Account_SFDC__c(SFDC_Account_ID__c = '12345', Type__c = 'Test');
        insert fnd;
        Database.executeBatch(new StageChannelAccountSFDCBatch());
        Test.stopTest();
    }
    
}