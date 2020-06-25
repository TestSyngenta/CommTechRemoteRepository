@isTest
global class HttpCalloutLoginMock implements HttpCalloutMock {
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
        res.setBody('<rsp stat="fail" version="1.0"><err code="15">Login failed</err></rsp>');
        res.setStatusCode(200);
        return res;
    }

   
  
    }
