@isTest
public class AccountDetails_Acreage_ControllerTest {
	
    public static testmethod void controllerTest(){
        
        // insert test crop
        Crop__c testCrop = new Crop__c(Name='TestCrop_12304723232');
        insert testCrop;
        // insert test crop biopotentials
        Crop_BioPotential__c testBP = new Crop_BioPotential__c(Crop__c=testCrop.id,Territory__c='TestTerritory02',Value_per_Acre__c=2.0);
        insert testBP;
        // insert test Account
        Account testAccount = new Account(Name='TestAccount BP02',territory__c='TestTerritory02');
        insert testAccount;        
        // insert acreage that is guaranteed to be "Most Recent"
        Crop_Acreage__c testAcreage0 = new Crop_Acreage__c(Account__c=testAccount.id,Crop__c=testCrop.id,Acres__c = 100,Year__c='9999');
        insert testAcreage0;
        
    	ApexPages.StandardController stdcontroller = new ApexPages.StandardController(testAccount);
	    AccountDetails_Acreage_Controller acreageCon = new AccountDetails_Acreage_Controller(stdcontroller);

        system.assertEquals(100, acreageCon.totalAcres);
        system.assertEquals(200.00, acreageCon.totalBP);
        system.assertEquals(1, acreageCon.AcreageList.size());
        
    }
    
}