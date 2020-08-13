@isTest 
public class TestBatchUpdateContactsActive 
{
    public static testMethod void testMethod1() 
	{
        Profile testProfile = [Select id from Profile where Name like '%Integration%' limit 1];
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
        List<User> userList = new List<User>();
        userList.add(testUser1);
        insert userList;
        Account testAccount;
        Contact Contact1;
        System.runAs(testUser1){
        testAccount =  new Account(Name='TestAccount', OwnerID=testUser1.id,
        BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
        insert testAccount;

		Contact1 = new Contact(LastName='SyngentaContact_01', FirstName='Joe', Email = 'test1@goodtest.com', Phone='5556895253', AccountId=testAccount.Id);
		insert 	Contact1;
		
		Test.startTest();

        BatchUpdateContactstoActive obj = new BatchUpdateContactstoActive();
			DataBase.executeBatch(obj);

		Test.stopTest();
        }	
	}
}