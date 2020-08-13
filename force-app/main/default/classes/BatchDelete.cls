global class BatchDelete implements Database.Batchable<sObject> {
  global List<Contact> globallistofContacts = new List<Contact>();
  global List<Contact> contactstoCheck = new List<Contact>();
  global List<Contact> contactstoDelete = new List<Contact>();
  global List<Contact> contactsToKeep = new List<Contact>();
  global Id globalContactId;
  global Contact Cons;
  //global Map<Id, List<Contact>> mapofAccountIdwithContacts = new Map<Id, List<Contact>>();

  //global List<Contact> listofRelatedContacts = new List<Contact>();

  global Set<Id> AccountIds = new Set<Id>();

  global Database.QueryLocator start(Database.BatchableContext bc) {
    string query = ' SELECT Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = null LIMIT 200';
    return Database.getQueryLocator(query);
  }

  global void execute(Database.BatchableContext BC, List<Contact> listofduplicateContacts) {
    if (listofduplicateContacts <> null) {
      for (Contact c : listofduplicateContacts) {
        AccountIds.add(c.AccountId);
      }
    }   

    for (Id loopId : AccountIds) {
      List<Contact> listofRelatedContacts = [
        SELECT Id, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone
        FROM Contact
        WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = NULL AND AccountId = :loopId
      ];

      //System.debug('Test first Contact in the loop' + listofRelatedContacts);
      
      
     
      String lastFirstName = '';
      String lastLastName = '';
      
      for (Contact AccContact : listofRelatedContacts) {
        if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName && AccContact.Has_NPS__c <> true && AccContact.Has_Related_Case__c <> true && AccContact.Has_Email_Retention__c <> true && AccContact.Is_Campaign_Member__c <> true) {
          
          contactstoCheck.add(AccContact);
          System.debug('Check Contacts to check' + contactstoCheck);
          
        }
        lastFirstName = AccContact.FirstName;
        lastLastName = AccContact.LastName;
      }
      if(contactstoCheck.size() == 1){
      contactstoCheck.add(listofRelatedContacts[0]);
      }
      System.debug('Check Contacts to check' + contactstoCheck.size());
    //}
    if (contactstoCheck.size() == 2) {

      Boolean executed = false;
      for (Contact contoCheck : contactstoCheck) {
        String tempPhone = '';
        
        //checks for related record and if there is no rela
        if ( !executed && contoCheck.Primary_Contact__c <> true ) {
            contactstoDelete.add(contoCheck);
           
            System.debug('Check Contacts to check' + contactstoDelete);
          
            if (contoCheck.phone <> null) {
            tempPhone = contoCheck.phone;
          }
            else if (contoCheck.phone == null) {
            contoCheck.phone = tempPhone;
          }
            executed = true;
        }
       
        
      }
    }
  }
    
    //delete contactstoDelete;
  }

  global void finish(Database.BatchableContext BC) {
  }
}
