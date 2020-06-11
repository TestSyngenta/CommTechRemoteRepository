/** 2015-02-09 Brian Hopkins
 *  test class for CropAcreage_TriggerBefore and CropAcreage_TriggerAfter
 */
@isTest
public class CropAcreage_TriggerTest {

    public static TestMethod void runTest(){
        Test.startTest();
        Crop_Acreage_Deletion__c setting = new Crop_Acreage_Deletion__c(Days__c = 0 , Profiles_IDs__c = UserInfo.getProfileId(), User_IDs__c = UserInfo.getUserId());
        insert setting ;


        // create test crop
        Crop__c testCrop = new Crop__c(Name='TestCrop_1230472398');
        insert testCrop;
        // create test crop biopotentials
        Crop_BioPotential__c testBP = new Crop_BioPotential__c(Crop__c=testCrop.id,Territory__c='TestTerritory02',Value_per_Acre__c=2.0);
        insert testBP;
        // create test segmentation bands
        List<Value_Segmentation__c> vsList = new List<Value_Segmentation__c>();
        Value_Segmentation__c testDecile0 = new Value_Segmentation__c(Label__c='test0',Type__c='Decile',Min_Value__c=-1,Max_Value__c=0);
        vsList.add(testDecile0);
        Value_Segmentation__c testDecile1 = new Value_Segmentation__c(Label__c='test1',Type__c='Decile',Min_Value__c=0,Max_Value__c=1000);
        vsList.add(testDecile1);
        insert vsList;
        // create test account
        Account testAccount = new Account(Name='TestAccount BP02',territory__c='TestTerritory02');
        insert testAccount;
        
        // insert acreage
        Crop_Acreage__c testAcreage0 = new Crop_Acreage__c(Account__c=testAccount.id,Crop__c=testCrop.id,Acres__c = 0,Year__c='2009');
        insert testAcreage0;

        // test 'most recent' flag... should be set
        testAcreage0 = [Select Id, Most_Recent__c from Crop_Acreage__c where Id = :testAcreage0.id];
        System.assertEquals(true,testAcreage0.Most_Recent__c);
        
        // insert newer acreage
        Crop_Acreage__c testAcreage1 = new Crop_Acreage__c(Account__c=testAccount.id,Crop__c=testCrop.id,Acres__c = 100,Year__c='2010');
        insert testAcreage1;
        
        // test 'most recent' flag again... should be cleared
        testAcreage0 = [Select Id, Most_Recent__c from Crop_Acreage__c where Id = :testAcreage0.id];
        System.assertEquals(false,testAcreage0.Most_Recent__c);

        // test biopotential on crop acreage and 'most recent' flag
        testAcreage1 = [Select Id, Account__c, Crop__c, Acres__c, BioPotential__c, Most_Recent__c from Crop_Acreage__c where Id = :testAcreage1.id];
        System.assertEquals(200.00, testAcreage1.BioPotential__c);
        System.assertEquals(true,testAcreage1.Most_Recent__c);
        
        // test account decile.  should be 'test1' from above.
        testAccount = [Select id, Opportunity_Decile__c from Account where Id = :testAccount.id];
        System.assertEquals('test1', testAccount.Opportunity_Decile__c);

        // delete acreage
        delete testAcreage1;
        
        // test 'most recent' flag again... should be set
        testAcreage0 = [Select Id, Most_Recent__c from Crop_Acreage__c where Id = :testAcreage0.id];
        System.assertEquals(true,testAcreage0.Most_Recent__c);

        // test account decile... should be '11' by default
        testAccount = [Select id, Opportunity_Decile__c from Account where Id = :testAccount.id];
        Test.stopTest();
        System.assertEquals('test0', testAccount.Opportunity_Decile__c);
        
        // special cases; exceptions
        /*testAccount.territory__c='unknownTerritory02';
        update testAccount;
        testAcreage0.Acres__c=1;
        update testAcreage0;
        delete testAcreage0;*/
    }

    static testMethod void testDelete() 
    {
        Account ac = new Account(Name = 'Test Account');
        insert ac; 

        Crop__c cr = new Crop__c(Name='Test');
        insert cr;

        Crop_Acreage__c ca = new Crop_Acreage__c(Account__c = ac.Id, Year__c = '2016', Crop__c = cr.Id, Acres__c = 1, Data_Source__c = 'F2F' );
        insert ca ; 

        Crop_Acreage_Deletion__c setting = new Crop_Acreage_Deletion__c(Days__c = 0 , Profiles_IDs__c = UserInfo.getProfileId(), User_IDs__c = UserInfo.getUserId());
        insert setting ;

        delete ca;
    }
}