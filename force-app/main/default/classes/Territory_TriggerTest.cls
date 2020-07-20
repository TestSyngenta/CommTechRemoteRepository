@isTest
public class Territory_TriggerTest {

    static testmethod void runTest(){
        
            Profile testProfile = [Select id from Profile where Name like '%Programs%' limit 1];  
            UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
 
            User testUser = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','TestUser01');
            User testUser2 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'','TestUser02');        
            insert testUser;
            insert testUser2;
            
            System.Runas(testUser){
            
            List<Account> accList = new List<Account>();
                       Id recTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
            
            Territory__c terr_a = new Territory__c (Name='A6339N', Assigned_Rep__c = testUser.Id);
            insert terr_a;
      
            Account acc = new Account();
            acc.Name = 'test_Retailer_Account';
            acc.RecordTypeId = recTypeId;
            acc.OwnerId = testUser.Id;
            acc.Territory_Lookup__c = terr_a.Id;
            acc.NSAP_ID__c  = String.valueOf(Math.round(Math.random()*10000000));
            insert acc;
            
                        
            terr_a.Assigned_Rep__c = testUser2.Id;
            update terr_a;
            
            Account a2 = [select Id, OwnerId from Account where Id = :acc.Id];
             
        System.assertEquals(a2.OwnerId, testUser2.Id);
        }
    }

}