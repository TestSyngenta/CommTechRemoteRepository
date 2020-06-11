@isTest
public class FoundationCustomer_TriggerTest{

      public static TestMethod void runTest(){
      
            Profile testProfile = [Select id from Profile where Name like '%System Administrator - Can%' limit 1];
            UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
            User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
            insert testUser1;
            Account testAccount;
            Account testAccount2;
            Account testAccount3;
            Account testAccount4;
            Account testAccount5;
            Account testAccount6;
            Foundation_Customer__c testFoundationCustomer1;
    
            System.runAs(testUser1){
                // insert test Account
                testAccount = new Account(Name='TestAccount1', OwnerID=testUser1.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
                insert testAccount;
                // insert test Contact with phone
                testFoundationCustomer1 = new Foundation_Customer__c(Name='Foo');
                insert(testFoundationCustomer1);
                
                testFoundationCustomer1.Salesforce_Account__c = testAccount.Id;
                testFoundationCustomer1.Salesforce_Retailer_Account__c = testAccount.Id;                
                update testFoundationCustomer1;
                testAccount = [select Id, Foundation_Customer__c from Account where Id = :testAccount.Id];
            
            }
                        
            System.assertEquals(testAccount.Foundation_Customer__c, testFoundationCustomer1.Id);
            
            System.runAs(testUser1){
                testAccount2 = new Account(Name='TestAccount4', OwnerID=testUser1.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
                insert testAccount2;
                testFoundationCustomer1.Salesforce_Account__c = testAccount2.Id;
                testFoundationCustomer1.Salesforce_Retailer_Account__c = testAccount2.Id;                
                update testFoundationCustomer1;
                testAccount5 = [select Id, Foundation_Customer__c from Account where Id = :testAccount2.Id];
                testAccount6 = [select Id, Foundation_Customer__c from Account where Id = :testAccount.Id];                
            }

            System.assertEquals(null, testAccount6.Foundation_Customer__c);
            System.assertEquals(testAccount5.Foundation_Customer__c, testFoundationCustomer1.Id);

            System.runAs(testUser1){
                testFoundationCustomer1.Salesforce_Account__c = null;
                testFoundationCustomer1.Salesforce_Retailer_Account__c = null;                
                update testFoundationCustomer1;
                testAccount3 = [select Id, Foundation_Customer__c from Account where Id = :testAccount2.Id];
            }
            System.assertEquals(testAccount3.Foundation_Customer__c, null);

            System.runAs(testUser1){                                      
                testFoundationCustomer1.Salesforce_Account__c = testAccount2.Id;
                update testFoundationCustomer1;
                testAccount3 = [select Id, Foundation_Customer__c from Account where Id = :testAccount2.Id];
            }

            System.assertEquals(testAccount3.Foundation_Customer__c, testFoundationCustomer1.Id);
            
            
            


      }
}