global class StageChannelAccountNSAPBatch implements Database.Batchable<sObject>{
    
    String query = 'SELECT NSAP_ECC_ID__c FROM Stage_Channel_Account_NSAP__c';
    
    global StageChannelAccountNSAPBatch() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Stage_Channel_Account_NSAP__c> scope) {
      Set<String> extIdSet = new Set<String>();
      for(Stage_Channel_Account_NSAP__c aRecord : scope){
         extIdSet.add(aRecord.NSAP_ECC_ID__c);
      }
      List<Account> acctList = [SELECT NSAP_ID__c FROM Account WHERE NSAP_ID__c IN :extIdSet];
      
      extIdSet = new Set<String>();
      for(Account anAccount : acctList){
          extIdSet.add(anAccount.NSAP_ID__c);
      }
      
      List<Stage_Channel_Account_NSAP__c> recordsForDeletion = new List<Stage_Channel_Account_NSAP__c>();
      
      for(Stage_Channel_Account_NSAP__c scan : scope){
          if(!extIdSet.contains(scan.NSAP_ECC_ID__c)){
              recordsForDeletion.add(scan);
          }
      }
      
      delete recordsForDeletion;
      
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}