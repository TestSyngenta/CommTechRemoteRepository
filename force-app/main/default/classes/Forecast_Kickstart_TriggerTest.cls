@isTest
public class Forecast_Kickstart_TriggerTest{

      public static TestMethod void runTest(){
      
            Profile testProfile = [Select id from Profile where Name like '%System Administrator - Can%' limit 1];
            UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
            User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
            insert testUser1;

            Account testAccount;
    
            System.runAs(testUser1){
                // insert test Account
                testAccount = new Account(Name='TestAccount1', OwnerID=testUser1.id, NSAP_ID__c = '0050009000',
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9', Territory_Lookup__c = 'a00o00000076NkeAAE', RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId());
                insert testAccount;
                
                Account_Territory__c accTerr = new Account_Territory__c(Account__c = testAccount.Id, Territory__c = 'a00o00000076NkeAAE');
                insert accTerr;
                Forecast_Kickstart__c testfk = new Forecast_Kickstart__c(NSAP_ID__c = testAccount.NSAP_ID__c, Year__c = '2020', Related_Distributor__c = '001o000000LgRfyAAF');
                insert testfk;
                          
                Account a = [select Id, NSAP_ID__c from Account where NSAP_ID__c = '0050009000'];
                List<Business_Plan__c> bpCount = [select Id from Business_Plan__c where Account__c = :a.Id and Year__c = '2020'];
                List<Opportunity> fCount= [select Id from Opportunity where AccountId = :a.Id and Year__c = '2020'];
                            

                System.assertEquals(1,bpCount.size());
                System.assertEquals(1,fCount.size());                
        }
            


      }
}