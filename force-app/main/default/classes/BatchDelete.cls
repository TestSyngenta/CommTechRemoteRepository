global class BatchDelete implements Database.Batchable<Contact>,database.stateful {
    global List<Contact> listofduplicateContacts =  [Select Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = true AND Email = ''];
    global List<Contact> globallistofContacts = new List<Contact>();
    global List<Contact> contactstoDelete = new List<Contact>();
    global Id globalContactId;
    global Contact Cons;
    Map<Id, List<Contact>> mapofAccountIdwithContacts = new Map<Id, List<Contact>>(); 
    List<Id> AccountIds = new List<Id>();
    global BatchDelete(Id conId, List<Contact> listofContacts) {



        
    

        

    }


    public Iterable<Contact> start(Database.BatchableContext bc){
        
        /**for(AggregateResult ar : listofduplicateContacts){
            globallistofContacts.add(ar);

        }
**/
        //List<Contact> globallistofContacts = [Select Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = true AND Email = '' ORDER BY FirstName, LastName ];
        
        if(listofduplicateContacts != null){
            for(Contact c : listofduplicateContacts){

                if(mapofAccountIdwithContacts.containsKey(c.AccountId)){
                    List<Contact> lis = mapofAccountIdwithContacts.get(c.AccountId);
                    lis.add(c);
                    mapofAccountIdwithContacts.put(c.AccountId, lis);
                    String lastFirstName = '';
                    String lastLastName = '';
                    for(Contact AccContacts: lis){
                        if(AccContacts.FirstName == lastFirstName && AccContacts.LastName == lastLastName){
                            contactstoDelete.add(AccContacts);
                        } 
                        lastFirstName = AccContacts.firstName;
                        lastLastName = AccContacts.lastName;
                    }

                }
                
               // AccountIds.Add(c.AccountId);
             }
            
        }
    

        return null;
    }

    public void execute(Database.BatchableContext BC, List<Contact> conList){
}

    public void finish(Database.BatchableContext BC) {
}
}