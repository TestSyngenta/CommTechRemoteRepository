/** 2016-08-31  Trevor Cornfield
 *  Trigger for Contact related updates.
 * 
 *  After:
 *      Step 1: If Pardot is updating the Contact, update all Email marketing fields on other contacts with the same email address.
 *      Step 2: Update Account Details such as "has phone" and "has email", based on related contacts
 *
 *  Before:
 *      Step 1: Update Contact Type
 *
 */ 
trigger Contact_Trigger on Contact (before insert, before update, after insert, after update, after delete) {
    //if(!System.IsBatch()){
    
    if (Trigger.isAfter){
        if(UserInfo.getFirstName() <> 'Global' ){
        if(UserInfo.getFirstName()=='Pardot'){
                Contact_TriggerHandler.updateEmailMarketingFieldsExpressConsent(Trigger.new, Trigger.old);        
        }
        if(Trigger.isUpdate || Trigger.isInsert){
            if(UserInfo.getFirstName()<>'Pardot'){        
                Contact_TriggerHandler.updateEmailMarketingFieldsImpliedConsent(Trigger.new, Trigger.old);        
            }
        }
        Contact_TriggerHandler.updateAccountContactDetails(Trigger.new, Trigger.old);
        Contact_TriggerHandler.updatePrimaryContact(Trigger.new, Trigger.old);
        
        Contact oldContact = new Contact();
        
        if(Trigger.isUpdate){
        for(Contact con : Trigger.new){
            System.debug('old value is' +con);
            
            if(Trigger.isInsert || Trigger.oldMap.get(con.Id) != null){
            oldContact = Trigger.oldMap.get(con.ID); 
            
            
            //System.debug('old value is' +oldContact);
            if(con.Inactive__c != oldContact.Inactive__c){
                
                //System.debug('Inactive Field is updated');
                Contact_TriggerHandler.updateContactDetailsonInactive(Trigger.new, Trigger.old);
 
            }
 
        
       }
   }
    Contact_TriggerHandler.queueCreateInPardot(Trigger.new);
 }
      
     }
    
   if (Trigger.isBefore){   
       if(UserInfo.getProfileId()<>'00eo0000000K5iJAAS'){ 
           Contact_TriggerHandler.updateContactType(Trigger.new);
       }
     
      

    } 
}
}