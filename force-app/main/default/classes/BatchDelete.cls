global class BatchDelete implements Database.Batchable<Contact>, database.stateful {
 global list<Contact> listofduplicateContacts = new List<Contact>();
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
  global List<Contact> listofRelatedContacts = new List<Contact>();

  global List<Id> AccountIds = new List<Id>();
 

  global System.Iterable<Contact> start(Database.BatchableContext bc) {
    /**for(AggregateResult ar : listofduplicateContacts){
            globallistofContacts.add(ar);

        }
**/
   
    //List<Contact> globallistofContacts = [Select Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = true AND Email = '' ORDER BY FirstName, LastName ];
    System.debug('Test');
    listofduplicateContacts= [ SELECT
    Id,
    AccountId,
    FirstName,
    LastName,
    Primary_Contact__c,
    Has_NPS__c,
    Has_Related_Case__c,
    Has_Email_Retention__c,phone
  FROM Contact
  WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = '' LIMIT 200];

    if (listofduplicateContacts != null) {
      for (Contact c : listofduplicateContacts) {

            listofRelatedContacts = mapofAccountIdwithContacts.get(c.AccountId);
            //if(listofRelatedContacts == null){
                listofRelatedContacts = new List<Contact>();
                listofRelatedContacts.add(c);
                mapofAccountIdwithContacts.put(c.AccountId, listofRelatedContacts);
            //}

            //if(mapofAccountIdwithContacts.get(c.AccountId)!= null)
            //{
            //listofRelatedContacts = mapofAccountIdwithContacts.get(c.AccountId);
            //mapofAccountIdwithContacts.put(c.AccountId, listofRelatedContacts);
            //mapofAccountIdwithContacts.get(c.AccountId).add(c);
            
            //listofRelatedContacts = mapofAccountIdwithContacts.get(c.AccountId);
            //listofRelatedContacts.add(c);
                       //listofRelatedContacts.add(c);
            
           
            //mapofAccountIdwithContacts.get(c.AccountId).add(c);
            //mapofAccountIdwithContacts.put(c.AccountId, listofRelatedContacts);
            //}
      //} 
        
        System.debug('Test first Contact in the loop' +listofRelatedContacts);
            //mapofAccountIdwithContacts.put(c.AccountId, listofRelatedContacts);
            
            
            for(Contact con : mapofAccountIdwithContacts.get(c.AccountId)){
        
            //if (mapofAccountIdwithContacts.containsKey(c.AccountId)) {
            //List<Contact> listofRelatedContacts = mapofAccountIdwithContacts.get(c.AccountId);
            //listofRelatedContacts.add(c);
            //mapofAccountIdwithContacts.put(c.AccountId, listofRelatedContacts);
            
            String lastFirstName = '';
            String lastLastName = '';
                //for (Contact AccContact : listofRelatedContacts) {
                  for(integer i=0; i<listofRelatedContacts.size(); i++){
                      for(Contact AccContact : listofRelatedContacts){
                        if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName) {
                        contactstoCheck.add(AccContact);
                        System.debug('Check Contacts to check' +AccContact.FirstName);                        
                     
                }
                    lastFirstName = AccContact.firstName;
                    lastLastName = AccContact.lastName;

                }   
            }//if only one contact is there in the list, it means the other duplicate one with email is not there in the list  
                    contactstoCheck.add(listofRelatedContacts[0]);   
                    
                    //if there are more than one contact in the list related to an account then it would check for related records and other conditions.
                    if(contactstoCheck.size()>1){
                        for(Contact contoCheck : contactstoCheck){
                            String tempPhone = '';
                            //checks for related record and if there is no rela
                            if(contoCheck.Primary_Contact__c <> true && contoCheck.Has_NPS__c <> true && contoCheck.Has_Related_Case__c <> true && contoCheck.Has_Email_Retention__c <> true){
                                contactstoDelete.add(contoCheck); 
                                if(contoCheck.phone <> null){
                                    tempPhone = contoCheck.phone;
                                }
                            }                        
                            else if(contoCheck.phone == null){

                                contoCheck.phone = tempPhone;
                                
                            }
                            //return contactstoDelete;
                            //return null;

                        }
                    }
                    
          }
        }

        // AccountIds.Add(c.AccountId);
      
    }System.debug('Check Contacts to check' +contactstoDelete);
    return contactstoDelete;
   
  }

  global void execute(Database.BatchableContext BC, List<Contact> conList) {
      Delete conList;
  }

  global void finish(Database.BatchableContext BC) {
  }
}
