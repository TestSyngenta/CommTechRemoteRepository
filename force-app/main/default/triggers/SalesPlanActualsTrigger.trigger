trigger SalesPlanActualsTrigger on Sales_Plan_Actual__c (after insert, after update) {
    
    //to update the OLi's SPA lookup fields
    if(trigger.isAfter &&(trigger.isUpdate||trigger.isInsert)){
        OpportunityLineItemSPA olispa = new OpportunityLineItemSPA();
        olispa.updateOpportunityLineItemspa(trigger.new);
    }
}