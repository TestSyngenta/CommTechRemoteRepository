trigger BusinessPlanTrigger on Business_Plan__c (before insert, before update, after update) {
    //To Check the Duplicates on Business Plan Records
    if(trigger.isBefore){
        if(trigger.isInsert){
        BusinessPlanTriggerHandler bpValidation = new BusinessPlanTriggerHandler();
        bpValidation.validateBusinessPlanDuplicates(trigger.new);
        }
        if(trigger.isUpdate){
           BusinessPlanTriggerHandler bpValidation = new BusinessPlanTriggerHandler();
            bpValidation.validateBusinessPlanDuplicatesOnUpdate(trigger.new, trigger.oldMap);
        }
   }
    //To Update CY Planned Sales for Distibutor CP Plan when BP is locked
    /*if(trigger.isAfter && trigger.isUpdate){
        BusinessPlanTriggerHandler bpValidation = new BusinessPlanTriggerHandler();
        bpValidation.updateCYPlannedSales(trigger.new,trigger.oldMap);
    }*/
}