@isTest
private class CalloutClassTest {
    
     @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockTest());
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
        String password = 'r919_B4I';
        String email = 'trevor.cornfield@syngenta.com';
        List<Contact> insertList1 = new List<Contact>();
        
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = Contact_TriggerHandler.httpCallout('https://pi.pardot.com/api/login/version/3', 'body');
     
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/xml');
        String actualValue = res.getBody();
        String expectedValue = 'email=trevor.cornfield@syngenta.com&password=r919_B4I&user_key=cd215fdd852b6c7e19038b14900d2f64';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
        Account testAccount;
        Contact testContact;
        testAccount = new Account(Name='TestAccount1',
                        BillingStreet='123 TestStreet', BillingCity='TestCity', BillingState='ON', BillingPostalCode='N1H 6H9');
        Insert testAccount;
        testContact = new Contact(LastName='SyngentaContact_02', FirstName='Joe', Email='test2@goodtest.com', AccountId=testAccount.Id);
      
        Insert testContact;
        insertList1.add(testContact);
        //insert(insertList1);
        //testContact = [SELECT Id FROM Contact WHERE Id =: testContact.Id LIMIT 1];


        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockTest());
        Contact_TriggerHandler.queueCreateInPardot(insertList1);
        Test.setMock(HttpCalloutMock.class, new HttpCalloutLoginMock());
        String Response = Contact_TriggerHandler.loginToPardot();

        Test.stopTest();
    

    }
   
    

        
  
    
}