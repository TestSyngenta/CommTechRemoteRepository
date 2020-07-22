// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Salesforce_Support__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global SObject Owner;
    global Id OwnerId;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String Comments__c;
    global String Priority__c;
    global String Status__c;
    global String Platform__c;
    global String Support_Type__c;
    global User Assigned_To__c;
    global Date Completed_Date__c;
    global String Primary_Department__c;
    global Salesforce_Support__c Parent_Ticket__c;
    global String Level_of_Effort__c;
    global String Delivery_Team__c;
    global String Percentage_Complete__c;
    global Date Build_Start_Date__c;
    global Date Build_End_Date__c;
    global User Syngenta_Contact__c;
    global Date Release_Date__c;
    global Double Release_Priority__c;
    global String Project__c;
    global String Communication_Details__c;
    global String Testing_Details__c;
    global String Value__c;
    global Double Estimated_Hours__c;
    /* Release that the Salesforce Feedback will be included in.
    */
    global Release__c Release_1__c;
    /* I want <some goal> 
The goal that is trying to be achieved.
    */
    global String I_want_to__c;
    /* So that <some reason or achievement>
    */
    global String So_that__c;
    global String Deployment_Details__c;
    global String Salesforce_Support__c;
    global String Complexity__c;

    global Salesforce_Support__ChangeEvent () 
    {
    }
}