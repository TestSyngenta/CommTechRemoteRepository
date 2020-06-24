@isTest
global class HttpLoginMockTest {
    // Implement this interface method
    testMethod static void testCallout() {
        
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
        String password = 'r919_B4I';
        String email = 'trevor.cornfield@syngenta.com';
        String apiKey = '';
        System.assertEquals('https://pi.pardot.com/api/login/version/3', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        String result;
        res.setHeader('Content-Type', 'application/xml');
        res.setBody('email=' + email + '&password=' + password + '&user_key=' + user_key);
        res.setStatusCode(200);
       
        XmlStreamReader xsr = res.getXmlStreamReader();
         
         while(xsr.hasNext())
         {
             /*
             System.Debug('Local Name is ' + xsr.getLocalName());
             System.Debug('Event Type is ' + xsr.getEventType());
             */
             if (xsr.getEventType() == XmlTag.START_ELEMENT && xsr.GetLocalName() == 'api_key') 
             {    
                 xsr.next();
                 apiKey=xsr.getText();
             }    
             xsr.next();
         }
         
         /*System.Debug('API Key is ' + apiKey);*/
         return apiKey;
    }
}