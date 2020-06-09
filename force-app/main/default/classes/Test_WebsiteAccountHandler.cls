@isTest(SEEALLDATA = true)
public class Test_WebsiteAccountHandler {
    
     static TestMethod void testWebsiteAccount(){
        wint__Website_Account__c winTest =[Select id,wint__Any__c FROM wint__Website_Account__c LIMIT 1];
        System.debug('Test Data is' +winTest);
        winTest.wint__Any__c = winTest.wint__Any__c+'test';
        test.startTest();
        update winTest;
        test.stopTest();     
    }
    static testMethod void testJson(){
        wint__Website_Account__c winTest =[Select id,wint__Any__c FROM wint__Website_Account__c LIMIT 1];
        String json = winTest.wint__Any__c;
        FarmWrapper obj = Farmwrapper.parse(json);
		System.assert(obj != null);
        
    }

}