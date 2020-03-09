@isTest
public class AccountDetails_PurchHist_ControllerTest {

	public static testmethod void controllerTest(){
       
        // insert test Account
        Account testAccount = new Account(Name='TestAccount BP02',territory__c='TestTerritory02');
        insert testAccount;        

	    // insert test transaction
        Summary_OTGS_Child_Account_Brand__c testOTG = new Summary_OTGS_Child_Account_Brand__c(
            Account__c = testAccount.id,
            External_Key__c='test key',
            Product_Line__c='test line',
            Brand_Name__c = null,
            PY0_Individual_SDP__c = 100,
            PY1_Individual_SDP__c = 90,
            PY2_Individual_SDP__c = 80,
            PY3_Individual_SDP__c = 70
        );
        insert testOTG;
        
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(testAccount);
        AccountDetails_PurchHist_Controller otgCon = new AccountDetails_PurchHist_Controller(stdcontroller);
        
        system.assertEquals(1,otgCon.PurchaseHistoryList.size());
	}
    
}