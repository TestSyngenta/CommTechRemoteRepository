global class StageNSAPOrderBatch implements Database.Batchable<sObject>{
    
    String query = 'SELECT Id, PO_Number__c FROM Stage_NSAP_Order__c';
    
    global StageNSAPOrderBatch() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Stage_NSAP_Order__c> scope) {
      Set<String> extIdSet = new Set<String>();
      for(Stage_NSAP_Order__c aRecord : scope){
         extIdSet.add(aRecord.PO_Number__c);
      }
      List<Settlement__c> settlementList = [SELECT Legacy_ID__c FROM Settlement__c WHERE Legacy_ID__c IN :extIdSet];
      
      extIdSet = new Set<String>();
      for(Settlement__c aSettlement : settlementList){
          extIdSet.add(aSettlement.Legacy_ID__c);
      }
      
      List< Stage_NSAP_Order__c > recordsForDeletion = new List< Stage_NSAP_Order__c >();
      
      for(Stage_NSAP_Order__c sno : scope){
          if(!extIdSet.contains(sno.PO_Number__c)){
              recordsForDeletion.add(sno);
          }
      }
      
      delete recordsForDeletion;
      
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}