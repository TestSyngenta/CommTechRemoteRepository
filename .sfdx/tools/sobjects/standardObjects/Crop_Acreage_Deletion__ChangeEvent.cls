// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Crop_Acreage_Deletion__ChangeEvent {
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
    /* Enter the number of days to determine which Crop Acreage records cannot be deleted. Will be used as follows: If Crop Acreage Created Date is < (Today - X Days), then they cannot delete the records. X = the days entered here.
    */
    global Double Days__c;
    /* Enter the error message that you would like to appear to users who try to delete crop acreage records, but are not authorized to do so.
    */
    global String Error_Message__c;
    /* Enter list of Profile IDs that are authorized to delete crop acreage records regardless of when they were created. Enter 15-character Profile IDs separated by a comma (no space)
    */
    global String Profiles_IDs__c;
    /* Enter list of User IDs that are authorized to delete crop acreage records regardless of when they were created. Enter 15-character User IDs separated by a comma (no space)
    */
    global String User_IDs__c;

    global Crop_Acreage_Deletion__ChangeEvent () 
    {
    }
}