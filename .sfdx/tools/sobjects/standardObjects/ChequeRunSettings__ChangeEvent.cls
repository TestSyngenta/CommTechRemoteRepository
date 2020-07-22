// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ChequeRunSettings__ChangeEvent {
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
    /* Enter the Label Names of the Settlement Record Types to include.
Separate values with a semicolon, no quotes.
Leave the field blank to include all types.
    */
    global String Settlement_Types__c;
    /* Enter the Label Names of the Case Record Types to include.  Leave it blank to include all types
Separate values with a semicolon, no quotes.
    */
    global String Case_Types__c;

    global ChequeRunSettings__ChangeEvent () 
    {
    }
}