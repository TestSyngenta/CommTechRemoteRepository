// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class OpenActivity {
    global Id Id;
    global Account Account;
    global Id AccountId;
    global SObject Who;
    global Id WhoId;
    global SObject What;
    global Id WhatId;
    global String Subject;
    global Boolean IsTask;
    global Date ActivityDate;
    global Datetime ActivityDateTime;
    global SObject Owner;
    global Id OwnerId;
    global String Status;
    global String Priority;
    global Boolean IsHighPriority;
    global String ActivityType;
    global Boolean IsClosed;
    global Boolean IsAllDayEvent;
    global Boolean IsVisibleInSelfService;
    global Integer DurationInMinutes;
    global String Location;
    global String Description;
    global Boolean IsDeleted;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Integer CallDurationInSeconds;
    global String CallType;
    global String CallDisposition;
    global String CallObject;
    global Datetime ReminderDateTime;
    global Boolean IsReminderSet;
    global Datetime EndDateTime;
    global Datetime StartDateTime;
    global SObject PrimaryWho;
    global Id PrimaryWhoId;
    global Account PrimaryAccount;
    global Id PrimaryAccountId;
    global String ActivitySubtype;
    global EmailMessage AlternateDetail;
    global Id AlternateDetailId;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    /* If this task is related to an existing project, please enter it here.
    */
    global Project_Tracker__c Related_Project__r;
    /* If this task is related to an existing project, please enter it here.
    */
    global Id Related_Project__c;
    global String Sprint__c;
    global String MarTech__c;
    global Double Story_Points__c;
    global String Members__c;
    global String Board_ID__c;
    global Trello__c Martech_Project__r;
    global Id Martech_Project__c;
    global User Requested_By__r;
    global Id Requested_By__c;
    global String Dept__c;
    global String Outcome__c;
    global String Card_ID__c;

    global OpenActivity () 
    {
    }
}