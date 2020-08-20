// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Duplicate_Records__ChangeEvent {
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
    global Boolean toBeDeleted__c;
    global Contact Duplicate_Contacts__c;
    global String Contact_Id__c;
    global String Contact_Name__c;
    global String Contact_First_Name__c;
    global String Contact_Last_Name__c;
    global Boolean Contact_is_Primary__c;
    global String Contact_Phone_Number__c;
    global String Contact_Mobile_Number__c;
    global Boolean Had_Related_Case__c;
    global Boolean Had_Email_Retention__c;
    global Boolean Had_Campaign__c;
    global Boolean Had_NPS__c;
    global Account Account_Id__c;
    global String Account_Name__c;

    global Duplicate_Records__ChangeEvent () 
    {
    }
}