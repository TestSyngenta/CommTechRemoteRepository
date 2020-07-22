// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CommTech_Project_Task__ChangeEvent {
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
    global String Card_ID__c;
    global String Subject__c;
    global String Sprint__c;
    global Trello__c Martech_Project__c;
    /* Estimated Number of Hours
    */
    global Double Story_Points__c;
    global String Description__c;
    global String Members__c;
    global Date Due_Date__c;
    global String Status__c;
    global String Board_ID__c;
    global String Dept__c;
    global User Requested_By__c;
    /* (Running Total Of All Project Tasks)
    */
    global Double Total_Points__c;
    global Date Completed_Date__c;
    global Trello__c Martech_Tracker_Project__c;
    global String Sprint_Month__c;
    global String Sprint_Month_2__c;
    global Date Est_Start_Date__c;
    global Date Est_End_Date__c;
    global String Priority__c;
    global Boolean To_Do__c;
    global Boolean Delayed__c;
    global Boolean Doing__c;
    global Boolean QA__c;
    global Boolean Stuck__c;
    global Boolean Done__c;
    /* (Actual Completed Hours for tasks marked 'DONE')
    */
    global Double Completed_Hours__c;
    global User Task_Lead__c;
    global Double Hours_Variance__c;

    global CommTech_Project_Task__ChangeEvent () 
    {
    }
}