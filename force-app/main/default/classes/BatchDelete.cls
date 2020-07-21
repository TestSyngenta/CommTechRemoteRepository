global class BatchDelete implements Database.Batchable<Contact>,database.stateful {
    global List<Contact> listofduplicateContacts =  [Select Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = true AND Email = ''];
    global List<Contact> globallistofContacts;
    global Id globalContactId;
    global Contact Cons;
    Map<Id, List<Contact>> mapofAccountIdwithContacts = new Map<Id, List<Contact>>(); 
    List<Id> AccountIds = new List<Id>();
    global BatchDelete(Id conId, List<Contact> listofContacts) {



        
    

        

    }


    public Iterable<Contact> start(Database.BatchableContext bc){
        if(listofduplicateContacts != null){
            for(Contact c : listofduplicateContacts){
                mapofAccountIdwithContacts.addAll(c.Id, c);
                AccountIds.Add(c.AccountId);
             }
            
        }
    

        return null;
    }

    public void execute(Database.BatchableContext BC, List<Contact> conList){
}

    public void finish(Database.BatchableContext BC) {
}
}