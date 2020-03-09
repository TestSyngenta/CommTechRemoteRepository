/* 2015-09-24 Brian Hopkins
 * 
 */
public class Settlement_Payment_TriggerHandler {
    
    public static void SettlementUpdateChequeNumbers(Settlement_Payment__c[] newList, Settlement_Payment__c[] oldList){
        Map<Id,Settlement_Payment__c> paymentMap = new Map<Id,Settlement_Payment__c>();
        
        for (Integer i=0; i< newList.size(); i++){
            /*if (newList[i].Cheque_Number__c <> oldList[i].Cheque_Number__c){
            No condition required for payment to get updated.
            */
                paymentMap.put(newList[i].ID,newList[i]);
            /*}*/
        }
        List<Settlement__c> settlementList = [Select Id, Settlement_Payment__c, Check_Order__c, Cheque_Status__c, Date_Cheque_Cashed__c, Date_Settlement_Issued__c
                                              from Settlement__c where Settlement_Payment__c in :paymentMap.Keyset()];
        List<Settlement__c> updateList = new List<Settlement__c>();
        
        for (Settlement__c s : settlementList){
            if (s.Check_Order__c <> paymentMap.get(s.Settlement_Payment__c).Cheque_Number__c ||
                s.Cheque_Status__c <> paymentMap.get(s.Settlement_Payment__c).Cheque_Status__c ||
                s.Date_Cheque_Cashed__c <> paymentMap.get(s.Settlement_Payment__c).Date_Cheque_Cashed__c ||
                s.Date_Settlement_Issued__c <> paymentMap.get(s.Settlement_Payment__c).Date_Settlement_Issued__c
            ){
                s.Check_Order__c = paymentMap.get(s.Settlement_Payment__c).Cheque_Number__c;
                s.Cheque_Status__c = paymentMap.get(s.Settlement_Payment__c).Cheque_Status__c;
                s.Date_Cheque_Cashed__c = paymentMap.get(s.Settlement_Payment__c).Date_Cheque_Cashed__c;
                s.Date_Settlement_Issued__c = paymentMap.get(s.Settlement_Payment__c).Date_Settlement_Issued__c;
                updateList.add(s);
            }
        }
        
        update(updateList);
    }

}