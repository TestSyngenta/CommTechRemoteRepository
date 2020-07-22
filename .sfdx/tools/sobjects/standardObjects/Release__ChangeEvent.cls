// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Release__ChangeEvent {
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
    global Date Actual_Release_Date__c;
    /* Date the release was communicated to the business.
    */
    global Date Communication_Date__c;
    /* Details of how the release was communicated and to what audience.
    */
    global String Communication_Details__c;
    global Date Planned_Release_Date__c;
    /* Include all enhancements that are included in the release.
    */
    global String Release_Components__c;
    global String Release_Description__c;
    global Boolean Back_Up_Completed__c;
    global Boolean Release_Complete__c;

    global Release__ChangeEvent () 
    {
    }
}