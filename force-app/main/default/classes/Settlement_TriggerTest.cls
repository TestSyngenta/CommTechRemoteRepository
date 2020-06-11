/*  Jan 26, 2015
 *   Brian Hopkins
 *   Test Class for Settlement_Trigger.
 *  Inserts test Settlements after setting up required test records.
*/  
@isTest
public class Settlement_TriggerTest {
    
    static testmethod void runTest(){
        Profile testProfile = [Select id from Profile where Name like '%Sales%' limit 1];
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User[] approvers = new User[4];

        approvers[0] = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','Approver1');
        approvers[1] = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','Approver2');
        approvers[2] = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','Approver3');
        approvers[3] = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','Approver4');
        insert approvers;
        
        User testUser = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','TestUser01');
        testUser.DOA__c = 'No DOA';
        testUser.Approver_Level_1__c = approvers[0].id;
        testUser.Approver_Level_2__c = approvers[1].id;
        testUser.Approver_Level_3__c = approvers[2].id;
        testUser.Approver_Level_4__c = approvers[3].id;
        insert testUser;
    
        User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','TestUser02');
        testUser1.DOA__c = 'Sales Rep';
        testUser1.Approver_Level_1__c = approvers[0].id;
        testUser1.Approver_Level_2__c = approvers[1].id;
        testUser1.Approver_Level_3__c = approvers[2].id;
        testUser1.Approver_Level_4__c = approvers[3].id;
        insert testUser1;
        
        Account testAccount = new Account(Name='TestAccount', OwnerID=testUser.id,
                              BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
        System.runAs(testUser){
            insert testAccount;
        }
        
        Case testCase = new Case(AccountID=testAccount.id, Subject='Test Case', OwnerID=testUser.id, Status='Open', RecordTypeId = '012o0000000BkArAAK');
        System.runAs(testUser){
            insert testCase;
            testCase.ownerId = testUser1.Id;
            update testCase;
        }                
                    
        Settlement__c testSettlement = new Settlement__c(Case__c=testCase.id);
        System.runAs(testUser){
        insert testSettlement;
        }
        system.debug('Test Settlement ID: '+testSettlement.id);
        Settlement__c resultSettlement = [Select Id, Approver_Level_1__r.LastName, Approver_Level_2__r.LastName, 
                                                 Approver_Level_3__r.LastName, Approver_Level_4__r.LastName, Approver_Level_5__r.LastName
                                          from Settlement__c where id = :testSettlement.id];
        
        System.assertEquals('TestUser02', resultSettlement.Approver_Level_1__r.LastName);
        System.assertEquals('Approver1', resultSettlement.Approver_Level_2__r.LastName);
        System.assertEquals('Approver2', resultSettlement.Approver_Level_3__r.LastName);
        System.assertEquals('Approver3', resultSettlement.Approver_Level_4__r.LastName);
        System.assertEquals('Approver4', resultSettlement.Approver_Level_5__r.LastName);
               
        testSettlement.id = null;
        System.runAs(testUser1){
            testSettlement.Status__c = 'New';
            insert testSettlement;
            /* This is no longer required because the Settlement is being autosubmitted
            System.debug('TST_Settlelment_Approvers: Updating Settlement #2 to Pending...');
            testSettlement.Status__c = 'Pending Approval';
            update testSettlement;*/
        }
        
        resultSettlement = [Select Id, Approver_Level_1__r.LastName, Approver_Level_2__r.LastName, 
                                   Approver_Level_3__r.LastName, Approver_Level_4__r.LastName, Approver_Level_5__r.LastName
                            from Settlement__c where id = :testSettlement.id];
        
        System.assertEquals('Approver1', resultSettlement.Approver_Level_1__r.LastName);
        System.assertEquals('Approver2', resultSettlement.Approver_Level_2__r.LastName);
        System.assertEquals('Approver3', resultSettlement.Approver_Level_3__r.LastName);
        System.assertEquals('Approver4', resultSettlement.Approver_Level_4__r.LastName);
    }
}