// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Account_Snapshot__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Account Account__c;
    global Date End_Date__c;
    global User Sales_Rep__c;
    global Date Start_Date__c;
    global Territory__c Territory__c;
    global String Touchpoint__c;
    global Double Touchpoint_Flag__c;
    global Double Flag_Snapshot__c;
    global Boolean Checksum__c;

    global Account_Snapshot__ChangeEvent () 
    {
    }
}