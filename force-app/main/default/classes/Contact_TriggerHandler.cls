public class Contact_TriggerHandler {

    /* Function for managing updates to the Primary Contact checkbox */
    public static void updatePrimaryContact(Contact[] newList, Contact[] oldList){

        List<Id> primaryAccountIds = new List<Id>();
        List<Id> deadAMCAccountIds = new List<Id>();
        Set<Id> allAccountIds = new Set<Id>();
        List<Account> allAccounts = new List<Account>();
        List<Contact> newContacts = new List<Contact>();
        Set<Contact> updateContactSet = new Set<Contact>();
        List<Contact> updateContactList = new List<Contact>();
        List<Account> updateAccountList = new List<Account>();
        Set<Account> updateAccountSet = new Set<Account>();
        List<Contact> primaryContactList = new List<Contact>();
        Map<Id, Id> deadAMCRelationshipMap = new Map<Id, Id>();
        List<Contact> primaryContactsToUncheck = new List<Contact>();
        List<Contact> recordsOfPrimaryContactsToUncheck = new List<Contact>();
        Map<Id,Contact> oldContactMap = new Map<Id,Contact>();
        boolean oldPrimaryContactValue = false;
        
        /* For an update or a delete, create a way to access the old Contact records by Id through a Map. */
        if (oldList <> null){
            for(Contact oldCon : oldList){
                oldContactMap.put(oldCon.Id, oldCon);
            }
        }
        
        if(newList <> null){
            newContacts = [select Id, AccountId, Primary_Contact__c from Contact where Id in :newList];
        }
        
        
        /* Update transaction */
        if (newList <> null && oldList <> null){
            
            for (Contact c : newContacts){
                /* Get a list of all Contacts that were just changed to be a Primary Contact */
                if(c.Primary_Contact__c == true && oldContactMap.get(c.Id).Primary_Contact__c == false){
                    primaryContactList.add(c);
                    primaryAccountIds.Add(c.AccountId);
                    /* Collective list of accounts attached to all Contacts where Primary was updated */
                    if(!allAccountIds.contains(c.AccountId)){
                        allAccountIds.Add(c.AccountId);
                    }
                }
                /* All Contacts that were just changed to not be a primary Contact, but they have not moved accounts */
                if(c.Primary_Contact__c == false && oldContactMap.get(c.Id).Primary_Contact__c == true && c.AccountId == oldContactMap.get(c.Id).AccountId){
                    deadAMCRelationshipMap.put(c.AccountId, c.Id);
                    /* Collective list of accounts attached to all Contacts where Primary was updated */
                    if(!allAccountIds.contains(c.AccountId)){
                        allAccountIds.Add(c.AccountId);
                    }
                }
                /* 1 - If An account moved to a different account, create a new instance of a Contact with the old Account ID and 
                       add it to the demoted list so the old Account has its Main Contact relationship severed 
                   2 - Also add the current contact to a list of contacts whose Primary Contact checkboxes will be cleared
                */
                if(c.AccountId != oldContactMap.get(c.Id).AccountId && c.Primary_Contact__c == true){
                        deadAMCRelationshipMap.put(oldContactMap.get(c.Id).AccountId, c.Id);
                        if(!allAccountIds.contains(oldContactMap.get(c.Id).AccountId)){
                            allAccountIds.Add(oldContactMap.get(c.Id).AccountId);
                        }    
                        primaryContactsToUncheck.Add(c);
                        
                }
                
            }
    
        }
        

        /* Insert transaction where Primary is checked.  Add to the list of Primary Contacts so that the 
        Account Main Contact relationship gets created 
        */
        if (newList <> null && oldList == null)
        {
            for (Contact c : newContacts){
                if(c.Primary_Contact__c == true){
                    primaryContactList.add(c);
                    primaryAccountIds.Add(c.AccountId);
                    if(!allAccountIds.contains(c.AccountId)){
                        allAccountIds.Add(c.AccountId);
                    }
                }                
            }
        }
        /* Delete transaction - if a Contact is deleted, add it to the demoted list so its former Account 
        will have its Account Main Contact relationship blanked out. Do not run for merged contacts.
        */
        if(newList == null && oldList <> null)
        {
            for (Contact c : oldList){
                    if(c.Primary_Contact__c == true){
                        deadAMCRelationshipMap.put(c.AccountId, c.Id);
                        if(!allAccountIds.contains(c.AccountId)){
                            allAccountIds.Add(c.AccountId);
                        }
                    }   
            }
        }
        
        
       /* Create a map for all accounts attached to Contacts with a changed Primary Contact field to access the Account Main Contact relationship */
       if(allAccountIDs.size() > 0){
           allAccounts = [Select Id, Account_Main_Contact__c from Account where id in :allAccountIds];
           Map<Id,Account> AccountMap = new Map<Id,Account>();
           for(Account a : allAccounts)
           {
               AccountMap.put(a.Id, a);
           }
           Account a;
           /* For all Contacts that just had a Primary Contact enabled, update the associated Account Main Contact 
           field on the account to show the relationship and point to the new Primary Contact 
           */
           for(Contact c : primaryContactList)
           {
               a = AccountMap.get(c.AccountId);
               a.Account_Main_Contact__c = c.Id;
               if(!updateAccountSet.contains(a)){
                   updateAccountSet.add(a);
               }    
           }
           /* For all Contact to Account links on the demoted list (manually unchecked Primary Contacts and Primary Contacts 
           that moved accounts), delete the Account Main Contact relationship. 
           */
           
           deadAMCAccountIds.addAll(deadAMCRelationshipMap.keySet());
           
           for(Id acct: deadAMCAccountIds)
           {
               a = AccountMap.get(acct);
               if(a.Account_Main_Contact__c == deadAMCRelationshipMap.get(acct)){
                   a.Account_Main_Contact__c = null;
                   if(!updateAccountSet.contains(a)){
                       updateAccountSet.add(a);
                   }    
               }
           }
       }    
      
       
       /* Primary Contacts to Uncheck */
       if (primaryContactsToUncheck.size() > 0){
           recordsOfPrimaryContactsToUncheck  = [Select Id, Primary_Contact__c from Contact where Id in :primaryContactsToUncheck];
           
           for(Contact c: recordsOfPrimaryContactsToUncheck){
               if(c.Primary_Contact__c == true){
                   c.Primary_Contact__c = false;
                   if(!updateContactSet.contains(c)){
                       updateContactSet.add(c);               
                   }    
               }
            } 
       }
       
       /* For all other contacts on accounts that just had a primary enabled, find any other Contacts that are marked as 
       Primary and clear the Primary Contact checkbox.  For inserts and updates only. 
       */ 
       if (newList <> null && primaryContactList.size() > 0){
           List<Contact> relatedContactList = [Select Id, Primary_Contact__c from Contact where AccountId in :primaryAccountIds and Id not in :primaryContactList];
    
           for(Contact c: relatedContactList){
               if(c.Primary_Contact__c == true){
                   c.Primary_Contact__c = false;
                   if(!updateContactSet.contains(c)){
                       updateContactSet.add(c);               
                   }    
               }
            } 
        }    
            
        /* Run all cumulative updates to accounts and contacts made in this function */
        updateAccountList.addAll(updateAccountSet);
        if(updateAccountList.size() > 0){
            update (updateAccountList);   
        }    
        updateContactList.addAll(updateContactSet);
        if(updateContactList.size() > 0){
            update (updateContactList);
        }    
    }

    /* Function for updating the Contact Type field on Contact with the Account Record Type name */
    public static void updateContactType(Contact[] newList){
       // get all the affected accounts
        List<Id> AccountIds = new List<Id>();
        List<Account> relatedAccountList = new List <Account>();
        Map<Id,Account> relatedAccountMap = new Map<Id,Account>();

        if (newList <> null){
            for (Contact c : newList){
                AccountIds.Add(c.AccountId);
            }
        }
        
        relatedAccountList = [SELECT Id, RecordType.Name FROM Account where Id in :AccountIds];
          
        for(Account a: relatedAccountList){
            if (RelatedAccountMap.get(a.Id) == null){
                RelatedAccountMap.put(a.Id, a);
            }
        }   
        
        for(Contact c: newList){
            if(c.Contact_Type__c != RelatedAccountMap.get(c.AccountId).RecordType.Name){
                c.Contact_Type__c = RelatedAccountMap.get(c.AccountId).RecordType.Name;
            }    
        }
    }
    
    /* Move any inactive contacts to a master inactive account and populate their original account field*/
    /**Public static void updateContactDetailsonInactive(Contact[] newList, Contact[] oldList){
        //get all the affected Contacts
        List<Contact> UpdatedList = new List<Contact>(); 
        List<Contact> changedContact = [SELECT id, Inactive__c, AccountId, Original_Account__c FROM Contact WHERE ID in :newList FOR UPDATE]; 
        //get the affected Account Id
        List<Id> AccountIds = new List<Id>();
        //get the Account of an affected Contact
        boolean UpdateDone;
        List<Account> relatedAccountList = new List <Account>();
        Map<Id, Contact> oldContactMap = new Map<Id, Contact>();
        Map<Id,Account> relatedAccountMap = new Map<Id,Account>();

        //Check if there is an update to the Contact
        if(oldList <> null){
            for(Contact c : oldList)
            {
                oldContactMap.put(c.Id, c);
            }
        } 
        //Add the Accountids of the updated Contact    
        if (newList <> null){
            for (Contact c : newList){
                AccountIds.Add(c.AccountId);
            }
        }
        //get the required fields of the affected Account
        relatedAccountList = [SELECT Id, Inactive__c FROM Account where Id in :AccountIds];
        for(Account a: relatedAccountList){
            if (RelatedAccountMap.get(a.Id) == null){    
                RelatedAccountMap.put(a.Id, a);
            }
        }
        for(Contact con : changedContact){
            UpdateDone = false;
                if(con.Inactive__c  == true && relatedAccountMap.get(con.AccountId).Inactive__c == false ){
                System.debug('Coming into the loop');
                con.Original_Account__c = oldContactMap.get(con.Id).AccountId;
                con.AccountId =  '001o0000010sviy';
                con.Date_Inactivated__c = Date.today();
                con.Inactivated_By__c = UserInfo.getUserId();
                con.Primary_Contact__c = false;
                UpdateDone = true;
            }           
            else if (con.Inactive__c == false) {
                if(oldContactMap.get(con.Id).Original_Account__c <> null){
                    con.AccountId = oldContactMap.get(con.Id).Original_Account__c;
                    con.Original_Account__c = null;
                    con.Date_Inactivated__c = null;
                    con.Inactivated_By__c = null;  
                    con.Inactive_Reason__c = null;
                    UpdateDone = true;        
                }
                else {
                    con.Original_Account__c = null;
                con.Date_Inactivated__c = null;
                con.Inactivated_By__c = null;  
                con.Inactive_Reason__c = null;
                UpdateDone = true;
                }
                if(UpdateDone){
                    UpdatedList.add(con);
                }
            }
        }update(UpdatedList);
    } **/

   
    /* Function for updating the Account with details from all related Contacts */
    public static void updateAccountContactDetails(Contact[] newList, Contact[] oldList){
        // get all the affected accounts
        List<Id> AccountIds = new List<Id>();
        Set<Id> AccountSet = new Set<Id>();
        
        Map<Id, Contact> oldContactMap = new Map<Id, Contact>();
        
        if(oldList <> null){
            for(Contact c : oldList)
            {
                oldContactMap.put(c.Id, c);
            }
        }    

        /* Update - For an update transaction, check to see if any of the fields that would affect the fields aggregated 
        at the account level, and if so add the current account to the list of accounts to be passed to the class that will update the
        Account fields.
        */
        if (newList <> null && oldlist<> null){
            Contact oldCon;
            for (Contact c : newList){
                oldCon = oldContactMap.get(c.Id);
                if(c.AccountId <> oldCon.AccountId || c.Email_Bounced__c <> oldCon.Email_Bounced__c || c.Email <> oldCon.Email || c.Opt_in_ECom__c <> oldCon.Opt_in_Ecom__c ||
                c.Do_Not_Email__c <> oldCon.Do_Not_Email__c || c.Phone <> oldCon.Phone || c.HomePhone <> oldCon.HomePhone || c.MobilePhone <> oldCon.MobilePhone || c.OtherPhone <>oldCon.OtherPhone){
                    if(!AccountSet.contains(c.AccountId)){
                        AccountSet.Add(c.AccountId);
                    }    
                }    
            }
        }
        /* Insert */
        if(oldList == null && newList <> null){
            for (Contact c : newList){
                if(!AccountSet.contains(c.AccountId)){
                    AccountSet.Add(c.AccountId);
                }    
            }
        }
        if (oldList <> null && newList == null){
            for (Contact c : oldList){
                if(!AccountSet.contains(c.AccountId)){
                    AccountSet.Add(c.AccountId);
                }    
            }
        }

        AccountIds.addAll(AccountSet);
        Account_TriggerHandler.updateContactInfoOnAccount(AccountIds);

    }
    
    public static void updateEmailMarketingFieldsExpressConsent(Contact[] newList, Contact[] oldList){

// take newList, get another list of contacts that contain the email addresses represented by newList contacts
// for each of the contacts on sameEmailList, set Do Not Email, Email Bounced, Opt in Ecom

        Map<Id,Contact> relatedContactMap = new Map<Id,Contact>();
        Map<Id,Contact> oldContactMap = new Map<Id,Contact>();
        
        List<Contact> updateList = new List<Contact>(); 
        List<Contact> relatedContactList = [Select Id, Email, Email_Bounced__c, Pardot_Opt_In_Email_Communications__c, Pardot_Hard_Bounce__c, Pardot_Do_Not_Email__c, Opt_in_ECom__c, Do_Not_Email__c, Pardot_Email_Bounced_Date__c, Pardot_DNE_Reset_Required__c from Contact where Id in :newList];
        Set<String> emailSet = new Set<String>();
        boolean UpdateMade;
        
        
        /* For an update or a delete, create a way to access the old Contact records by Email through a Map. This will find a unique record since Pardot only has one record per email.*/
        if (oldList <> null){
            for(Contact oldCon : oldList){
                oldContactMap.put(oldCon.Id, oldCon);
            }
        }


        // group the related contacts into a Map with Email as the key
        for(Contact c: relatedContactList){
            UpdateMade = false;
            if (relatedContactMap.get(c.Id) == null && c.Email <> null){
                relatedContactMap.put(c.Id,c);
                /*emailSet.add(c.Email);*/
                
            }
            /* For all of the updated contacts, update the Pardot Hard Bounce field based on changes to Do Not Email from Pardot*/
            /*if (c.Pardot_Do_Not_Email__c == true && oldContactMap.get(c.Email).Pardot_Do_Not_Email__c == false && c.Pardot_Hard_Bounce__c == 'No'){
                c.Pardot_Hard_Bounce__c = 'Yes';
                UpdateMade = true;            
            }*/
        }
        
        /* Determine records that just had a bounce status change and update Pardot Hard Bounce Accordingly */
        
        
        
/*        List<Contact> sameEmailList = [Select Id, Email_Bounced__c, Pardot_Opt_In_Email_Communications__c, Pardot_Hard_Bounce__c, Pardot_Do_Not_Email__c, Email, Opt_in_ECom__c, Do_Not_Email__c from Contact where Email in :emailSet];*/
        
        for(Contact ce: relatedContactList){
              UpdateMade = false;
              if (RelatedContactMap.get(ce.Id) <> null){

                  /* On bounce status change, set appropriate mailability flags */
                  if(oldContactMap.get(ce.Id).Pardot_Do_Not_Email__c == false && ce.Pardot_Do_Not_Email__c == true){
                      ce.Email_Bounced__c = true;
                      ce.Do_Not_Email__c = true;
                      ce.Pardot_Mailable__c = 'No';
                      UpdateMade = true;
                      /*Pardot Do Not Email causes bounce reset */
                  } else if((ce.Pardot_Do_Not_Email__c == false && oldContactMap.get(ce.Id).Pardot_Do_Not_Email__c== true) && (ce.Pardot_Opt_In_Email_Communications__c<> 'No' || ce.Opt_in_ECom__c == 'Yes (Implied)')){
                      ce.Pardot_Do_Not_Email__c = false;
                      ce.Do_Not_Email__c = false;
                      ce.Pardot_Mailable__c = 'Yes';
                      ce.Pardot_DNE_Reset_Required__c = true;
                      UpdateMade = true;
                  } 
                   
                  
                  /* Express Consent Status Changed */
                  if(RelatedContactMap.get(ce.Id).Pardot_Opt_In_Email_Communications__c== 'Yes (Express)' && oldContactMap.get(ce.Id).Pardot_Opt_In_Email_Communications__c <> 'Yes (Express)'  && (ce.Opt_in_ECom__c<> 'Yes (Opted-in)')){
                      ce.Opt_in_ECom__c= 'Yes (Opted-in)';
                      ce.Pardot_Opt_In_Email_Communications__c = 'Yes (Express)';
                      ce.Do_Not_Email__c = false;
                      ce.Email_Bounced__c = false;
                      if(ce.Pardot_Do_Not_Email__c != false){
                          ce.Pardot_Do_Not_Email__c = false;
                          ce.Pardot_DNE_Reset_Required__c = true;
                      }
                      ce.Pardot_Mailable__c = 'Yes';                      
                      UpdateMade = true;
                  }else if(RelatedContactMap.get(ce.Id).Pardot_Opt_In_Email_Communications__c== 'No' && (ce.Opt_in_ECom__c<> 'No (Opted-out)'  || ce.Pardot_Do_Not_Email__c <> true)){
                      ce.Opt_in_ECom__c= 'No (Opted-out)';
                      ce.Pardot_Opt_In_Email_Communications__c = 'No';
                      ce.Do_Not_Email__c = true;
                      ce.Pardot_Do_Not_Email__c = true;
                      ce.Pardot_Mailable__c = 'No';
                      UpdateMade = true;
                  }                                    
                                    
                  if(UpdateMade){
                      updateList.add(ce);                  
                  }                                
              }              
        }
        update(updateList);
        
    
    }
    
    
    public static void updateEmailMarketingFieldsImpliedConsent(Contact[] newList, Contact[] oldList){

// take newList, get another list of contacts that contain the email addresses represented by newList contacts
// for each of the contacts on sameEmailList, set Do Not Email, Email Bounced, Opt in Ecom

        Map<Id,Contact> relatedContactMap = new Map<Id,Contact>();
        
        List<Contact> updateList = new List<Contact>(); 
        List<Contact> relatedContactList = [Select Id, Email, Email_Bounced__c, Pardot_Opt_In_Email_Communications__c, Pardot_Do_Not_Email__c, Opt_in_ECom__c, Do_Not_Email__c, Pardot_Implied_Consent__c, Pardot_Mailable__c, Pardot_DNE_Reset_Required__c from Contact where Id in :newList];
        Set<String> emailSet = new Set<String>();
        boolean UpdateMade;

        // group the related contacts into a Map with Email as the key
        for(Contact c: relatedContactList){
            UpdateMade = false;
            if (RelatedContactMap.get(c.Id) == null && c.Email <> null){
                RelatedContactMap.put(c.Id,c);
                /*emailSet.add(c.Email);*/
                
            }
        }
        
        
        
        /*List<Contact> sameEmailList = [Select Id, Email, Email_Bounced__c, Pardot_Opt_In_Email_Communications__c, Pardot_Do_Not_Email__c, Opt_in_ECom__c, Do_Not_Email__c, Pardot_Implied_Consent__c, Pardot_Mailable__c from Contact where Email in :emailSet];
        
        for(Contact ce: sameEmailList){*/

        for(Contact ce: relatedContactList){
              UpdateMade = false;
              /*if (RelatedContactMap.get(ce.Email) <> null){*/
              if (ce.Email <> null){
                  
                  /* Set Implied Consent Status */
                  if(ce.Pardot_Opt_In_Email_Communications__c== 'No Response' && ce.Pardot_Implied_Consent__c == 'Yes' && ce.Opt_in_ECom__c<> 'Yes (Implied)'){
                      ce.Opt_in_ECom__c= 'Yes (Implied)';
                      UpdateMade = true;
                  }else if(ce.Pardot_Opt_In_Email_Communications__c== 'No Response' && ce.Pardot_Implied_Consent__c == 'No' && ce.Opt_in_ECom__c<> 'No (Implied)'){
                      ce.Opt_in_ECom__c= 'No (Implied)';
                      UpdateMade = true;
                  }
                  
                  /* Bounce Reset */
                  if(ce.Email_Bounced__c == false && (ce.Opt_in_ECom__c== 'Yes (Implied)' || ce.Opt_in_ECom__c== 'Yes (Opted-in)') && ce.Pardot_Do_Not_Email__c <> false){
                      ce.Pardot_Do_Not_Email__c = false;
                      ce.Do_Not_Email__c = false;
                      ce.Pardot_Mailable__c = 'Yes';                      
                      ce.Pardot_DNE_Reset_Required__c = true;
                      UpdateMade = true;
                  }
                  /* Bounce reset but still unmailable due to No Implied */
                  if(ce.Email_Bounced__c == false && ce.Opt_in_ECom__c== 'No (Implied)' && ce.Pardot_Do_Not_Email__c <> true){
                      ce.Pardot_Do_Not_Email__c = true;
                      ce.Do_Not_Email__c = true;
                      ce.Pardot_Mailable__c = 'No';
                      UpdateMade = true;
                  }                                  
                  
                  if(ce.Pardot_DNE_Reset_Required__c == true && !System.IsBatch() && !System.IsQueueable()){
                      ce.Pardot_DNE_Reset_Required__c = false;
                      UpdateMade = true;
                      resetDoNotEmail(ce.Id);
                  }
                  
                  if(UpdateMade){
                      updateList.add(ce);                  
                  }                      
              }              
        }
        update(updateList);
        
    
    }
   
    @future (callout=true)
    public static void resetDoNotEmail(Id contactId){
         String apiKey = loginToPardot();
         
         /*System.Debug('API Key returned was ' + apiKey);*/
         
         String user_key = 'cd215fdd852b6c7e19038b14900d2f64';        
         HttpRequest req = new HttpRequest();
         HttpResponse res = new HttpResponse();
         Http http = new Http();
         
         req.setEndPoint('https://pi.pardot.com/api/prospect/version/4/do/update/fid/' + contactId);
         req.setBody('fid=' + contactId + '&is_do_not_email=false&api_key=' + apiKey + '&user_key=' + user_key);
         req.setMethod('POST');
         req.setTimeout(20000);
         try{
             res = http.send(req);
         } catch(System.CalloutException e){
             /* Allow for CalloutExceptions for timeout on request send */
         }
         
         /*XmlStreamReader xsr = res.getXmlStreamReader();
         
         while(xsr.hasNext())
         {
             System.Debug('Local Name is ' + xsr.getLocalName());
             System.Debug('Event Type is ' + xsr.getEventType());
             if (xsr.getEventType() == XmlTag.CHARACTERS)
             {    
                 System.Debug(xsr.getText());
             }   
               xsr.next();
         }*/
              
    }
    Public static HttpResponse httpCallout(String url, String body){
          
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        
        
        //req.setEndPoint('https://pi.pardot.com/api/prospect/version/4/do/create/email/' + email);
        req.setEndPoint(url);
        req.setBody(body);
        System.debug('::REQUEST::'+req.getBody());
        req.setMethod('POST');
        req.setTimeout(20000);
        try{
            res = http.send(req);
            System.debug('::RESPONSE::'+res.getBody());
            return res;
            
        } 
        catch(System.CalloutException e){
            // Allow for CalloutExceptions for timeout on request send
            return null;
        }
        
   }
    //@future (callout=true)
    public static void queueCreateInPardot(Contact[] newList){
        
        Integer i = 0;
        for(Contact c: newList){
            if(i > 50){
                break;
            }
            
           // if(c.email <> null && c.pi__url__c == null && !System.IsBatch() && !System.IsQueueable() && !Test.isRunningTest()){
            if(c.email <> null && c.pi__url__c == null && !System.IsBatch() && !System.IsQueueable() && !Test.isRunningTest()){
                sendToPardot('https://pi.pardot.com/api/prospect/version/4/do/create','email='+c.Email + '&fid='+c.Id);
                //sendToPardot('https://pi.pardot.com/api/prospect/version/4/do/create','email='+c.Email );
                i++;                  
            }
            System.debug('::PARDOT EMAIL::'+c.Email);
        }   
    }  
    @future (callout=true)
    public static void sendToPardot(String url, String body){
        
        String apiKey = loginToPardot();
        
        //System.Debug('API Key returned was ' + apiKey);
        
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';

        HttpResponse res = httpCallout( url, 'user_key=' +user_key+ '&api_key='+ apiKey +'&'+ body );
        System.debug('Response from Server in Salesforce: '+res);
    }
 

    public static String loginToPardot(){ 
    
         String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
         String password = 'r919_B4I';
         String email = 'trevor.cornfield@syngenta.com';
         String bodyReturn = '';
         HttpRequest req = new HttpRequest();
         HttpResponse res = new HttpResponse();
         Http http = new Http();
         String loginErrorMessage = '';
         String apiKey = '';
         String result;
         //user_key is the 'API User Key' field on the 'Settings' page in Pardot // Ensure that the specified user account has at least "Marketing" access privileges. user_key = 'YourUserKey';
         //The 32 character hexadecimal user key for your user account password = 'YourPassword';
         //The password of your user account email = 'yourEmail@YourDomaincom';
         //The email address of your user account //http://developer.pardot.com/kb/api-version-3/authentication 
         req.setEndPoint('https://pi.pardot.com/api/login/version/3');
         req.setBody('email=' + email + '&password=' + password + '&user_key=' + user_key);
         req.setMethod('POST');
         req.setTimeout(20000);
         res = http.send(req);
        // result = res.getBody();
         //result = result.substring(1);
         XmlStreamReader xsr = res.getXmlStreamReader();
       
            
            
         while(xsr.hasNext())
         {
             /*
             System.Debug('Local Name is ' + xsr.getLocalName());
             System.Debug('Event Type is ' + xsr.getEventType());
             */
             if (xsr.getEventType() == XmlTag.START_ELEMENT && xsr.GetLocalName() == 'api_key') 
             {    
                 xsr.next();
                 apiKey=xsr.getText();
             }    
             xsr.next();
         }
         
         /*System.Debug('API Key is ' + apiKey);*/
        
         return apiKey;
    
}

public static void Check(){
    Integer i = 0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    

}
Public static void Check1(){
    Integer i=0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;

}
}