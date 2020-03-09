/*   Aug 5, 2016
 *   Trevor Cornfield
 *   Test Class for Settlement_Send_ERelease class
 *  Inserts test Settlements after setting up required test records.
*/  
@isTest
public class Settlement_Send_ERelease_Test {
    /*
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
        
           
        Case testCase = new Case(AccountID=testAccount.id, Subject='Test Case', OwnerID=testUser.id, Status='Open');
        System.runAs(testUser){
            insert testCase;
            testCase.ownerId = testUser1.Id;
            update testCase;
        }            
        
                    
        Settlement__c testSettlement = new Settlement__c(Case__c=testCase.id);
        testSettlement.Settlement_Amount__c = 5001;
        PageReference newURL;
        
        System.runAs(testUser){
        insert testSettlement;
        
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(testSettlement);
            Settlement_Send_ERelease_Controller releaseController = new Settlement_Send_ERelease_Controller(stdController);
            newURL = releaseController.SendRelease();
        }
        
        System.assertEquals(newURL.getURL(), '/' + testSettlement.Id);
       
        Settlement__c testSettlement2 = new Settlement__c(Case__c=testCase.id);
        testSettlement2.Settlement_Amount__c = 4999;
        
        System.runAs(testUser){
        insert testSettlement2;
        
            
            ApexPages.StandardController stdController = new ApexPages.StandardController(testSettlement2);
            Settlement_Send_ERelease_Controller releaseController = new Settlement_Send_ERelease_Controller(stdController);
            newURL = releaseController.SendRelease();
        }
        
        System.assertEquals(newURL.getURL(), '/apex/echosign_dev1__AgreementTemplateProcess?masterid=' + testSettlement2.Id + '&templateId=a1Co0000002lGrL');
       
       
        
    }*/
}