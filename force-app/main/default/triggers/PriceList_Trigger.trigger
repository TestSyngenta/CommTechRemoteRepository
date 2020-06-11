trigger PriceList_Trigger on Price_List__c (after insert, after update) {
    
    PriceListTriggerhandler handler = new PriceListTriggerhandler();
    handler.updateOLIPriceListRel();
}