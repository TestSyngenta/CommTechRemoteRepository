/** 2016-01-06 Brian Hopkins
 *  test class for Contact_Trigger
 */
@isTest(SEEALLDATA = True)
public class Contact_TriggerTest2 {

    public static TestMethod void runTest(){
        Profile testProfile = [Select id from Profile where Name like '%Sales%' limit 1];
        Profile testProfile2 = [Select id from Profile where Name like '%Integration%' limit 1];
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
        User testUser2 = CLS_StaticUtils.createTestUser(testRole.id,testProfile2.id,'Pardot','User2');
        List<User> userList = new List<User>();
        userList.add(testUser1);
        userList.add(testUser2);
        insert userList;
        Account testAccount;
        Contact testContact1;
        Contact testContact2;
        Contact testContact3;
        Contact testContact4;
        Contact testContact5;
        Contact testContact6;
        Contact testContact7;        
        Contact testContact8;                
        Contact testContact9;
        Contact testInactiveContact1;
        List<Contact> insertList1 = new List<Contact>();
        List<Contact> insertList2 = new List<Contact>();
        List<Contact> insertList3 = new List<Contact>();                 
        List<Contact> deleteList1 = new List<Contact>(); 
        List<Contact> insertinactive = new List<Contact>();
        //List<Contact> insertinactiveUpdate = new List<Contact>();
        System.runAs(testUser1){
            // insert test Account
            testAccount = new Account(Name='TestAccount', OwnerID=testUser1.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
            insert testAccount;

           // insert test Contact 4 with phone
            testContact4 = new Contact(LastName='SyngentaContact_04', FirstName='Joe', Email = 'test4@goodtest.com', Phone='5556895253', AccountId=testAccount.Id, Pardot_Opt_In_Email_Communications__c = 'No', Opt_in_ECom__c = 'No (Opted-out)');
            insertList2.add(testContact4);
            insert(insertList2);

            
        }

        System.runAs(testUser1){      
            testContact3 = new Contact(LastName='SyngentaContact_03', FirstName='Joe', Email='test3@goodtest.com', AccountId=testAccount.Id, Pardot_Opt_In_Email_Communications__c = 'Yes (Express)', Opt_in_ECom__c = 'Yes (Opted-in)');
            insertList3.add(testContact3);
            insert(insertList3); 
                
        }
                       
        
        System.runAs(testUser2){
            testContact3.Pardot_Opt_In_Email_Communications__c = 'No';
            update testContact3;
        
        } 
        	
            

        System.assertEquals('No (Opted-out)', testContact4.Opt_in_ECom__c);
        
    }
}