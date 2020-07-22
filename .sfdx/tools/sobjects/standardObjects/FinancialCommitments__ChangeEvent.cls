// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class FinancialCommitments__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global SObject Owner;
    global Id OwnerId;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Business_Plan__c BusinessPlan__c;
    global Date EndDate__c;
    global Date StartDate__c;
    global String Status__c;
    global String Who__c;
    global String FinancialCommitments__c;
    global Decimal Total_Commitment__c;

    global FinancialCommitments__ChangeEvent () 
    {
    }
}