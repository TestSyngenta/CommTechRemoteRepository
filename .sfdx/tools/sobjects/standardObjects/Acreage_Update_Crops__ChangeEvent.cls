// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Acreage_Update_Crops__ChangeEvent {
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
    /* Enter the Crop Names, separated by semicolons.
    */
    global String Crops1__c;
    global String Crops2__c;
    global String Crops3__c;
    /* Separate multiple years with semicolons
    */
    global String Years_Available__c;

    global Acreage_Update_Crops__ChangeEvent () 
    {
    }
}