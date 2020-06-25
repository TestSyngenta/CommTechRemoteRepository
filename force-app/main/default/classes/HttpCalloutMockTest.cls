@isTest
global class HttpCalloutMockTest implements HttpCalloutMock {
    // Implement this interface method
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
        String password = 'r919_B4I';
        String email = 'trevor.cornfield@syngenta.com';
        String apiKey = '';
    
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
       
        System.assertEquals('https://pi.pardot.com/api/login/version/3', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/xml');
        res.setBody('email=' + email + '&password=' + password + '&user_key=' + user_key);
        res.setStatusCode(200);
        return res;
    }
    global String fakeResponse(){
        
       
        HttpRequest req1 = new HttpRequest();
        HttpResponse res1 = new HttpResponse();
        System.assertEquals('https://pi.pardot.com/api/login/version/3', req1.getEndpoint());
        System.assertEquals('POST', req1.getMethod());

        res1.setHeader('Content-Type', 'application/xml');
        res1.setBody('email=' + email + '&password=' + password + '&user_key=' + user_key);
        res1.setStatusCode(200);
        /**
         XmlStreamReader xsr = res1.getXmlStreamReader();
         
        while(xsr.hasNext())
        {
            
            //System.Debug('Local Name is ' + xsr.getLocalName());
            //System.Debug('Event Type is ' + xsr.getEventType());
            
            if (xsr.getEventType() == XmlTag.START_ELEMENT && xsr.GetLocalName() == 'api_key') 
            {    
                xsr.next();
                apiKey=xsr.getText();
            }    
            xsr.next();
        }
        **/
        /*System.Debug('API Key is ' + apiKey);*/
        return apiKey;

    }
}