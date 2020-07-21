public class BatchDelete implements Database.Batchable<Contact> {
    public List<Contact> listofduplicateContacts =  [Select Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = true AND Email = ''];
        
    public BatchDelete() {

    }
}
