@isTest
public class ChequeRun_TriggerTest {
    public static TestMethod void runTest(){
    
        Profile testProfile = [Select id from Profile where Name like '%Programs%' limit 1];  
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','TestUser01');
        insert testUser;
        
        System.runAs(TestUser){
            ChequeRunSettings__c testSetting = new ChequeRunSettings__c(Name='ChequeRunSettlementTypes',Settlement_Types__c='Cheque;Voucher');
            insert testSetting;
            
            Cheque_Run__c testCR = new Cheque_Run__c();
            insert testCR;
            
            Account testAccount = new Account(Name='TestAccount', OwnerID=testUser.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
            insert testAccount;
        
            Case testCase = new Case(AccountID=testAccount.id,Subject='Test Case Subject');
            insert testCase;
            
            Settlement_Payment__c testPayment1 = new Settlement_Payment__c(
                                                    Cheque_Run__c = testCR.id,
                                                    Account__c = testAccount.id,
                                                    Case__c = testCase.id,
                                                    Amount__c = 1000.00,
                                                    Status__c = 'Submitted for Payment',
                                                    Type__c = 'Cheque'
                                            );
            insert testPayment1;
            
            Settlement__c testSettlement1 = new Settlement__c(
                                                    Case__c=testCase.id, 
                                                    Status__c='Submitted for Payment', 
                                                    RecordTypeID=CLS_StaticUtils.getRecordTypeId('Settlement__c','Cheque'), 
                                                    Settlement_Amount__c=100.00,
                                                    Settlement_Payment__c=testPayment1.id
                                            );
            insert testSettlement1;
            
            testCR.Settlements_Status__c = 'Mailed';
            update testCR;
            
            Settlement_Payment__c resultPayment1 = [Select Id, Status__c from Settlement_Payment__c where Id=:testPayment1.id];
            System.assertEquals('Mailed', resultPayment1.Status__c);
            Settlement__c resultSettlement1 = [Select Id, Status__c from Settlement__c where Id=:testSettlement1.id];
            System.assertEquals('Mailed', resultSettlement1.Status__c);
            
            testCR.Status__c = 'Cancelled';
            update testCR;
            
            Settlement_Payment__c resultPayment2 = [Select Id, Status__c from Settlement_Payment__c where Id=:testPayment1.id];
            System.assertEquals('Cancelled', resultPayment2.Status__c);
            Settlement__c resultSettlement2 = [Select Id, Status__c from Settlement__c where Id=:testSettlement1.id];
            System.assertEquals('Submitted for Payment', resultSettlement2.Status__c);
        }
        
    }
}