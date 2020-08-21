/**************************************************************************************
* Apex Class Name  :     TestBatchDelete
* Version            :     1.0
* Created Date       :     17/Aug/2020
* Function           :     This is Test class for Batch Delete class  
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Aakash                     17/Aug/2020                Created.
*************************************************************************************/
@isTest 
public class TestBatchDelete 
{
    public static testMethod void testMethod1() 
	{
        Profile testProfile = [Select id from Profile where Name like '%Integration%' limit 1];
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
        List<User> userList = new List<User>();
        List<Contact> conList = new List<Contact>();
        List<Duplicate_records__c> listofleavingRecords = new List<Duplicate_records__c>();
        List<Duplicate_records__c> listofRecords = new List<Duplicate_records__c>();
        userList.add(testUser1);
        insert userList;
        Account testAccount;
        Contact newContact;
        Contact newContact1;
        Set<Id> AccountIds = new Set<Id>();
        List<Contact> listofRelatedContacts = new List<Contact>();

        System.runAs(testUser1){
        testAccount =  new Account(Name='TestAccount', OwnerID=testUser1.id,
        BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
        insert testAccount;

		newContact = new Contact(LastName='SyngentaContact_01', FirstName='Joe', Duplicate_Contact_On_Same_Account__c = true, Email = '', Phone='5556895253', Primary_Contact__c = false, AccountId=testAccount.Id, Has_NPS__c = false, Has_Related_Case__c = false, Has_Email_Retention__c = false, Is_Campaign_Member__c = false, MobilePhone = '123456789');
        newContact1 = new Contact(LastName='SyngentaContact_01', FirstName='Joe', Duplicate_Contact_On_Same_Account__c = true, Email = '', Phone='5556895253', Primary_Contact__c = true, AccountId=testAccount.Id, Has_NPS__c = false, Has_Related_Case__c = false, Has_Email_Retention__c = false, Is_Campaign_Member__c = false, MobilePhone = '123456789'); 
        conList.add(newContact);
        conList.add(newContact1);
        insert conList;
        for (Contact c : conList) {
            AccountIds.add(c.AccountId);
          }
       for(Contact con: conList){
            if(con.Primary_Contact__c = true){
                Duplicate_records__c dr = new Duplicate_records__c();
              dr.Account_Id__c = newContact.AccountId;
              dr.Account_Name__c = newContact.Account.Name;
              dr.Contact_Id__c = newContact.Id;
              dr.Contact_First_Name__c = newContact.FirstName;
              dr.Contact_Last_Name__c = newContact.LastName;
              dr.Contact_is_Primary__c = true;
              dr.Contact_Phone_Number__c = newContact.Phone;
              dr.Contact_Mobile_Number__c = newContact.MobilePhone;
              dr.Had_Campaign__c = false;
              dr.Had_Email_Retention__c = false;
              dr.Had_NPS__c = false;
              dr.Had_Related_Case__c = false;

              listofleavingRecords.add(dr);
             }
             // Database.insert(listofleavingRecords, false);
             
            if(con.Primary_Contact__c = true){
              Duplicate_records__c fr = new Duplicate_records__c();
              fr.Account_Id__c = newContact1.AccountId;
              fr.Account_Name__c = newContact1.Account.Name;
              fr.Contact_Id__c = newContact1.Id;
              fr.Contact_First_Name__c = newContact1.FirstName;
              fr.Contact_Last_Name__c = newContact1.LastName;
              fr.Contact_is_Primary__c = false;
              fr.Contact_Phone_Number__c = newContact1.Phone;
              fr.Contact_Mobile_Number__c = newContact1.MobilePhone;
              fr.Had_Campaign__c = false;
              fr.Had_Email_Retention__c = false;
              fr.Had_NPS__c = false;
              fr.Had_Related_Case__c = false;
              fr.toBeDeleted__c = true;
              listofRecords.add(fr);
             }
              //insert listofRecords;
        }  
        Database.insert(listofleavingRecords, false);
        Database.insert(listofRecords, false);
           // String query = 'SELECT Id, AccountId, Account.Name, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = null ORDER BY FirstName, LastName, Primary_Contact__c ASC LIMIT 2000';
		
		Test.startTest();

			BatchDelete obj = new BatchDelete();
			DataBase.executeBatch(obj);

		Test.stopTest();
		
	}
}
}