public with sharing class sendDatatoContacts {
    public ApexPages.StandardController programsController;

    public sendDatatoContacts(ApexPages.StandardController programsController){
        this.programsController = programsController;
    }
    public PageReference sendData(){ 
    Programs__c[] records = [SELECT Id, Contact__c, Risk_Start_Period__c, Actual_Cashback__c, Payout_Status__c, Actual_Rainfall__c, Program_Reference__c, Rainfall_Threshold__c, Rainfall_Exit_Point__c FROM Programs__c WHERE RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'AgriClime Lentils')];
        //programsController.getId();
        for(Programs__c record : records){
            if(record.contact__c != null){

            }
        }





        return null;

    }
        
   

}
