global class BatchDelete implements Database.Batchable<sObject> {
  //global list<Contact> listofduplicateContacts = new List<Contact>();
  /**  global List<Contact> listofduplicateContacts = [
    SELECT
      Id,
      AccountId,
      FirstName,
      LastName,
      Primary_Contact__c,
      Has_NPS__c,
      Has_Related_Case__c,
      Has_Email_Retention__c
    FROM Contact
    WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = ''
  ];**/
  global List<Contact> globallistofContacts = new List<Contact>();
  global List<Contact> contactstoCheck = new List<Contact>();
  global List<Contact> contactstoDelete = new List<Contact>();
  global List<Contact> contactsToKeep = new List<Contact>();
  global Id globalContactId;
  global Contact Cons;
  global Map<Id, List<Contact>> mapofAccountIdwithContacts = new Map<Id, List<Contact>>();
 
  //global List<Contact> listofRelatedContacts = new List<Contact>();

  global Set<Id> AccountIds = new Set<Id>();

  global Database.QueryLocator start(Database.BatchableContext bc) {

    string query = ' SELECT Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, phone FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = null';
    return Database.getQueryLocator(query);
    
    
    /** 

    if (listofduplicateContacts != null) {
      for (Contact c : listofduplicateContacts) {
        AccountIds.add(c.AccountId);
      }
      
      //List<Account> AccConList = [SELECT id, (SELECT Id, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, phone FROM Contacts) FROM Account WHERE Id IN: AccountIds];
      
      for(Id loopId : AccountIds){
            //listofRelatedContacts.add(loopId.Contact);
            //System.debug('List of Related Contacts', +loopId.Contact);  
        List<Contact> listofRelatedContacts = [SELECT Id,FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, phone FROM Contact WHERE AccountId =: loopId];
          
        
      
     
    
    

        System.debug('Test first Contact in the loop' + listofRelatedContacts);
        

       
          
          String lastFirstName = '';
          String lastLastName = '';
         
            for (Contact AccContact : listofRelatedContacts) {
              if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName) {
                contactstoCheck.add(AccContact);
                System.debug('Check Contacts to check' + AccContact.FirstName);
              }
              lastFirstName = AccContact.firstName;
              lastLastName = AccContact.lastName;
            }
            if(listofRelatedContacts.size()>0){
            contactstoCheck.add(listofRelatedContacts[0]);
            }
      
          if (contactstoCheck.size() > 1) {
            for (Contact contoCheck : contactstoCheck) {
              String tempPhone = '';
              //checks for related record and if there is no rela
              if (contoCheck.Primary_Contact__c <> true && contoCheck.Has_NPS__c <> true && contoCheck.Has_Related_Case__c <> true && contoCheck.Has_Email_Retention__c <> true) {
                contactstoDelete.add(contoCheck);
                if (contoCheck.phone <> null) {
                  tempPhone = contoCheck.phone;
                }
              } else if (contoCheck.phone == null) {
                contoCheck.phone = tempPhone;
              }
              //return contactstoDelete;
              //return null;
            }
          }
        
      }**/

      // AccountIds.Add(c.AccountId);
    }
    //System.debug('Check Contacts to check' + contactstoDelete);
    //return contactstoDelete;
 // }

  global void execute(Database.BatchableContext BC, List<Contact> listofduplicateContacts) {
    if (listofduplicateContacts <> null) {
        for (Contact c : listofduplicateContacts) {
          AccountIds.add(c.AccountId);
        }
      }
        //List<Account> AccConList = [SELECT id, (SELECT Id, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, phone FROM Contacts) FROM Account WHERE Id IN: AccountIds];
        
        for(Id loopId : AccountIds){
              //listofRelatedContacts.add(loopId.Contact);
              //System.debug('List of Related Contacts', +loopId.Contact);  
          List<Contact> listofRelatedContacts = [SELECT Id,FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, phone FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = null AND AccountId =: loopId];
            

          System.debug('Test first Contact in the loop' + listofRelatedContacts);
     
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
              if(contactstoCheck.size() < 2){
              contactstoCheck.add(listofRelatedContacts[0]);
              }
              }
            if (contactstoCheck.size() > 1) {
              for (Contact contoCheck : contactstoCheck) {
                String tempPhone = '';
                //checks for related record and if there is no rela
                if (contoCheck.Primary_Contact__c <> true && contoCheck.Has_NPS__c <> true && contoCheck.Has_Related_Case__c <> true && contoCheck.Has_Email_Retention__c <> true) {
                  contactstoDelete.add(contoCheck);
                  System.debug('Check Contacts to check' + contactstoDelete);
                  if (contoCheck.phone <> null) {
                    tempPhone = contoCheck.phone;
                  }
                } else if (contoCheck.phone == null) {
                  contoCheck.phone = tempPhone;
                }
                //return contactstoDelete;
                //return null;
              }
            
    
    
  }
//}
delete contactstoDelete;

}

global void finish(Database.BatchableContext BC) {
  }
}
