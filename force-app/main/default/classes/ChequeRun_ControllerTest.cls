@isTest
public class ChequeRun_ControllerTest {
    public static testmethod void controllerTest(){
           
/*
        Old code before Aug 8 2016
        Settlement__c testSettlement1 = new Settlement__c(Case__c=testCase.id, Status__c='Submitted for Payment', RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Cheque'), Settlement_Amount__c=100.00);
        insert testSettlement1;
        Settlement__c testSettlement2 = new Settlement__c(Case__c=testCase.id, Status__c='Submitted for Payment', RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Voucher'), Settlement_Amount__c=200.00);
        insert testSettlement2;
        Settlement__c testSettlement3 = new Settlement__c(Case__c=testCase.id, Status__c='Submitted for Payment', RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Voucher'), Settlement_Amount__c=300.00);
        insert testSettlement3;
        
*/      
        Profile testProfile = [Select id from Profile where Name like '%Programs%' limit 1];  
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','TestUser01');
        insert testUser;
        
        
        System.runAs(testUser){
            ChequeRunSettings__c testSetting = new ChequeRunSettings__c(Name='ChequeRunSettlementTypes',Settlement_Types__c='Cheque;Voucher');
            insert testSetting;
        
            Account testAccount = new Account(Name='TestAccount', OwnerID=testUser.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
            insert testAccount;
        
            Case testCase = new Case(AccountID=testAccount.id,Subject='Test Case Subject');
            insert testCase;
            



            Settlement__c testSettlement1 = new Settlement__c(Case__c=testCase.id, RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Cheque'), Settlement_Amount__c=100.00);
            insert testSettlement1;
            testSettlement1.Status__c ='Submitted for Payment';
            update testSettlement1;
            Settlement__c testSettlement2 = new Settlement__c(Case__c=testCase.id, RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Voucher'), Settlement_Amount__c=200.00);
            insert testSettlement2;
            testSettlement2.Status__c ='Submitted for Payment';
            update testSettlement2;
            Settlement__c testSettlement3 = new Settlement__c(Case__c=testCase.id, RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Voucher'), Settlement_Amount__c=300.00);
            insert testSettlement3;
            testSettlement3.Status__c ='Submitted for Payment';
            update testSettlement3;

            Cheque_Run__c testCR = new Cheque_Run__c();                    
            ApexPages.StandardController stdCon = new ApexPages.StandardController(testCR);
            ChequeRun_ControllerExt crCon = new ChequeRun_ControllerExt(stdCon);
            
            System.Debug('testSettlement1.Status__c is' + testSettlement1.Status__c);
        
            crCon.addSelected();
        
            crCon.SaveChequeRun();
        
            crCon.CancelAndRollback();

        }

        
    }
}