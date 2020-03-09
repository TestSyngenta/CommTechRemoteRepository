@isTest
public class Settlement_NewRecordType_ControllerTest {
    public static TestMethod void controllerTest(){
        
        Settlement__c testSettlement = new Settlement__c();
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(testSettlement);
        Settlement_NewRecordType_Controller settlementCon = new Settlement_NewRecordType_Controller(stdcontroller);
        
        RecordType rt = [Select Id, DeveloperName from RecordType where SObjectType='Case' Limit 1];
        Account testAccount = new Account(Name='SettlementTestAccount102430491');
        insert testAccount;
        Case testCase = new Case(RecordTypeId=rt.Id, AccountID=testAccount.Id);
        insert testCase;
        testSettlement.Case__c = testCase.id;

        stdcontroller = new ApexPages.StandardController(testSettlement);
        settlementCon = new Settlement_NewRecordType_Controller(stdcontroller);

        settlementCon.SkipSelectionScreen();
        
        SettlementRecordTypes__c setting = new SettlementRecordTypes__c(Name=rt.DeveloperName, Settlement_Types__c='Cheque');
        insert setting;
        
        stdcontroller = new ApexPages.StandardController(testSettlement);
        settlementCon = new Settlement_NewRecordType_Controller(stdcontroller);

        settlementCon.SkipSelectionScreen();
        settlementCon.GoToEditPage();
        
        if (settlementCon.ContinueButtonStatus == True){}
    }
}