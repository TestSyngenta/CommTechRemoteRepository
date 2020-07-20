@isTest(SEEALLDATA = true)
public class TestFileCountPreCommercialTrials{

static TestMethod void testFileCountPreCommercialTrials(){
    Customer_Experience_Trials__c ce = [Select id, File_Count__c From Customer_Experience_Trials__c LIMIT 1 ];
    List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
    ContentDocumentLink cd = new ContentDocumentLink();
    
    cd.LinkedEntityId = ce.id;
    cd.ContentDocumentId = documents[0].Id;
    test.startTest();
    insert cd;
    
    Test.stopTest();
    
}
}