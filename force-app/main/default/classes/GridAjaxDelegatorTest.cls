@isTest
public class GridAjaxDelegatorTest {

    @isTest
    public static void testAll() {
    
	//Code review TKT-013299 Developer: Apoorva Added Test.startTest()
    Test.startTest();  
   
        // test grid view tracking
        ApexPages.CurrentPage().getParameters().put('reqType', 'trackGridView');
        ApexPages.CurrentPage().getParameters().put('gname', 'Test Grid');
        
        GridAjaxDelegator delegator = new GridAjaxDelegator();
        delegator.processRequest();
        
        List<GridBuddy_Usage_Analytics__c> trackingRecord = [select Id from GridBuddy_Usage_Analytics__c 
            where Grid_Name__c = 'Test Grid'
            and Type__c = 'Grid View' 
            and Session__c != null
            limit 1];
        
        System.assert(trackingRecord.size() > 0);
                
        // test grid save tracking
        ApexPages.CurrentPage().getParameters().put('reqType', 'trackGridSave'); 
        
        String fieldNamesJSON = '{"Case:Service_Renewal_Opportunity__c":["SuppliedName"],"Opportunity":["Name"]}';
        ApexPages.CurrentPage().getParameters().put('fieldNames', fieldNamesJSON);
        delegator.processRequest();
        
        trackingRecord = [select Id, Field_API_Names__c from GridBuddy_Usage_Analytics__c 
            where Grid_Name__c = 'Test Grid' 
            and Type__c = 'Grid Save'
            and Session__c = null
            limit 1];
           
        System.assert(trackingRecord.size() > 0);        
        System.assertEquals(fieldNamesJSON, trackingRecord[0].Field_API_Names__c);
        
        // test grid export tracking
        ApexPages.CurrentPage().getParameters().put('reqType', 'trackGridExport');
        delegator.processRequest();
        
        trackingRecord = [select Id, Field_API_Names__c from GridBuddy_Usage_Analytics__c 
            where Grid_Name__c = 'Test Grid' 
            and Type__c = 'Grid Export'
            limit 1];
           
        System.assert(trackingRecord.size() > 0);

	//Code review TKT-013299 Developer: Apoorva Added Test.stopTest()
    Test.stopTest(); 		
    }
}