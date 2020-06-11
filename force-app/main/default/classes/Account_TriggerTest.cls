@isTest
public class Account_TriggerTest {

    public static TestMethod void runPreferredStatusTest(){
        // create test account
        Account testAccount = new Account(Name='SyngentaTestAccount65468465465152');
        insert testAccount;
        
        // insert a contact with valid email and opt-in
        Contact testContact = new Contact(AccountId=testAccount.id, Firstname='FirstName012001201', Lastname='LastName3210491284',
                                 Email='testemail@emailtest.com', Pardot_Opt_In_Email_Communications__c = 'Yes (Express)', Opt_in_ECom__c='Yes (Opted-in)');
        insert testContact;
        
        // check that Has Opted In Contact = true
        testAccount = [Select Id, Name, Has_Opted_In_Contact__c from Account where id = :testAccount.id];
        system.assertEquals(true, testAccount.Has_Opted_In_Contact__c);


        // create test account 2
        Account testAccount2 = new Account(Name='SyngentaTestAccount65468465465153');
        insert testAccount2;

        // insert a contact with bounced email and opt-in
        Contact testContact2 = new Contact(AccountId=testAccount2.id, Firstname='FirstName012001201', Lastname='LastName3210491284',
                                 Email='testemail@emailtest.com', Pardot_Opt_In_Email_Communications__c = 'Yes (Express)', Opt_in_ECom__c='Yes (Opted-in)', Email_Bounced__c=true);
        insert testContact2;
        
        // check that Has Opted In Contact = true bc the Email Bounced will not take effect without the Pardot source field pi__pardot_hard_bounced being true
        testAccount2 = [Select Id, Name, HasEmail__c from Account where id = :testAccount2.id];
        system.assertEquals(false, testAccount2.HasEmail__c);


        /* Test for Foundation Customer */
        Foundation_Customer__c testFC = new Foundation_Customer__c(Name='Mr. Test Acccount');
        insert testFC;
        
        Account testAccountFC = new Account(Name='Mr. SortaTest Account', Foundation_Customer__c = testFC.Id);
        insert testAccountFC;
        
        testFC=[select Id, Salesforce_Account__c from Foundation_Customer__c where Id = :testFC.Id];
        
        /*Test Consolidate Winner and Loser Accounts*/
        
       	Account testAccountWinner = new Account(Name='Winning Account');
        insert testAccountWinner;
        testAccountWinner = [Select Id, Name From Account Where Id =: testAccountWinner.Id]; 
        
       	Account testAccountLoser = new Account(Name='Losing Account', Inactive__c=true);
        insert testAccountLoser;
        testAccountLoser = [Select Id, Name From Account Where Id =: testAccountLoser.Id];         
        
        testAccountLoser.Winner_Account__c=testAccountWinner.Id;
        update testAccountLoser;
        
        system.assertEquals(testFC.Salesforce_Account__c, testAccountFC.Id);
        
        
        /*Test Account for Account Snapshot*/
        Account testaccountforAccountSnapshot = new Account(Name='SyngentaTestAccount65468465465000000',Lead_Touch_Point__c ='Remote' );
        Insert testaccountforAccountSnapshot;
        testaccountforAccountSnapshot = [Select Id, Name FROM Account WHERE Id =: testaccountforAccountSnapshot.Id];
 		testaccountforAccountSnapshot.Lead_Touch_Point__c = 'F2F';            
        Update testaccountforAccountSnapshot;
        
        //Account_Snapshot__c testAccountSnapshot123456 = new Account_Snapshot__c();
        //testAccountSnapshot123456  = [Select Id, Name FROM Account_Snapshot__c WHERE Account__r.Id =:testAccountSnapshot123456.Id];  
        //testAccountSnapshot123456.End_Date__c = Date.today();
       // Update testAccountSnapshot123456;
       
    }
    
}