@isTest
private class CalloutMultiStaticClassTest {
    @isTest static void testCalloutWithMultipleStaticResources() {
        // Use MultiStaticResourceCalloutMock to
        // specify fake response for a certain endpoint and 
        // include response body in a static resource.    
        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        multimock.setStaticResource(
            'http://example.com/example/test', 'mockResponse');
        multimock.setStaticResource(
            'http://example.com/example/sfdc', 'mockResponse2');
        multimock.setStatusCode(200);
        multimock.setHeader('Content-Type', 'application/xml');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, multimock);
        
        // Call the method for the first endpoint
        HTTPResponse res = Contact_TriggerHandler.httpCallout('https://pi.pardot.com/api/login/version/3', 'body');
        // Verify response received 
        System.assertEquals('email=trevor.cornfield@syngenta.com&password=r919_B4I&user_key=cd215fdd852b6c7e19038b14900d2f64', res.getBody());
        
        // Call the method for the second endpoint
        String res2 = Contact_TriggerHandler.loginToPardot();
        // Verify response received 
        System.assertEquals('{"hah":"fooled you twice"}', res.getBody());
    }
}