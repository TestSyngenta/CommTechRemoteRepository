global class StageChannelAccountSFDCBatch implements Database.Batchable<sObject>{
    
    String query = 'SELECT SFDC_Account_ID__c FROM Stage_Channel_Account_SFDC__c';
    
    global StageChannelAccountSFDCBatch() {
        
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Stage_Channel_Account_SFDC__c> scope) {
      Set<String> extIdSet = new Set<String>();
      for(Stage_Channel_Account_SFDC__c aRecord : scope){
         extIdSet.add(aRecord.SFDC_Account_ID__c);
      }
      List<Account> acctList = [SELECT Legacy_ID__c FROM Account WHERE Legacy_Id__c IN :extIdSet];
      
      extIdSet = new Set<String>();
      for(Account anAccount : acctList){
          extIdSet.add(anAccount.Legacy_ID__c);
      }
      
      List<Stage_Channel_Account_SFDC__c> recordsForDeletion = new List<Stage_Channel_Account_SFDC__c>();
      
      for(Stage_Channel_Account_SFDC__c scas : scope){
          if(!extIdSet.contains(scas.SFDC_Account_ID__c)){
              recordsForDeletion.add(scas);
          }
      }
      
      delete recordsForDeletion;
      
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}