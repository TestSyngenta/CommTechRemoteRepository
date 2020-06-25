@isTest
global class HttpMockLogintoPardot implements HttpCalloutMock {
    // Implement this interface method
        String user_key = 'cd215fdd852b6c7e19038b14900d2f64';
        String password = 'r919_B4I';
        String email = 'trevor.cornfield@syngenta.com';
        String apiKey = '';
    
    

    private static final String Fake_ApiKey = '15fdd852b6c7e19038b14900d2f64';
    global HttpResponse respond(HttpRequest req1){

        HttpResponse res1 = new HttpResponse();
        res1.setHeader('Content-Type', 'application/xml');

        res1.setBody('Fake_ApiKey');
        res1.setStatusCode(200);
        return res1;
    }
  
    }
