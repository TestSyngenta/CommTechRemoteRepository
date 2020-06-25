@isTest
global class HttpCalloutMockforReset implements HttpCalloutMock {
    // Implement this interface method
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
        String password = 'r919_B4I';
        String email = 'trevor.cornfield@syngenta.com';
        String apiKey = '';
    
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
       
        System.assertEquals('https://pi.pardot.com/api/prospect/version/4/do/update/fid/', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/xml');
        res.setBody('<rsp stat="fail" version="1.0"><err code="182">Invalid header value: Missing or empty Authorization header parsed from http headers</err></rsp>');
        res.setStatusCode(200);
        return res;
    }

   
  
    }