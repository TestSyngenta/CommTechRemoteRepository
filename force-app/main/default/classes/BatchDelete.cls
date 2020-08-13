global class BatchDelete implements Database.Batchable<sObject> {
  global List<Contact> globallistofContacts = new List<Contact>();
  global List<Contact> contactstoCheck = new List<Contact>();
  global List<Contact> contactstoDelete = new List<Contact>();
  global List<Contact> contactsToKeep = new List<Contact>();
  global Id globalContactId;
  global Contact Cons;
  //global List<Duplicate_Contacts__c> dcList  = new List<Duplicate_Contacts__c>();
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
    List<Duplicate_Records__c> dcList = new List<Duplicate_Records__c>();
    for (Id loopId : AccountIds) {
      List<Contact> listofRelatedContacts = [
        SELECT Id, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone
        FROM Contact
        WHERE Duplicate_Contact_On_Same_Account__c = FALSE AND Email = NULL AND Has_NPS__c = FALSE AND Has_Related_Case__c = FALSE AND Has_Email_Retention__c  = FALSE AND Is_Campaign_Member__c = FALSE AND AccountId = :loopId
      ];

      //System.debug('Test first Contact in the loop' + listofRelatedContacts);

      String lastFirstName = '';
      String lastLastName = '';

      for (Contact AccContact : listofRelatedContacts) {
        if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName) {
          contactstoCheck.add(AccContact);
          System.debug('Check Contacts to check' + contactstoCheck);

          
        }
        lastFirstName = AccContact.FirstName;
        lastLastName = AccContact.LastName;
        
        }
        if (contactstoCheck.Size()>0) {
          contactstoCheck.add(listofRelatedContacts[0]);
      } 
    
      //Update dcList;
  
      System.debug('Check Contacts to check' + contactstoCheck.size());
      }
      if (contactstoCheck.size() == 2) {
        Boolean executed = false;
        for (Contact contoCheck : contactstoCheck) {
          String tempPhone = '';

          //checks for related record and if there is no rela
          if (!executed && contoCheck.Primary_Contact__c <> true) {
            contactstoDelete.add(contoCheck);

            System.debug('Check Contacts to check' + contactstoDelete);

            Duplicate_Records__c dr = new Duplicate_Records__c();
            dr.Duplicate_Contacts__c = contoCheck.Id;
            dr.toBeDeleted__c = true;
            insert (dr);

            if (contoCheck.phone <> null) {
              tempPhone = contoCheck.phone;
            } else if (contoCheck.phone == null) {
              contoCheck.phone = tempPhone;
            }
            executed = true;
          } else if (executed && contoCheck.Primary_Contact__c == true) {
            Duplicate_Records__c dr = new Duplicate_Records__c();
            dr.Duplicate_Contacts__c = contoCheck.Id;
            insert (dr);
          }
        }
      }
    //}

    //delete contactstoDelete;
  }

  global void finish(Database.BatchableContext BC) {
  }
}
