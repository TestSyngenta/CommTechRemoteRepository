public with sharing class AccountDetails_PurchHist_Controller {
    private ApexPages.StandardController stdController;
    private final Account acct;
    
    public AccountDetails_PurchHist_Controller(ApexPages.StandardController controller) {
        this.stdController = controller;
        acct = (Account)controller.getRecord();

        PurchaseHistoryList = [Select Product_Line__c, 
                                    Brand_Name__c, 
                                    PY0_Individual_SDP__c, 
                                    PY1_Individual_SDP__c, 
                                    PY2_Individual_SDP__c, 
                                    PY3_Individual_SDP__c
                               from Summary_OTGS_Child_Account_Brand__c 
                               where Account__c = :acct.id 
                               order by PY0_Individual_SDP__c DESC NULLS LAST, 
                                        PY1_Individual_SDP__c DESC NULLS LAST, 
                                        PY2_Individual_SDP__c DESC NULLS LAST, 
                                        PY3_Individual_SDP__c DESC NULLS LAST];
        for (Summary_OTGS_Child_Account_Brand__c s : PurchaseHistoryList){
            if (s.Brand_Name__c==null){
                s.Brand_Name__c = '<unknown>';
            }
        }
    }

    public List<Summary_OTGS_Child_Account_Brand__c > PurchaseHistoryList { 
        get;
        private set; 
    }
    
}