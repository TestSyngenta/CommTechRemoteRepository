global class BatchUpdateContactstoActive implements Database.Batchable<sObject> {

    global Id AccountIds = '001o0000010sviy';
    global List<Contact> UpdatedList = new List<Contact>(); 
  
    global Database.QueryLocator start(Database.BatchableContext bc) {
  
      string query = ' SELECT Id, Inactive__c FROM Contact WHERE AccountId =: AccountIds and Inactive__c = true and Original_Account__c != null LIMIT 30 FOR UPDATE';
      return Database.getQueryLocator(query);
      
      }
     
  
  
    global void execute(Database.BatchableContext BC, List<Contact> listofContacts) {
      if (listofContacts <> null) {
          for (Contact c : listofContacts) {
                c.Inactive__c = false;
                UpdatedList.add(c);
          }
        }update(UpdatedList);
          //List<Account> AccConList = [SELECT id, (SELECT Id, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, phone FROM Contacts) FROM Account WHERE Id IN: AccountIds];
        
  
  }
  
  global void finish(Database.BatchableContext BC) {
    }
  }
  