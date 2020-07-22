// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Exception_Log__ChangeEvent {
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
    global String Context_Data__c;
    global String Exception_Name__c;
    global String Exception_Type__c;
    global String Exception__c;
    global String Exception_stacktrace__c;
    global String Object_Name__c;
    global String Record_Ids__c;
    global String Source_Method__c;
    global String Source_class__c;
    global String Transaction_Code__c;
    global User User__c;

    global Exception_Log__ChangeEvent () 
    {
    }
}