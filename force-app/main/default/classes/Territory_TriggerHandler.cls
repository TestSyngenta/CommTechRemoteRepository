public class Territory_TriggerHandler {
    
    public static void updateAssignments(Territory__c[] oldList, Territory__c[] newList){
    
        Map<Id, Territory__c> oldTerritoryMap = new Map<Id, Territory__c>();
        Map<Id,Id> assignedRepMap = new Map<Id,Id>();
        List<Id> oldRepList = new List<Id>();
        List<Id> territoriesToProcess = new List<Id>();
        List<Account> accountsToProcess = new List<Account>();
        List<Id> accountIDsToProcess = new List<Id>();
        List<Account_Territory__c> accTerrsToProcess = new List<Account_Territory__c>();
        List<Business_Plan__c> bpToProcess = new List<Business_Plan__c>();
        List<Opportunity> oppToProcess = new List<Opportunity>();
        
        
    
        /* Make a map of all the old versions of Territory__c records being updated */
        for(Territory__c t : oldList){
            if(oldTerritoryMap.get(t.Id)==null){
                oldTerritoryMap.put(t.Id, t);
            }
        }
    
        /* If the Assigned Rep changed in the update, flag the territory as needing more processing 
        (to update retailers, distributors, Business Plans and Forecasts) and create a map from the territory to the new Rep */
        for(Territory__c newTerr : newList){
            System.Debug('Old Rep is ' + oldTerritoryMap.get(newTerr.Id).Assigned_Rep__c + ' and New Rep is ' + newTerr.Assigned_Rep__c);
            if(newTerr.Assigned_Rep__c != oldTerritoryMap.get(newTerr.Id).Assigned_Rep__c){
                territoriesToProcess.add(newTerr.Id);
                assignedRepMap.put(newTerr.Id, newTerr.Assigned_Rep__c);
                oldRepList.add(oldTerritoryMap.get(newTerr.Id).Assigned_Rep__c);
            }
        }
    
        /* Pick out the list of Retailer and Distributor accounts to update to the new rep */
        accountsToProcess = [select Id, Territory_Lookup__c from Account where inactive__c = false and Territory_Lookup__c in :territoriesToProcess and OwnerId in :oldRepList and (RecordType.DeveloperName in ('CA_Retailer','CA_Distributor'))];
                
        /* Reassign the Accounts to the new Rep and add the Account IDs to a new List */
        for(Account a: accountsToProcess){
            a.ownerId = assignedRepMap.get(a.Territory_Lookup__c);
            accountIDsToProcess.add(a.Id);
        }
        System.Debug('Accounts to Process: ' + accountsToProcess.size());
        update accountsToProcess;
        
        /* Update the Account Territory Records even if there is no change so that the updates are sent to CMD */
        accTerrsToProcess = [select Id, Account__c, Territory__c from Account_Territory__c where Account__c in :accountIDsToProcess and Territory__c in :territoriesToProcess];
        update accTerrsToProcess;
        
        /* Reassign the Business Plans to the new Rep */
        bpToProcess = [select Id, Name, Territory__c, ownerId, Account__c, Account__r.Territory_Lookup__c from Business_Plan__c where Account__c in :accountIDsToProcess];
        
        for(Business_Plan__c bp : bpToProcess){
            System.debug('BP Name is ' + bp.Name);
            bp.ownerId = assignedRepMap.get(bp.Account__r.Territory_Lookup__c);
        }

        update bpToProcess;

        /* Reassign the Opportunities to the new Rep */
        oppToProcess = [select Id, ownerId, Territory__c, AccountId from Opportunity where AccountId in :accountIDsToProcess and Territory__c in :territoriesToProcess];
        
        for(Opportunity opp : oppToProcess){
            opp.ownerId = assignedRepMap.get(opp.Territory__c);
        }

        update oppToProcess;
        
        /* End updateAssignments method */
    }
    
}