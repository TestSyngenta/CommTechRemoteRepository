// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Internal_Note_Setting__ChangeEvent {
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
    /* Checking this will enable the internal note functionality
    */
    global Boolean smagicinteract__Internal_Note_Enabled__c;

    global smagicinteract__Internal_Note_Setting__ChangeEvent () 
    {
    }
}