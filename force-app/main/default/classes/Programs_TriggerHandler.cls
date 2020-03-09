public class Programs_TriggerHandler {

    public static void DuplicateCheck(Programs__c[] newRows){
        List<Id> AccountIDs = new List<Id>();
        if (newRows <> null){
            for (Programs__c p : newRows){
                if(p.Account__c <> null){
                    AccountIDs.add(p.Account__c);
                }    
            }
        }
        
        List<Programs__c> ProgramsList = [Select Id, Account__c, Program_Year__c, Offer_Type__c,
                                          RecordType.Id, RecordType.Name, RecordType.DeveloperName 
                                          from Programs__c where Account__c in :AccountIDs];
        Map<String,ID> ProgramCodeMap = new Map<String,ID>();
        for (Programs__c p : ProgramsList){
            String programCode = p.Account__c+'|'+p.RecordType.DeveloperName+'|'+p.Offer_Type__c+'|'+p.Program_Year__c;
            ProgramCodeMap.put(programCode,p.Id);
        }
        for (Programs__c p : newRows){
            String recordTypeName = CLS_StaticUtils.RecordTypeMap.get(p.RecordTypeID).DeveloperName;
            String programCode = p.Account__c+'|'+recordTypeName+'|'+p.Offer_Type__c+'|'+p.Program_Year__c;
            if (ProgramCodeMap.containsKey(programCode)){ // if the key already exists
                if (ProgramCodeMap.get(programCode) != p.Id){ // if the record is different from the one being checked
                    p.addError('Error:  Program already exists for '+recordTypeName+' in '+p.Program_Year__c);
                    System.debug('Error:  Program already exists for '+recordTypeName+' in '+p.Program_Year__c);
                }
            }
        }
    }
}