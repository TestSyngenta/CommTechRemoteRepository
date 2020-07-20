@isTest(SEEALLDATA = true)
public class Programs_TriggerTest {
    
    static TestMethod void runTest(){
        Account testAcct = new Account(Name='BeefyBurrito1928475SyngengtaTest');
        Insert testAcct;
 
        Programs__c testProg = new Programs__c(Account__c=testAcct.id, Program_Year__c='2015', Offer_Type__c='TestOfferType');
        insert testProg;
        
        Programs__c testAgriclime = [Select id, Contact__c, Risk_Start_Period__c, Actual_Cashback__c, Payout_Status__c, Actual_Rainfall__c, Program_Reference__c, Rainfall_Threshold__c, Rainfall_Exit_Point__c, RecordType.Name FROM Programs__c WHERE recordtypeid in (Select id FROM RecordType where SObjectType = 'Programs__c' and DeveloperName IN('AgriClime_Lentils')) LIMIT 1];
        System.debug('Test Data is' +testAgriclime);
        
        //Contact testCont = [SELECT id, AgriclimeRefNumber__c, (SELECT Id, Risk_Start_Period__c, Actual_Cashback__c, Payout_Status__c, Actual_Rainfall__c, Program_Reference__c, Rainfall_Threshold__c, Rainfall_Exit_Point__c FROM Programs__r),  Payout_Email_Sent__c, Payout_Details__c, Agriclime_Total_Payout__c FROM Contact LIMIT 1 ];
        test.startTest();
        
        Update testAgriclime;
        
        test.stopTest();

        Programs__c testProg2 = new Programs__c(Account__c=testAcct.id, Program_Year__c='2015', Offer_Type__c='TestOfferType');
        try{
        	insert testProg2;
        }catch(DMLException e){}
        
        System.AssertEquals(null,testProg2.id);
        
    }

}