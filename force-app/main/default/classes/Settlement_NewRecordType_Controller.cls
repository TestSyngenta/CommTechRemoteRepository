public class Settlement_NewRecordType_Controller {

    ApexPages.StandardController stdController;
    Map<String,RecordType> rtMap;    
    
    public Settlement__c newSettlement{ get; set; }
    public Case parent { get; set; }
    public List<RecordType> rtList { get; set; }
    public List<SelectOption> rtOptions { get; set; }
    public String recordTypeId { get; set; }
    public Boolean ContinueButtonStatus {
        get{ return (rtOptions.size() == 0); }
        set;
    }
    
    public Settlement_NewRecordType_Controller(ApexPages.StandardController controller) {
        stdController = controller;
        newSettlement = (Settlement__c)stdController.getRecord();
        if (newSettlement.Case__c <> null){
            parent = [Select Id, CaseNumber, Subject, RecordType.Name, RecordType.DeveloperName from Case where Id = :newSettlement.Case__c];
        }
        
        rtList = [Select Id, Name, DeveloperName, Description from RecordType where Sobjecttype = 'Settlement__c'];
        rtMap = new Map<String,RecordType>();
        for (RecordType rt : rtList){
            rtMap.put(rt.DeveloperName, rt);
        }
        rtOptions = new List<SelectOption>();
        if (newSettlement.Case__c<>null){
            getRecordTypeOptions(parent.RecordType.DeveloperName);
            if (rtOptions <> null && rtOptions.size() > 0){
                RecordTypeId = rtOptions[0].getValue();
            }
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'You must create a settlement directly from a Case detail page.'));
        }
    }
    
    void getRecordTypeOptions(String CaseRecordTypeName){
        rtList = new List<RecordType>();
        Map<String,SettlementRecordTypes__c> settingsMap = SettlementRecordTypes__c.getAll();
        if (settingsMap.get(CaseRecordTypeName) == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No custom setting found for Case Record Type \''+CaseRecordTypeName+'\'.  Please contact your system Administrator for assistance.'));
            return;
        }
        List<String> availableTypes = settingsMap.get(CaseRecordTypeName).Settlement_Types__c.split(';',0);
        for (String s : availableTypes){
            rtList.add(rtMap.get(s));
        }
        for (RecordType rt : rtList){
            rtOptions.add(new SelectOption(rt.Id, rt.Name));
        }
    }
    
    public PageReference SkipSelectionScreen(){
        if (rtOptions.size()==1){
            RecordTypeId = rtOptions[0].getValue();
            return GoToEditPage();
        }
        return null;
    }

    public PageReference GoToEditPage(){
        PageReference editPage = new PageReference('/a0l/e');

        Map<String,String> params = editPage.getParameters();
        params.put('CF00No0000008RmZ5',parent.CaseNumber);
        params.put('CF00No0000008RmZ5_lkid',parent.Id);
        params.put('retURL',parent.Id);
        params.put('RecordType',RecordTypeId);
        params.put('nooverride', '1');        
        
        return editPage;
    }
}