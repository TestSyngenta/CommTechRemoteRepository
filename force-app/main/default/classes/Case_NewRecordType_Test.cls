@isTest
public class Case_NewRecordType_Test {
    public static TestMethod void controllerTest(){
        
        Case testCase = new Case();
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(testCase);
        Case_NewRecordType_Controller caseCon = new Case_NewRecordType_Controller(stdcontroller);
        
        
        Account testAccount = new Account(Name='TestAccountSyngenta0192480192384',
                                          RecordTypeID=CLS_StaticUtils.getRecordTypeId('Account', 'Grower'));
        insert testAccount;
        Contact testContact = new Contact(FirstName='Test11234', LastName='TestContact11234', AccountID=testAccount.id);
        insert testContact;
        
        testCase.AccountID = testAccount.id;
        testCase.ContactID = testContact.id;
        
        stdcontroller = new ApexPages.StandardController(testCase);
        caseCon = new Case_NewRecordType_Controller(stdcontroller);
	    
        caseCon.skipSelectionScreen();

        CaseRecordTypes__c caseSetting = new CaseRecordTypes__c(Name='Grower', Case_Types__c='CP_Product_Quality;Crop_Injury');
        insert caseSetting;
        
        CaseProductRecordTypes__c productSetting = new CaseProductRecordTypes__c(Name='Default', Product_Types__c='Seeds,Seedcare,CP');
        insert productSetting;
        
        stdcontroller = new ApexPages.StandardController(testCase);
        caseCon = new Case_NewRecordType_Controller(stdcontroller);

        caseCon.SkipSelectionScreen();
        caseCon.GoToEditPage();
        
        if (caseCon.ContinueButtonStatus == true){}
    }
}