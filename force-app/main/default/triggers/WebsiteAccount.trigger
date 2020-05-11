trigger WebsiteAccount on wint__Website_Account__c (after update, after insert) {
    if (Trigger.isAfter){
    Set<id>websiteIdinTrigger = new Set<id>();
    for(wint__Website_Account__c webAcc : Trigger.New){
        /**if(webAcc.wint__Contact__c <> Trigger.oldMap.get(webAcc.id).wint__Contact__c || webAcc.wint__Any__c <> Trigger.oldMap.get(webAcc.id).wint__Any__c){
            websiteIdinTrigger.add(webAcc.id);
        }**/
        //websiteIdinTrigger.add(webAcc.id);
    }
    
    //WebsiteAccountHandler.farmWrapperCalling(websiteIdinTrigger);
}
}