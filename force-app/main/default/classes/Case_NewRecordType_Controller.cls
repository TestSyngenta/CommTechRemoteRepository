public class Case_NewRecordType_Controller {

    ApexPages.StandardController stdController;
    Map<String,RecordType> rtMap;    
    
    public Case newCase{ get; set; }
    public Account parent { get; set; }
    public Contact parent_contact { get; set; }
    public List<RecordType> rtList { get; set; }
    public List<SelectOption> rtOptions { get; set; }
    public String recordTypeId { get; set; }
    public Boolean ContinueButtonStatus {
        get{ return (rtOptions.size() == 0); }
        set;
    }
    
    public Case_NewRecordType_Controller(ApexPages.StandardController controller) {
        stdController = controller;
        newCase = (Case)stdController.getRecord();
        if (newCase.AccountID <> null){
            parent = [Select Id, Name, RecordType.Name, RecordType.DeveloperName from Account where Id = :newCase.AccountID];
        }
        if (newCase.ContactID <> null){
            parent_contact = [Select Id, FirstName, LastName from Contact where Id = :newCase.ContactID];
        }
        
        rtList = [Select Id, Name, DeveloperName, Description from RecordType where Sobjecttype = 'Case'];
        rtMap = new Map<String,RecordType>();
        for (RecordType rt : rtList){
            rtMap.put(rt.DeveloperName, rt);
        }
        rtOptions = new List<SelectOption>();
        if (newCase.AccountID<>null){
            getRecordTypeOptions(parent.RecordType.DeveloperName);
            if (rtOptions <> null && rtOptions.size() > 0){
                RecordTypeId = rtOptions[0].getValue();
            }
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'A new Case must be created directly from an Account.'));
            System.debug('WARNING: A new Case must be created directly from an Account.');
        }
    }
    
    void getRecordTypeOptions(String AccountRecordTypeName){
        rtList = new List<RecordType>();
        Map<String,CaseRecordTypes__c> settingsMap = CaseRecordTypes__c.getAll();
        if (settingsMap.get(AccountRecordTypeName) == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No custom setting found for Account Record Type \''+AccountRecordTypeName+'\'.  Please contact your system Administrator for assistance.'));
            System.debug('ERROR: No custom setting found for Account Record Type \''+AccountRecordTypeName+'\'.');
            return;
        }
        List<String> availableTypes = settingsMap.get(AccountRecordTypeName).Case_Types__c.split(';',0);
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
        RecordType caseRT = [Select Id, DeveloperName from RecordType where Id = :RecordTypeID];
        String availableProductTypes = null;
        
        Map<String,CaseProductRecordTypes__c> settingsMap = CaseProductRecordTypes__c.getAll();
        if (settingsMap.get(caseRT.DeveloperName) == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No custom product type setting found for Account Record Type \''+caseRT.DeveloperName+'\'.  Please contact your system Administrator for assistance.'));
            System.debug('INFO: No custom product type setting found for Account Record Type \''+caseRT.DeveloperName+'\'.');
            availableProductTypes = settingsMap.get('Default').Product_Types__c;
//            return null;
        }else{
            availableProductTypes = settingsMap.get(caseRT.DeveloperName).Product_Types__c;
        }

        PageReference editPage = new PageReference('/500/e');
        Map<String,String> params = editPage.getParameters();
        params.put('00Nq0000000YtyS',availableProductTypes);
        if (parent_contact <> null){
            params.put('cas3_lkid',parent_contact.Id);
            params.put('cas3_lkold',parent_contact.FirstName+' '+parent_contact.LastName);
        }
        if (parent <> null){
            params.put('cas4_lkid',parent.Id);
            params.put('cas4_lkold',parent.Name);
        }
        params.put('retURL',parent.Id);
        params.put('RecordType',RecordTypeId);
        params.put('nooverride', '1');        
        
        return editPage;
    }
}