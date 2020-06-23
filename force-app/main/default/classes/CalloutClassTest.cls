@isTest
private class CalloutClassTest {
     @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new HttpCalloutMockTest());
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
        String password = 'r919_B4I';
        String email = 'trevor.cornfield@syngenta.com';
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = Contact_TriggerHandler.httpCallout('http://example.com/example/test', 'body');
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"example":"test"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
}