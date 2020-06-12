trigger Account_Trigger on Account (before insert, before update, after insert, after update, after Delete) {    
    if (Trigger.isAfter){
     
        List<Id> accountIds = new List<Id>();
        
        if (Trigger.isInsert || Trigger.isUpdate){
            for (Account a : Trigger.new){
                accountIds.add(a.Id);
            }
        }
        Account_TriggerHandler.updateContactInfoOnAccount(accountIds);
        
        if(Trigger.isInsert){
            Account_TriggerHandler.updateFoundationCustomerForInsertedAccount(Trigger.new);
        }
        
        if(Trigger.isUpdate) {
            
            Account_TriggerHandler.consolidateWinnerAndLoserAccounts(Trigger.New); 
        }
        if(Trigger.isBefore || Trigger.isUpdate){
            Map<Id, String> mapofoldIdandTouchpoint = new Map<Id, String>();
            //Map<Id, String> mapofChangedAccounts = new Map<Id, String>();
            List<Id> setofChangedAccounts = new List<Id>();            
            for(Account acc: Trigger.new){
                if(Trigger.oldMap.get(acc.Id).Lead_Touch_Point__c != acc.Lead_Touch_Point__c){
                    setofChangedAccounts.add(acc.Id);
                    //mapofChangedAccounts.put(acc.Id, Trigger.newMap.get(acc.Id).Lead_Touch_Point__c);
                    mapofoldIdandTouchpoint.put(acc.Id, Trigger.oldMap.get(acc.Id).Lead_Touch_Point__c);
                    
                }					                
            }
            
            Account_TriggerHandler.createAccountSnapshotOnAccountFieldChanges(setofChangedAccounts,mapofoldIdandTouchpoint);
            //Account_TriggerHandler.createAccountSnapshotOnAccountFieldChanges(mapofChangedAccounts,mapofoldIdandTouchpoint);
        }

       
        
    }
    
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        Account_TriggerHandler.removeCRFromTextFields(Trigger.new);
        
    }   
}