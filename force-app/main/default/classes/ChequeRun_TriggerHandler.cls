public class ChequeRun_TriggerHandler {

    /* Update all the related Settlement and Settlement Payments Status as set on the Cheque Run*/
    public static void updateRelatedStatus(Cheque_Run__c[] newList, Cheque_Run__c[] oldList){
        Map<Id,String> crStatusMap = new Map<Id,String>();
        Map<Id,String> settlementStatusMap = new Map<Id,String>();
        List<Id> crIDs = new List<Id>();
        for (Cheque_Run__c cr : newList){
            settlementStatusMap.put(cr.Id, cr.Settlements_Status__c);
            crStatusMap.put(cr.Id, cr.Status__c);
            crIDs.add(cr.Id);
        }
        
        Map<Id,Settlement_Payment__c> paymentMap = new Map<Id,Settlement_Payment__c>([Select Id, Status__c, Cheque_Run__c from Settlement_Payment__c where Cheque_Run__c in :crIDs]);
        List<Settlement_Payment__c> paymentupdateList = new List<Settlement_Payment__c>();
        List<Id> spIDs = new List<Id>();
        for (Settlement_Payment__c sp : paymentMap.values()){
            if(crStatusMap.get(sp.Cheque_Run__c)=='Cancelled'){
                sp.Status__c = 'Cancelled';
                paymentupdateList.add(sp);
            }else if (sp.Status__c <> settlementStatusMap.get(sp.Cheque_Run__c)){
                sp.Status__c = settlementStatusMap.get(sp.Cheque_Run__c);
                paymentupdateList.add(sp);
            }
            spIDs.add(sp.Id);
        }
        
        List<Settlement__c> settlementList = [Select Id, Settlement_Payment__c, Status__c from Settlement__c where Settlement_Payment__c in :spIDs];
        List<Settlement__c> settlementUpdateList = new List<Settlement__c>();
        for (Settlement__c s : settlementList){
            if (crStatusMap.get(paymentMap.get(s.Settlement_Payment__c).Cheque_Run__c)=='Cancelled'){
                s.Status__c = 'Submitted for Payment';
                s.Settlement_Payment__c = null;
                settlementUpdateList.add(s);
            }else if (s.Status__c <> settlementStatusMap.get(paymentMap.get(s.Settlement_Payment__c).Cheque_Run__c)){
                s.Status__c = settlementStatusMap.get(paymentMap.get(s.Settlement_Payment__c).Cheque_Run__c);
                settlementUpdateList.add(s);
            }
        }
        
        SavePoint snapshot = Database.setSavepoint();
        try{
            update paymentupdateList;
            update settlementUpdateList;
        }    
        catch(Exception e) {
            newList[0].addError(string.valueof(e));
        }
        
    }
    
}