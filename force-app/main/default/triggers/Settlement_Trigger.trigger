/*  Jan 26, 2015
 *  Brian Hopkins
 *  Trigger for assigning approvers to Settlement records.
*/  
trigger Settlement_Trigger on Settlement__c (before insert) {
    
    Settlement_TriggerHandler.SettlementUpdateApprovers(Trigger.new, Trigger.old);
    
}