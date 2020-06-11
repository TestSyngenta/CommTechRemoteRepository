trigger OpportunityTrigger on Opportunity (before update,after update,before insert) {
    system.debug('Trigger.new-->'+trigger.new);
    List<Opportunity> oppRec = trigger.new;
    List<Opportunity> oppoRec = trigger.old;
    //Code to validate the duplicate selection of distributor and retailer  
    if(trigger.isUpdate && trigger.isBefore){
        ValidateDistributorSelectionForSP.validateDistributorSelection(trigger.new,trigger.oldMap);
    }
    
    //Code to validate the duplicate creation of grower and retailer  
    if(trigger.isBefore && trigger.isInsert){
        ValidateDistributorSelectionForSP.validateRelatedDistributor(trigger.new);
    }
     //Code to update the related plan for CU,Distributor,Headoffice,District and Teritorry 
    if(trigger.isUpdate && trigger.isAfter){
        if(!system.isFuture())
        {
            ValidateDistributorSelectionForSP.updateOLI(trigger.old, trigger.new);
        }
       ToUpdateRelatedPlan ASPRelPlan = new ToUpdateRelatedPlan();
       if(oppRec[0].RelatedDistributor__c != null){
       if(!system.isFuture() && !system.isBatch()){
       ASPRelPlan.ASPRelatedPlan(oppRec[0].id);
       }
       }
      /*  if(oppRec[0].Related_Retailer__c != null){
        if(!system.isFuture() && !system.isBatch()){
        ToUpdateRelatedPlan.updateGrowerPlan(oppRec[0].id);
       }   
        } */
    }
    if(trigger.isBefore && trigger.isUpdate){
        ValidateDistributorSelectionForSP updateAt = new ValidateDistributorSelectionForSP();
        updateAt.updateAccountTerritory(trigger.new, trigger.oldMap);
     }
}