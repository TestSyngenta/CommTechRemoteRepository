//Developer: Samuel Walker
//Date: 5/24/19 - 5/30/19
//Description: Recreating the Contract Trigger just making it work for Lead.
//Contact Trigger Developers: Brian Hopkins, Trevor Cornfield

trigger Lead_Trigger on Lead (after insert, after update, after delete) {
    if (Trigger.isAfter){
        if(UserInfo.getFirstName()!=null){    
            if(UserInfo.getFirstName()=='Pardot'){
                    Lead_TriggerHandler.updateEmailMarketingFieldsExpressConsent(Trigger.new, Trigger.old);        
            }
        }    
        if(Trigger.isUpdate || Trigger.isInsert){
            if(UserInfo.getFirstName()<>'Pardot'){        
                Lead_TriggerHandler.updateEmailMarketingFieldsImpliedConsent(Trigger.new, Trigger.old);        
            }
        }
    }    
}