@isTest
private class ContentDocumentLinkTriggerHandlerTest 
{
    static testMethod void testMethod1() 
    {
        Account ac = new Account(Name = 'Test');
        insert ac; 

        Programs__c program = new Programs__c(Account__c = ac.Id);
        insert program ;

        String before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
        
        //Insert contentdocument data
        ContentVersion cv1 = new ContentVersion(Title = 'test ', PathOnClient ='test', VersionData =beforeblob );    
        insert cv1;         
                                                
        ContentVersion testContent1 = [SELECT Id, ContentDocumentId FROM ContentVersion where Id = :cv1.Id];
        
        ContentVersion cv2 = new ContentVersion(Title = 'test ', PathOnClient ='test', VersionData =beforeblob );    
        insert cv2;         
                                                
        ContentVersion testContent2 = [SELECT Id, ContentDocumentId FROM ContentVersion where Id = :cv2.Id];

        ContentDocumentLink contentlink1 = new ContentDocumentLink(LinkedEntityId=program.Id, ShareType= 'V', ContentDocumentId=testContent1.ContentDocumentId );
        insert contentlink1;

        ContentDocumentLink contentlink2 = new ContentDocumentLink(LinkedEntityId=program.Id, ShareType= 'V', ContentDocumentId=testContent2.ContentDocumentId );
        insert contentlink2;

        delete [SELECT Id FROM ContentDocument WHERE Id = :testContent1.ContentDocumentId];
        
    }
}