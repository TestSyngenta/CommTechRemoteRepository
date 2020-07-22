// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class TaskChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global RecordType RecordType;
    global Id RecordTypeId;
    global SObject Who;
    global Id WhoId;
    global SObject What;
    global Id WhatId;
    global Integer WhoCount;
    global Integer WhatCount;
    global String Subject;
    global Date ActivityDate;
    global String Status;
    global String Priority;
    global User Owner;
    global Id OwnerId;
    global String Description;
    global String Type;
    global Account Account;
    global Id AccountId;
    global Boolean IsClosed;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Integer CallDurationInSeconds;
    global String CallType;
    global String CallDisposition;
    global String CallObject;
    global Datetime ReminderDateTime;
    global Boolean IsReminderSet;
    global Task RecurrenceActivity;
    global Id RecurrenceActivityId;
    global Boolean IsRecurrence;
    global Date RecurrenceStartDateOnly;
    global Date RecurrenceEndDateOnly;
    global String RecurrenceTimeZoneSidKey;
    global String RecurrenceType;
    global Integer RecurrenceInterval;
    global Integer RecurrenceDayOfWeekMask;
    global Integer RecurrenceDayOfMonth;
    global String RecurrenceInstance;
    global String RecurrenceMonthOfYear;
    global String RecurrenceRegeneratedType;
    global Datetime CompletedDateTime;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    /* If this task is related to an existing project, please enter it here.
    */
    global Project_Tracker__c Related_Project__c;
    global String Sprint__c;
    global String MarTech__c;
    global Double Story_Points__c;
    global String Members__c;
    global String Board_ID__c;
    global Trello__c Martech_Project__c;
    global User Requested_By__c;
    global String Dept__c;
    global String Outcome__c;
    global String Card_ID__c;

    global TaskChangeEvent () 
    {
    }
}