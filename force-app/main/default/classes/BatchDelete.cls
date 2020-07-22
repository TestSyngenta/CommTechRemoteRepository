global class BatchDelete implements Database.Batchable<Contact>, database.stateful {
  global List<Contact> listofduplicateContacts = [
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
  ];
  global List<Contact> globallistofContacts = new List<Contact>();
  global List<Contact> contactstoCheck = new List<Contact>();
  global List<Contact> contactstoDelete = new List<Contact>();
  global Id globalContactId;
  global Contact Cons;
  global Map<Id, List<Contact>> mapofAccountIdwithContacts = new Map<Id, List<Contact>>();
  global List<Id> AccountIds = new List<Id>();
  global BatchDelete(Id conId, List<Contact> listofContacts) {
  }

  public Iterable<Contact> start(Database.BatchableContext bc) {
    /**for(AggregateResult ar : listofduplicateContacts){
            globallistofContacts.add(ar);

        }
**/
    //List<Contact> globallistofContacts = [Select Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = true AND Email = '' ORDER BY FirstName, LastName ];

    if (listofduplicateContacts != null) {
      for (Contact c : listofduplicateContacts) {
        if (mapofAccountIdwithContacts.containsKey(c.AccountId)) {
            List<Contact> listofRelatedContacts = mapofAccountIdwithContacts.get(c.AccountId);
            listofRelatedContacts.add(c);
            mapofAccountIdwithContacts.put(c.AccountId, listofRelatedContacts);
            
            String lastFirstName = '';
            String lastLastName = '';
                for (Contact AccContact : listofRelatedContacts) {
                    if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName) {
                        contactstoCheck.add(AccContact);
                    }
                    lastFirstName = AccContact.firstName;
                    lastLastName = AccContact.lastName;
                    if(contactstoCheck.size()>1){
                        for(Contact contoCheck : contactstoCheck){
                            if(contoCheck.Primary_Contact__c <> true && contoCheck.Has_NPS__c <> true && contoCheck.Has_Related_Case__c <> true && contoCheck.Has_Email_Retention__c <> true){
                                contactstoDelete.add(contoCheck);
                            }
                        }
                    }
                    
          }
          
        }

        // AccountIds.Add(c.AccountId);
      }
    }

    return null;
  }

  public void execute(Database.BatchableContext BC, List<Contact> conList) {
  }

  public void finish(Database.BatchableContext BC) {
  }
}
