public class Account_TriggerHandler {
    //Create Account Snapshot whenever any change to the field name Touchpoint in Account 
    public static void createAccountSnapshotOnAccountFieldChanges(Id[] newList, Map<Id, String> old){
        List<Account> listofchangedAccounts = new List<Account>([Select Id, Lead_Touch_Point__c,Territory_Lookup__c,Owner.id, Territory_Lookup__r.id FROM Account Where ID in: newList]);       
        List<Account_Snapshot__c> listofOldSnapshots = new List<Account_Snapshot__c>([Select Id, End_Date__c from Account_Snapshot__c where Account__r.id in : newList ]);
        List<Account_Snapshot__c> createAccountSnapshots = new List<Account_Snapshot__c>();      
        for(Account acc: listofChangedAccounts){                 
            for(Account_Snapshot__c oldAccountSnap : listofOldSnapshots){
                if(oldAccountSnap.End_Date__c == null){
                oldAccountSnap.End_Date__c = Date.today();
            }
        }
            Account_Snapshot__c acSnapshot = new Account_Snapshot__c();
            acSnapshot.Start_Date__c = Date.today();
            //acSnapshot.Touchpoint__c = old.get(acc.id);
            acSnapshot.Touchpoint__c = acc.Lead_Touch_Point__c;
            acSnapshot.Account__c = acc.id;  
            acSnapshot.Sales_Rep__c = acc.Owner.id;
            acSnapshot.Territory__c = acc.Territory_Lookup__r.id;
            createAccountSnapshots.add(acSnapshot);
        }
        Update listofOldSnapshots;
        Insert createAccountSnapshots;
    }
    public static void updateContactInfoOnAccount(Id[] AccountIds){
        Map<Id,Account> AccountMap = new Map<Id,Account>([Select Id, Name, Has_Opted_In_Contact__c, Most_Recent_Acreage__c, HasPhone__c, HasEmail__c, Phone, Email__c from Account where id in :AccountIds]);
        Map<Id,List<Contact>> RelatedContactMap = new Map<Id,List<Contact>>();        
        List<Account> updateList = new List<Account>();
        List<Contact> relatedContactList = [Select Id, AccountId, Name, Email_Bounced__c, Email, Opt_in_ECom__c, Do_Not_Email__c, Phone, HomePhone, MobilePhone, OtherPhone from Contact where AccountId in :AccountIds];
        // group the related contacts into a Map with Account ID as the key
        for(Contact c: relatedContactList){
            if (RelatedContactMap.get(c.AccountId) == null){
                RelatedContactMap.put(c.AccountId,new List<Contact>());
            }
            RelatedContactMap.get(c.AccountId).add(c);
        }
        
        boolean hasOptedInContact;
        boolean HasPhone;
        boolean HasEmail;
        for (Account a : AccountMap.values()){
            hasOptedInContact = false;
            HasPhone = false;
            HasEmail = false;
            // check if there is at least one 'Opted-In' Contact with a valid email address
            if (RelatedContactMap.get(a.Id) <> null){
                for (Contact c : RelatedContactMap.get(a.id)){
                    if(c.Opt_in_ECom__c=='Yes (Opted-in)' && c.email <> null && !c.Do_Not_Email__c && !c.Email_Bounced__c ){
                        // valid email with express consent gets set to true
                        hasOptedInContact = true;
                    }
                    if (a.Phone <> null || c.Phone <> null || c.HomePhone <> null || c.MobilePhone <> null || c.OtherPhone <> null){
                        HasPhone = true;
                    }
                    if (c.email <> null && !c.Do_Not_Email__c && !c.Email_Bounced__c && c.Opt_in_ECom__c<>'No (Opted-out)'){
                        HasEmail = true;
                    }
                }
            }
            
            // check to see if any of the account flags were changed and update account record if necessary
            if (a.Has_Opted_In_Contact__c <> hasOptedInContact || a.HasPhone__c <> HasPhone || a.HasEmail__c <> HasEmail){
                a.Has_Opted_In_Contact__c = hasOptedInContact;
                a.HasPhone__c = HasPhone;
                a.HasEmail__c = HasEmail;
                updateList.add(a);
            }
        }
        update (updateList);
    }
    
    public static void updateFoundationCustomerForInsertedAccount(Account[] newList){
        
        List<Id> fcIdList = new List<Id>();
        List<Foundation_Customer__c> fcRecordList = new List<Foundation_Customer__c>();
        Map<Id,Id> fcSalesforceMap = new Map<Id,Id>();
        
        for(Account a : newList){
            if(a.Foundation_Customer__c <> null){
                fcIdList.add(a.Foundation_Customer__c);
                fcSalesforceMap.put(a.Foundation_Customer__c, a.Id);
            }            
        }        
        
        fcRecordList = [select Id, Salesforce_Account__c from Foundation_Customer__c where Id in :fcIdList];
        
        for(Foundation_Customer__c fc : fcRecordList)
        {
            fc.Salesforce_Account__c = fcSalesforceMap.get(fc.Id);
        }
        
        update fcRecordList;
    }
    
    public static void consolidateWinnerAndLoserAccounts(List<Account> accountList) {
        
        List<Id> loserAccountIdList = new List<Id>();
        List<Account> loserAccountList = new List<Account>();
        Map<Id,Id> winningAccountMap = new Map<Id,Id>();        
        for(Account account : accountList) {
            if(account.Inactive__c == true && account.Winner_Account__c != null){
                System.debug('Account Name: ' + account.Name);
                System.debug('Winner Account Name: ' + account.Winner_Account__r.Name);
                loserAccountIdList.add(account.Id);
                loserAccountList.add(account);
                winningAccountMap.put(account.Id, account.Winner_Account__c);
            }    
        }
        
        if(loserAccountIdList.size() > 0){        
            List<Account_Plan__c> accountPlans = [Select Id, Name, Account__c, Old_Account__c From Account_Plan__c Where Account__r.Id IN: loserAccountIdList];
            List<Programs__c> programs = [Select Id, Name, Account__c, Old_Account__c From Programs__c Where Account__r.Id IN: loserAccountIdList];
            List<CA_Seed_Booking__c> seedBookings = [Select Id, Name, Account__c, Old_Account__c From CA_Seed_Booking__c Where Account__r.Id IN: loserAccountIdList];
            List<Stewardship_Agreements__c> stewardship_Agreements = [Select Id, Name, Account__c, Old_Account__c From Stewardship_Agreements__c Where Account__r.Id IN: loserAccountIdList];
            List<Task> activities = [Select Id, WhatId, WhoId, AccountId, Old_Account__c From Task Where AccountId IN: loserAccountIdList];            
            for(Account_Plan__c accountPlan: accountPlans) {
                System.debug('Account Name: ' + accountPlan.Name);
                if(winningAccountMap.get(accountPlan.Account__c) <> null){
                    accountPlan.Old_Account__c = winningAccountMap.get(accountPlan.Account__c);
                    accountPlan.Account__c = winningAccountMap.get(accountPlan.Account__c);
                }
            }
            update accountPlans;
            
            
            for(Programs__c program: programs) {
                
                if(winningAccountMap.get(program.Account__c) <> null){
                    
                    program.Old_Account__c = program.Account__c;
                    program.Account__c = winningAccountMap.get(program.Account__c);
                }
            }            
            update programs;
            
            for(CA_Seed_Booking__c seedBooking: seedBookings) {
                if(winningAccountMap.get(seedBooking.Account__c) <> null){
                    seedBooking.Old_Account__c = seedBooking.Account__c;
                    seedBooking.Account__c = winningAccountMap.get(seedBooking.Account__c);
                }    
            } 
            update seedBookings;
            
            
            for(Stewardship_Agreements__c stewardship_Agreement: stewardship_Agreements) {
                if(winningAccountMap.get(stewardship_Agreement.Account__c) <> null){
                    stewardship_Agreement.Old_Account__c = stewardship_Agreement.Account__c;
                    stewardship_Agreement.Account__c = winningAccountMap.get(stewardship_Agreement.Account__c);
                }                                                    
            }
            update stewardship_Agreements;
            
            for(Task task: activities) {
                if(winningAccountMap.get(task.AccountId) <> null){
                    task.Old_Account__c = task.AccountId;
                    task.WhatId = winningAccountMap.get(task.AccountId);
                }     
                
            }
            update activities;
            
            if(stewardship_Agreements.size() > 0){
                List<Account> accountsToRemoveSSA = [select Id from Account where SF_SSA__c <> '' and Id in :loserAccountIdList];
                for(Account a: accountsToRemoveSSA){
                    a.SF_SSA__c='';
                }                
                update accountsToRemoveSSA;
            }    
            
            
        }     
    }   
    public static void removeCRFromTextFields(Account[] newList){
        for(Account a : newList){
            if(a.BillingStreet <> null){
                if(a.BillingStreet.contains('\r\n') ){
                    a.BillingStreet = a.BillingStreet.replace('\r\n', ' ');
                }
            }
        }       
    }    
        }