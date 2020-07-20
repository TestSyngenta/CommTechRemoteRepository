@isTest(SEEALLDATA = true)
public class TestFileCountCommercialExperience{

static TestMethod void testCommercialExperience(){
    Commercial_Experience_Demos__c ce = [Select id, File_Count__c From Commercial_Experience_Demos__c LIMIT 1 ];
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
    ContentDocumentLink cd = new ContentDocumentLink();
    
    cd.LinkedEntityId = ce.id;
    cd.ContentDocumentId = documents[0].Id;
    test.startTest();
    insert cd;
    
    Test.stopTest();
    
}
}