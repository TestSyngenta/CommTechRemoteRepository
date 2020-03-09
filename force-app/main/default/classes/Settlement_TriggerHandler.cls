/* 2015-03-01 Brian Hopkins
 * 
 */
public class Settlement_TriggerHandler {
    
    /*
     * Function for assigning approvers to Settlement records.
     *  The approvers are assigned as:
     *  - If submitter has DOA = 'NO DOA' then use the approvers of the Case's Owner.
     *  - If submitter has any other DOA then use the approvers of the submitter.
     */
    public static void SettlementUpdateApprovers(Settlement__c[] newList, Settlement__c[] oldList){
        List<id> caseIDs = new List<id>();
        List<id> settlementIDs = new List<id>();
        List<Settlement__c> newSettlements = new List<Settlement__c>();
        
        for (Integer i=0; i<newList.size(); i++){
                caseIDs.add(newList[i].Case__c);
                newSettlements.add(newList[i]);
        }
                
        if (newSettlements.size()==0){
            return;
        }
    
        /* Get all the related Cases and Accounts */
        Map<Id,Case> relatedCaseMap = new Map<Id,Case>([Select Id, OwnerId, Account.OwnerId from Case where Id in :caseIDs]);
        List<Id> accountIDs = new List<Id>();
        for (Case c: relatedCaseMap.values()){
            accountIDs.add(c.AccountID);
        }
        Map<Id,Account> relatedAccountMap = new Map<Id,Account>([Select id, OwnerID from Account where Id in :accountIDs]);
        
        List<Id> userIDs = new List<Id>();
        User currentUser = [SELECT Name, Id, DOA__c, Approver_Level_1__c, Approver_Level_2__c, Approver_Level_3__c, Approver_Level_4__c, 
                                    Customer_Marketing_Manager__c, District_Manager__c, CU_Head__c
                            FROM User WHERE Id = : UserInfo.getUserId() limit 1];
        
        /* Get all the related Users/Approvers */
        for(Settlement__c s : newSettlements){
            if (currentUser.DOA__c == 'No DOA'){
                /* Add Case Owner */
                userIDs.add(relatedCaseMap.get(s.Case__c).OwnerId);
            }else{
                /* Add Submitter  */
                userIDs.add(UserInfo.getUserId());
            }

        }
        
        Map<Id,User> userMap = new Map<Id,User>(
            [Select id, LastName, Approver_Level_1__c, Approver_Level_2__c, Approver_Level_3__c, Approver_Level_4__c, 
                Customer_Marketing_Manager__c, District_Manager__c, CU_Head__c, DOA__c
             from User where Id in :userIDs]
        );
        
        /* Assign owners and approvers to the Settlement */
        User owner;
        Account acc;
        for (Settlement__c s: newList){
            if (currentUser.DOA__c == 'No DOA'){
                // use case owner approvers
                  owner = userMap.get(relatedCaseMap.get(s.Case__c).OwnerId);
    //            system.debug('TRG_Settlement_Approvers: NO DOA.....');
    //            system.debug('TRG_Settlement_Approvers: s.Case__c = '+s.Case__c);
    //            system.debug('TRG_Settlement_Approvers: s.Case__r.AccountID = '+relatedCaseMap.get(s.Case__c).AccountID);
    //            system.debug('TRG_Settlement_Approvers: s.Case__r.Account.OwnerID = '+relatedAccountMap.get(relatedCaseMap.get(s.Case__c).AccountID).OwnerID);
    //            system.debug('TRG_Settlement_Approvers: Looking up user ID: '+relatedAccountMap.get(relatedCaseMap.get(s.Case__c).AccountID).OwnerID);
    //            system.debug('TRG_Settlement_Approvers: Owner is : '+owner);
                s.Approver_Level_1__c = owner.Id;
                s.Approver_Level_2__c = owner.Approver_Level_1__c;
                s.Approver_Level_3__c = owner.Approver_Level_2__c;
                s.Approver_Level_4__c = owner.Approver_Level_3__c;
                s.Approver_Level_5__c = owner.Approver_Level_4__c;
                s.Customer_Marketing_Manager__c = owner.Customer_Marketing_Manager__c;
                s.District_Manager__c = owner.District_Manager__c;
                s.CU_Head__c = owner.CU_Head__c;
                s.Case_Owner_DOA__c = owner.DOA__c;
            }else{
                // use case submitter approvers
                owner = userMap.get(relatedCaseMap.get(s.Case__c).OwnerID);
    //            system.debug('TRG_Settlement_Approvers: DOA......');
    //            system.debug('TRG_Settlement_Approvers: s.Case__c = '+s.Case__c);
    //            system.debug('TRG_Settlement_Approvers: s.Case__r.AccountID = '+relatedCaseMap.get(s.Case__c).AccountID);
    //            system.debug('TRG_Settlement_Approvers: Looking up user ID: '+relatedCaseMap.get(s.Case__c).OwnerID);
    //            system.debug('TRG_Settlement_Approvers: Owner is : '+owner);
                s.Approver_Level_1__c = currentUser.Approver_Level_1__c;
                s.Approver_Level_2__c = currentUser.Approver_Level_2__c;
                s.Approver_Level_3__c = currentUser.Approver_Level_3__c;
                s.Approver_Level_4__c = currentUser.Approver_Level_4__c;
                s.Customer_Marketing_Manager__c = currentUser.Customer_Marketing_Manager__c;
                s.District_Manager__c = currentUser.District_Manager__c;
                s.CU_Head__c = currentUser.CU_Head__c;
                s.Case_Owner_DOA__c = currentUser.DOA__c;
            }        
        }
    }
}