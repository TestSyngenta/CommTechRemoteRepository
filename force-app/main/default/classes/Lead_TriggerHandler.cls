//Developer: Samuel Walker
//Date: 5/24/19 - 5/30/19
//Description: Recreating the Contract Trigger Handler just making it work for Lead.
//Contact Trigger Handler Developers: Brian Hopkins, Trevor Cornfield
//Deal with empty/null fields
public class Lead_TriggerHandler {
    
     public static void updateEmailMarketingFieldsExpressConsent(Lead[] newList, Lead[] oldList){

// take newList, get another list of contacts that contain the email addresses represented by newList contacts
// for each of the contacts on sameEmailList, set Do Not Email, Email Bounced, Opt in Ecom

        Map<Id,Lead> relatedLeadMap = new Map<Id,Lead>();
        Map<Id,Lead> oldLeadMap = new Map<Id,Lead>();
        
        List<Lead> updateList = new List<Lead>(); 
        List<Lead> relatedLeadList = [Select Id, Email, Email_Bounced__c, Pardot_Opt_In_Email_Communications__c, Pardot_Do_Not_Email__c, Opt_in_ECom__c, Do_Not_Email__c, Pardot_DNE_Reset_Required__c from Lead where Id in :newList];
        Set<String> emailSet = new Set<String>();
        boolean UpdateMade;
        
        
        /* For an update or a delete, create a way to access the old Contact records by Email through a Map. This will find a unique record since Pardot only has one record per email.*/
        if (oldList <> null){
            for(Lead oldLead : oldList){
                oldLeadMap.put(oldLead.Id, oldLead);
            }
        


            // group the related contacts into a Map with Email as the key
            for(Lead l: relatedLeadList){
                UpdateMade = false;
                if (relatedLeadMap.get(l.Id) == null && l.Email <> null){
                    relatedLeadMap.put(l.Id,l);
                    /*emailSet.add(c.Email);*/
                    
                }
            }
            
            /* Determine records that just had a bounce status change and update Pardot Hard Bounce Accordingly */                                
            for(Lead l: relatedLeadList){
                  UpdateMade = false;
                  if (RelatedLeadMap.get(l.Id) <> null){
    
                      /* On bounce status change, set appropriate mailability flags */
                      if(oldLeadMap.get(l.Id).Pardot_Do_Not_Email__c == false && l.Pardot_Do_Not_Email__c == true){
                          l.Email_Bounced__c = true;
                          l.Do_Not_Email__c = true;
                          l.Pardot_Mailable__c = 'No';
                          UpdateMade = true;
                          /*Pardot Do Not Email causes bounce reset */
                      } else if((l.Pardot_Do_Not_Email__c == false && oldLeadMap.get(l.Id).Pardot_Do_Not_Email__c== true) && (l.Pardot_Opt_In_Email_Communications__c<> 'No' || l.Opt_in_ECom__c == 'Yes (Implied)')){
                          l.Pardot_Do_Not_Email__c = false;
                          l.Do_Not_Email__c = false;
                          l.Pardot_Mailable__c = 'Yes';
                          l.Pardot_DNE_Reset_Required__c = true;
                          UpdateMade = true;
                      } 
                       
                      
                      /* Express Consent Status Changed */
                      if(RelatedLeadMap.get(l.Id).Pardot_Opt_In_Email_Communications__c== 'Yes (Express)' && oldLeadMap.get(l.Id).Pardot_Opt_In_Email_Communications__c <> 'Yes (Express)'  && (l.Opt_in_ECom__c<> 'Yes (Opted-in)')){
                          l.Opt_in_ECom__c= 'Yes (Opted-in)';
                          l.Pardot_Opt_In_Email_Communications__c = 'Yes (Express)';
                          l.Do_Not_Email__c = false;
                          l.Email_Bounced__c = false;
                          if(l.Pardot_Do_Not_Email__c != false){
                              l.Pardot_Do_Not_Email__c = false;
                              l.Pardot_DNE_Reset_Required__c = true;
                          }
                          l.Pardot_Mailable__c = 'Yes';                      
                          UpdateMade = true;
                      }else if(RelatedLeadMap.get(l.Id).Pardot_Opt_In_Email_Communications__c== 'No' && (l.Opt_in_ECom__c<> 'No (Opted-out)'  || l.Pardot_Do_Not_Email__c <> true)){
                          l.Opt_in_ECom__c= 'No (Opted-out)';
                          l.Pardot_Opt_In_Email_Communications__c = 'No';
                          l.Do_Not_Email__c = true;
                          l.Pardot_Do_Not_Email__c = true;
                          l.Pardot_Mailable__c = 'No';
                          UpdateMade = true;
                      }                                    
                                        
                      if(UpdateMade){
                          updateList.add(l);                  
                      }                                
                  }              
            }
            update(updateList);
        }       
    
    } 
    
    public static void updateEmailMarketingFieldsImpliedConsent(Lead[] newList, Lead[] oldList){

// take newList, get another list of contacts that contain the email addresses represented by newList contacts
// for each of the contacts on sameEmailList, set Do Not Email, Email Bounced, Opt in Ecom

        Map<Id,Lead> relatedLeadMap = new Map<Id,Lead>();
        
        List<Lead> updateList = new List<Lead>(); 
        List<Lead> relatedLeadList = [Select Id, Email, Email_Bounced__c, Pardot_Opt_In_Email_Communications__c, Pardot_Do_Not_Email__c, Opt_in_ECom__c, Do_Not_Email__c, Pardot_Implied_Consent__c, Pardot_Mailable__c, Pardot_DNE_Reset_Required__c from Lead where Id in :newList];
        Set<String> emailSet = new Set<String>();
        boolean UpdateMade;

        // group the related contacts into a Map with Email as the key
        for(Lead l: relatedLeadList){
            UpdateMade = false;
            if (RelatedLeadMap.get(l.Id) == null && l.Email <> null){
                RelatedLeadMap.put(l.Id,l);                
            }
        }
        
        
        for(Lead l: relatedLeadList){
              UpdateMade = false;
              if (l.Email <> null){
                  
                  /* Set Implied Consent Status */
                  if(l.Pardot_Opt_In_Email_Communications__c== 'No Response' && l.Pardot_Implied_Consent__c == 'Yes' && l.Opt_in_ECom__c<> 'Yes (Implied)'){
                      l.Opt_in_ECom__c= 'Yes (Implied)';
                      UpdateMade = true;
                  }else if(l.Pardot_Opt_In_Email_Communications__c== 'No Response' && l.Pardot_Implied_Consent__c == 'No' && l.Opt_in_ECom__c<> 'No (Implied)'){
                      l.Opt_in_ECom__c= 'No (Implied)';
                      UpdateMade = true;
                  }
                  
                  /* Bounce Reset */
                  if(l.Email_Bounced__c == false && (l.Opt_in_ECom__c== 'Yes (Implied)' || l.Opt_in_ECom__c== 'Yes (Opted-in)') && l.Pardot_Do_Not_Email__c <> false){
                      l.Pardot_Do_Not_Email__c = false;
                      l.Do_Not_Email__c = false;
                      l.Pardot_Mailable__c = 'Yes';                      
                      l.Pardot_DNE_Reset_Required__c = true;
                      UpdateMade = true;
                  }
                  /* Bounce reset but still unmailable due to No Implied */
                  if(l.Email_Bounced__c == false && l.Opt_in_ECom__c== 'No (Implied)' && l.Pardot_Do_Not_Email__c <> true){
                      l.Pardot_Do_Not_Email__c = true;
                      l.Do_Not_Email__c = true;
                      l.Pardot_Mailable__c = 'No';
                      UpdateMade = true;
                  }                                  
                  
                  if(l.Pardot_DNE_Reset_Required__c == true && !System.IsBatch() && !System.IsQueueable()){
                      l.Pardot_DNE_Reset_Required__c = false;
                      UpdateMade = true;
                      Contact_TriggerHandler.resetDoNotEmail(l.Id);
                  }
                  
                  if(UpdateMade){
                      updateList.add(l);                  
                  }
                  

                                
              }              
        }
        update(updateList);
        
    
    }
}