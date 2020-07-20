public class FoundationCustomer_TriggerHandler{

    /* Function to manage updates to the relationship from Account to Foundation Customer */
    public static void updateAccountToFoundationCustomerRel(Foundation_Customer__c[] newList, Foundation_Customer__c[] oldList){
    
        Set<Id> allAccountIds = new Set<Id>();
        Set<Id> allRetailerAccountIds = new Set<Id>();        
        List<Account> allAccounts = new List<Account>();
        List<Account> allRetailerAccounts = new List<Account>();        
        List<Id> foundationCustomerAccountIds = new List<Id>();
        List<Id> foundationCustomerRetailerAccountIds = new List<Id>();        
        List<Foundation_Customer__c> newFoundationCustomers = new List<Foundation_Customer__c>();
        List<Foundation_Customer__c> updatedFoundationCustomerRelationshipList = new List<Foundation_Customer__c>();
        List<Foundation_Customer__c> updatedRetailerFoundationCustomerRelationshipList = new List<Foundation_Customer__c>();        
        List<Foundation_Customer__c> duplicateSalesforceMatchList = new List<Foundation_Customer__c>();

        List<Account> updateAccountRemovalList = new List<Account>();
        List<Account> updateAccountAdditionList = new List<Account>();        
        List<Account> updateRetailerAccountList = new List<Account>();        
        Set<Account> updateAccountRemovalSet = new Set<Account>();
        Set<Account> updateAccountAdditionSet = new Set<Account>();
        Set<Account> updateRetailerAccountSet = new Set<Account>();        

        List<Id> deadRelAccountIds = new List<Id>();
        List<Id> deadRetailerRelAccountIds = new List<Id>();
        
        Map<Id, Id> deadRelationshipMap = new Map<Id, Id>();
        Map<Id, Id> deadRetailerRelationshipMap = new Map<Id, Id>();
        Map<Id,Foundation_Customer__c> oldFoundationCustomerMap = new Map<Id,Foundation_Customer__c>();
    
         /* For an update, create a way to access the old Foundation Customer records by Id through a Map. */
        if (oldList <> null){
            for(Foundation_Customer__c oldCust : oldList){
                oldFoundationCustomerMap.put(oldCust.Id, oldCust);
            }
        }
                
        /* For an update, create a List of all of the new Foundation Customer records. */
        if(newList <> null){
            newFoundationCustomers = [select Id, Salesforce_Account__c, Salesforce_Retailer_Account__c, SSA__c, Winning_Foundation_Customer__c, Deleted_in_Foundation__c from Foundation_Customer__c where Id in :newList];
        }
        
          
        /* Update transaction */
        if (newList <> null && oldList <> null){
            
            for (Foundation_Customer__c c : newFoundationCustomers){
                /* Get a list of all Customers that just had their Salesforce Account Link changed */
                if(((c.Salesforce_Account__c <> oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c) || (c.SSA__c <> oldFoundationCustomerMap.get(c.Id).SSA__c)) && c.Salesforce_Account__c <> null){
                    updatedFoundationCustomerRelationshipList.add(c);
                    foundationCustomerAccountIds.Add(c.Salesforce_Account__c);
                    /* Collective list of accounts attached to all Contacts where Primary was updated */
                    if(!allAccountIds.contains(c.Salesforce_Account__c)){
                        allAccountIds.Add(c.Salesforce_Account__c);
                    }
                    /* Add the old account references to a list whose members will later have their relationships to Foundation Customers nulled out. */
                    if(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c <> null && (c.SSA__c == oldFoundationCustomerMap.get(c.Id).SSA__c)){
                        deadRelationshipMap.put(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c, c.Id);
                        if(!allAccountIds.contains(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c)){
                            allAccountIds.Add(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c);
                        }
                    }
                }
                else if(c.Salesforce_Account__c == null && oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c <> null){
                    /* If the new reference was blanked out, add the current account to a list whose members will later have their relationships to Foundation Customers nulled out. */
                    deadRelationshipMap.put(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c, c.Id);
                    if(!allAccountIds.contains(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c)){
                        allAccountIds.Add(oldFoundationCustomerMap.get(c.Id).Salesforce_Account__c);
                    }
                }
                
                
                
                if(((c.Salesforce_Retailer_Account__c <> oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c) || (c.SSA__c <> oldFoundationCustomerMap.get(c.Id).SSA__c)) && c.Salesforce_Retailer_Account__c <> null){
                    updatedRetailerFoundationCustomerRelationshipList.add(c);
                    foundationCustomerRetailerAccountIds.Add(c.Salesforce_Retailer_Account__c);
                    /* Collective list of accounts attached to all Contacts where Primary was updated */
                    if(!allRetailerAccountIds.contains(c.Salesforce_Retailer_Account__c)){
                        allRetailerAccountIds.Add(c.Salesforce_Retailer_Account__c);
                    }
                    /* Add the old account references to a list whose members will later have their relationships to Foundation Customers nulled out. */
                    if(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c <> null && (c.SSA__c == oldFoundationCustomerMap.get(c.Id).SSA__c)){
                        deadRetailerRelationshipMap.put(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c, c.Id);
                        if(!allRetailerAccountIds.contains(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c)){
                            allRetailerAccountIds.Add(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c);
                        }
                    }
                }
                else if(c.Salesforce_Retailer_Account__c == null && oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c <> null){
                    /* If the new reference was blanked out, add the current account to a list whose members will later have their relationships to Foundation Customers nulled out. */
                    deadRetailerRelationshipMap.put(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c, c.Id);
                    if(!allRetailerAccountIds.contains(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c)){
                        allRetailerAccountIds.Add(oldFoundationCustomerMap.get(c.Id).Salesforce_Retailer_Account__c);
                    }
                }
            }
    
        }
    
    
    /* Create a map for all accounts related to Foundation Customers that had a changed Salesforce Account field to access the Account to Foundation Customer relationship */
       if(allAccountIDs.size() > 0){
           allAccounts = [Select Id, Foundation_Customer__c, SSA__c from Account where id in :allAccountIds];
           Map<Id,Account> AccountMap = new Map<Id,Account>();
           for(Account a : allAccounts)
           {
               AccountMap.put(a.Id, a);
           }
           Account a;
           /* For all Foundation Customers that just had an Account Relationship enabled, update the associated Foundation Customer 
           field on the account to show the relationship and point to the new Foundation Customer 
           */
           for(Foundation_Customer__c c : updatedFoundationCustomerRelationshipList)
           {
               
               
               a = AccountMap.get(c.Salesforce_Account__c);

               if(updatedFoundationCustomerRelationshipList.size() == 1){
                   
                   /*
                   Look up to see if there are any other records with the same salesforce account as an existing match
                   If there is, set that FC record as the master for the current one and null out the Salesforce Match.
                   */
                   duplicateSalesforceMatchList = [select Id, Salesforce_Account__c, Winning_Foundation_Customer__c, Deleted_in_Foundation__c from Foundation_Customer__c where Salesforce_Account__c = :c.Salesforce_Account__c];
                   System.Debug('List Size is ' + duplicateSalesforceMatchList.size());
                   if(duplicateSalesforceMatchList.size() == 2){
                       for(Foundation_Customer__c d : duplicateSalesforceMatchList){
                           if(c.Id != d.Id  && c.Deleted_in_Foundation__c == false){
                               d.Winning_Foundation_Customer__c = c.Id;
                               d.Salesforce_Account__c = null;
                               a.SSA__c = c.SSA__c;
                               a.Foundation_Customer__c = c.Id;
                               update d;
                           }
                           else if(c.Id != d.Id  && d.Deleted_in_Foundation__c == false){
                               c.Winning_Foundation_Customer__c = d.Id;
                               c.Salesforce_Account__c = null;
                               a.SSA__c = d.SSA__c;
                               a.Foundation_Customer__c = d.Id;
                               update c;
                           }
                           if(!updateAccountAdditionSet.contains(a)){
                           updateAccountAdditionSet.add(a);
                       } 
                       }
                       
                   }
                   else {
                       a.Foundation_Customer__c = c.Id;
                       a.SSA__c = c.SSA__c;
                       if(!updateAccountAdditionSet.contains(a)){
                           updateAccountAdditionSet.add(a);
                       } 
                   }
                   
                   
                   
               }
               else 
               {
                   a.Foundation_Customer__c = c.Id;
                   a.SSA__c = c.SSA__c;
                   if(!updateAccountAdditionSet.contains(a)){
                       updateAccountAdditionSet.add(a);
                   } 
               }

                  
           }
           /* For all Foundation Customer to Account links on the demoted list (manually nulled relationships), null out the Foundation Customer relationship. */
           
           deadRelAccountIds.addAll(deadRelationshipMap.keySet());
           
           for(Id acct: deadRelAccountIds)
           {
               a = AccountMap.get(acct);
               if(a.Foundation_Customer__c == deadRelationshipMap.get(acct)){
                   a.Foundation_Customer__c = null;
                   a.SSA__c = null;
                   if(!updateAccountRemovalSet.contains(a)){
                       updateAccountRemovalSet.add(a);
                   }    
               }
           }
       }    
       
       
           /* Create a map for all Retailer accounts related to Foundation Customers that had a changed Salesforce Account field to access the Account to Foundation Customer relationship */
           if(allRetailerAccountIDs.size() > 0){
           allRetailerAccounts = [Select Id, Foundation_Customer__c, SSA__c from Account where id in :allRetailerAccountIds];
           Map<Id,Account> AccountRetailerMap = new Map<Id,Account>();
           for(Account ra : allRetailerAccounts)
           {
               AccountRetailerMap.put(ra.Id, ra);
           }
           Account ra;
           /* For all Foundation Customers that just had an Account Relationship enabled, update the associated Foundation Customer 
           field on the account to show the relationship and point to the new Foundation Customer 
           */
           for(Foundation_Customer__c c : updatedRetailerFoundationCustomerRelationshipList)
           {
               ra = AccountRetailerMap.get(c.Salesforce_Retailer_Account__c);
               ra.Foundation_Customer__c = c.Id;
               ra.SSA__c = c.SSA__c;
               if(!updateRetailerAccountSet.contains(ra)){
                   updateRetailerAccountSet.add(ra);
               }    
           }
           /* For all Foundation Customer to Account links on the demoted list (manually nulled relationships), null out the Foundation Customer relationship. */
           
           deadRetailerRelAccountIds.addAll(deadRetailerRelationshipMap.keySet());
           
           for(Id racct: deadRetailerRelAccountIds)
           {
               ra = AccountRetailerMap.get(racct);
               if(ra.Foundation_Customer__c == deadRetailerRelationshipMap.get(racct)){
                   ra.Foundation_Customer__c = null;
                   ra.SSA__c = null;
                   if(!updateRetailerAccountSet.contains(ra)){
                       updateRetailerAccountSet.add(ra);
                   }    
               }
           }
       }    
                   

                   
        /* Run all cumulative updates to accounts made in this function */
        updateAccountRemovalList.addAll(updateAccountRemovalSet);
        if(updateAccountRemovalList.size() > 0){
            update (updateAccountRemovalList);   
        }    
        updateRetailerAccountList.addAll(updateRetailerAccountSet);
        if(updateRetailerAccountList.size() > 0){
            update (updateRetailerAccountList);   
        }    
        updateAccountAdditionList.addAll(updateAccountAdditionSet);
        if(updateAccountAdditionList.size() > 0){
            update (updateAccountAdditionList);   
        }    
    }
}