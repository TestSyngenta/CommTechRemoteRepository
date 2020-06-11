trigger SeedsAllocationValidationAndSPCreation on SeedsAllocation__c (before insert,before update,after insert,after update) {
    
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate){
            SeedsAllocationValidation sav = new SeedsAllocationValidation();
            sav.getCommercialUnit(trigger.new);
            sav.validateVariety(trigger.new);
            sav.validateDistrictCU(trigger.new);
        }
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            //call the method for salesplan and lineitems creation. 
            System.debug('After Insert:::');
            OpportunitySeedsAllocation osa = new OpportunitySeedsAllocation();
            osa.mapRecordsToBeInserted(trigger.new);
            
        }
        else if(trigger.isUpdate){
            //call the method for updating the salesplan and lineitems. 
            OpportunitySeedsAllocation osa = new OpportunitySeedsAllocation();
            osa.updateOli(trigger.new);
        }
    }

}