// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class pi__AsyncRequest_Settings__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global SObject SetupOwner;
    global Id SetupOwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    /* Is Enabled
    */
    global Boolean pi__Is_Enabled__c;
    global Datetime pi__Next_Run_Time__c;
    global Datetime pi__Last_Run_Time__c;
    global String pi__Result_Summary__c;

    global pi__AsyncRequest_Settings__ChangeEvent () 
    {
    }
}