trigger ChequeRun_Trigger on Cheque_Run__c (before update, before delete) {

    if (Trigger.isDelete){
        Trigger.old[0].adderror('You may not delete Cheque Runs at this time.');
    }
    
    if (Trigger.isUpdate){
	    ChequeRun_TriggerHandler.updateRelatedStatus(Trigger.new, Trigger.old);
    }
    
}