/* 2017-05-17 Trevor Cornfield
 * Trigger for Foundation Customer Updates
 *
 * After: Update the Account object with changes to the relationship to Foundation Customer
 */


trigger FoundationCustomer_Trigger on Foundation_Customer__c (after update, after delete) {
    if(Trigger.isAfter){
        FoundationCustomer_TriggerHandler.updateAccountToFoundationCustomerRel(Trigger.new, Trigger.old);
    }
}