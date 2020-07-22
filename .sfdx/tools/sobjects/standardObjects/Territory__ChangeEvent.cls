// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Territory__ChangeEvent {
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
    global User Assigned_Rep__c;
    global Boolean Migrated_Record__c;
    global String Description__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global Boolean Inactive__c;
    global String Sales_Org__c;
    global String Sales_Org_Description__c;
    global String Territory_Map__c;
    global String Map_Id__c;
    /* to store the CU of the respective territory  (will be blank for CU records)
    */
    global Territory__c CommercialUnit__c;
    /* to store the district of the respective territory (will be blank for District & CU records)
    */
    global Territory__c District__c;
    global String TerritoryLevel__c;

    global Territory__ChangeEvent () 
    {
    }
}