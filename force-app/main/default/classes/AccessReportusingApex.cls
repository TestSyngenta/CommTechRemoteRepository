public with sharing class AccessReportusingApex {
    
    public AccessReportusingApex() {
        //Get the Report Id
        List<Report> reportList = [SELECT ID, DeveloperName FROM Report Where DeveloperName = 'Contacts_with_Email_No_Pardot_URL'];
        String reportId = (String)reportList.get(0).get('Id');
        
        //Run the Report
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId,true);
        System.debug('Synchronous results:' +results);
        
    }
}
