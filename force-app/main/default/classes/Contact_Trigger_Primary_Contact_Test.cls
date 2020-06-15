/** 2016-01-06 Brian Hopkins
 *  test class for Contact_Trigger for Primary Contact
 */
@isTest
public class Contact_Trigger_Primary_Contact_Test {

    public static TestMethod void runTest(){
        Profile testProfile = [Select id from Profile where Name like '%Sales%' limit 1];
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
        User testUser2 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User2');
        insert testUser1;
        insert testUser2;
        
        Account testAccount;
        Account testAccount2;
        Contact testContact1;
        Contact testContact2;
        Contact testContact3;
        Contact testContact4;
        Contact testContact5;
        Contact testContact6;
        Contact testContact7;        
        Contact testContact8;                
        List<Contact> insertList1 = new List<Contact>();
        List<Contact> insertList2 = new List<Contact>();
        List<Contact> insertList3 = new List<Contact>();                 
        List<Contact> deleteList1 = new List<Contact>();                   
        System.runAs(testUser1){
            // insert test Account
            testAccount = new Account(Name='TestAccount', OwnerID=testUser1.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
            insert testAccount;
            // insert test Contact with phone
            testContact1 = new Contact(LastName='SyngentaContact_01', FirstName='Joe', Email = 'test1@goodtest.com', 
            Phone='5556895253', AccountId=testAccount.Id, Primary_Contact__c = true);
            insert testContact1;
            /*insertList1.add(testContact1);*/
            // insert test Contact 2 with email
            testContact2 = new Contact(LastName='SyngentaContact_02', FirstName='Joe', Email='test2@goodtest.com', 
            AccountId=testAccount.Id);
            insertList1.add(testContact2);
            insert(insertList1);
        }
        
        testAccount2 = [select Id, Account_Main_Contact__c from Account where Id =:testAccount.Id];      
    
        //check that Opt in Ecom is different for the two contacts (when 2 is inserted its changes were not replicated to 1)
        System.assertEquals(testContact1.Id, testAccount2.Account_Main_Contact__c);

        /* Now delete the contact and check that the Account Main Contact relationship has been nulled out */
        System.runAs(testUser1){
            delete testContact1;
        }

        testAccount2 = [select Id, Account_Main_Contact__c from Account where Id =:testAccount.Id];      
    
        //check that Opt in Ecom is different for the two contacts (when 2 is inserted its changes were not replicated to 1)
        System.assertEquals(null, testAccount2.Account_Main_Contact__c);


        System.runAs(testUser1){
            // insert test Contact with phone
            testContact3 = new Contact(LastName='SyngentaContact_03', FirstName='Joe', Email = 'test3@goodtest.com', 
            Phone='5556895253', AccountId=testAccount.Id, Primary_Contact__c = false);
            insert testContact3;

            // insert test Contact 2 with email
            testContact3.Primary_Contact__c = true;
            update testContact3;
        }
        
        testAccount2 = [select Id, Account_Main_Contact__c from Account where Id =:testAccount.Id];
    
        //check that Opt in Ecom is different for the two contacts (when 2 is inserted its changes were not replicated to 1)
        System.assertEquals(testContact3.Id, testAccount2.Account_Main_Contact__c);



    }
}