trigger WebsiteAccount on wint__Website_Account__c (after update, after insert) {
    if (Trigger.isAfter){
    Set<id>websiteIdinTrigger = new Set<id>();
    for(wint__Website_Account__c webAcc : Trigger.New){
        websiteIdinTrigger.add(webAcc.id);
    }
    
    WebsiteAccountHandler.farmWrapperCalling(websiteIdinTrigger);
}
}