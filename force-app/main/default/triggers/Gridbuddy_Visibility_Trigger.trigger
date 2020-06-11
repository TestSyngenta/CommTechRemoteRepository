trigger Gridbuddy_Visibility_Trigger on GridBuddy_Visibility__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
  
    /* The following code disables the trigger execution if there is an entry in the 
    *  Disable Triggers custom setting for the active user or profile. 
    *  for canada R11 development
    */ 
    Disable_Triggers__c dt = Disable_Triggers__c.getInstance(UserInfo.getUserId());
    if(dt!=null && dt.Objects__c!=null && (dt.Objects__c.contains('GridBuddy_Visibility__c') && dt.Triggers__c)){
        System.debug('GridBuddy_Visibility__c Trigger dissabled.');
        return;
    }
  /******************** BEFORE ********************/
  if(trigger.isBefore) {
    if(trigger.isInsert) { GridbuddyVisibilityTriggerHandler.IsBeforeInsert(trigger.new, trigger.newMap); }
    if(trigger.isUpdate) { GridbuddyVisibilityTriggerHandler.IsBeforeUpdate(trigger.old, trigger.oldMap, trigger.new, trigger.newMap); }
    if(trigger.isDelete) { GridbuddyVisibilityTriggerHandler.IsBeforeDelete(trigger.old, trigger.oldMap); }
  }
  
  /******************** AFTER *********************/
  if(trigger.isAfter) {
    if(trigger.isInsert) { GridbuddyVisibilityTriggerHandler.IsAfterInsert(trigger.new, trigger.newMap); }
    if(trigger.isUpdate) { GridbuddyVisibilityTriggerHandler.IsAfterUpdate(trigger.old, trigger.oldMap, trigger.new, trigger.newMap); }
    if(trigger.isDelete) { GridbuddyVisibilityTriggerHandler.IsAfterDelete(trigger.old, trigger.oldMap); }
    if(trigger.isUndelete) { GridbuddyVisibilityTriggerHandler.IsAfterUndelete(trigger.new, trigger.newMap); }
  }
}