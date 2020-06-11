trigger Territory_Trigger on Territory__c (after update) {

    Territory_TriggerHandler.updateAssignments(Trigger.old, Trigger.new);
    
}