/** 2015-02-23  Brian Hopkins
 *  Trigger for Crop Acreage related updates.
 * 
 *  Before:
 *      Step 1: Biopotential is calculated for crop acreage records
 *  After:
 *      Step 2: "Most Recent" is update on related crop acreage records
 *      Step 3: Total Biopotential is calculated for the parent account
 *              Decile is determined for the parent account
 */ 
trigger CropAcreage_Trigger on Crop_Acreage__c (before insert, before update, after insert, after update, before delete, after delete) {
    
    if (Trigger.isBefore ){
       if(Trigger.isInsert || Trigger.isUpdate) CropAcreage_TriggerHandler.UpdateAcreageBioPotential(Trigger.new);
       if(Trigger.isDelete ) CropAcreage_TriggerHandler.checkDeletionPrevilages(Trigger.old); 
    }


    if (Trigger.isAfter){
        List<Crop_Acreage__c> AcreageUpdateList = CropAcreage_TriggerHandler.UpdateAcreageMostRecent(Trigger.new,Trigger.old);
        update (AcreageUpdateList);
    
        List<Account> AccountUpdateList = CropAcreage_TriggerHandler.UpdateAccountBiopotentialDecile(Trigger.new,Trigger.old);
        update (AccountUpdateList);
        
        List<Id> accountIds = new List<Id>();
        if (Trigger.isDelete || Trigger.isUpdate){
            for (Crop_Acreage__c c : Trigger.old){
                accountIds.add(c.Account__c);
            }
        }
        if (Trigger.isInsert || Trigger.isUpdate){
            for (Crop_Acreage__c c : Trigger.new){
                accountIds.add(c.Account__c);
            }
        }
        
        
    }
}