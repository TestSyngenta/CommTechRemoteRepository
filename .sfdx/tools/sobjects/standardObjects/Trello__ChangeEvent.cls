// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Trello__ChangeEvent {
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
    global String Board_ID__c;
    global String Board_Name__c;
    global String Card_Description__c;
    global String Card_ID__c;
    global User Requested_By__c;
    global Date Due_Date__c;
    global String Members__c;
    global Contact Project_Lead__c;
    global String Status__c;
    /* This represents the total story points for the project
    */
    global Double Story_Points__c;
    global String Dept__c;
    global String Project_Type__c;
    global String CommTech_Project_Lead__c;
    global String Sprint__c;
    global Date Start_Date__c;
    /* Calculated Sum Of All Story Points (Completed Items)
    */
    global Double Total_Task_Points__c;
    global Double Story_Points_Total_Task__c;
    global String Year__c;
    global Date End_Date__c;
    global String Status_SW__c;
    global Boolean SW_Project__c;
    global String SW_Comments__c;

    global Trello__ChangeEvent () 
    {
    }
}