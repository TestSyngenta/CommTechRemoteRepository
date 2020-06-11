/*  Sept 24, 2015
 *  Brian Hopkins
 *  Trigger for updating cheque numbers on Settlements.
 *      When the cheque numbers are uploaded to Settlement Payments, they will be propagated to all the Settlement children
*/  
trigger Settlement_Payment_Trigger on Settlement_Payment__c (after update) {
    
    if (Trigger.isUpdate){
        Settlement_Payment_TriggerHandler.SettlementUpdateChequeNumbers(Trigger.new,Trigger.old);
    }
    
}