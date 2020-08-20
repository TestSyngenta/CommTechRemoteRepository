// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__SMS_Schedule__c {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Date LastActivityDate;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String smagicinteract__Campaign_Statuses__c;
    global String smagicinteract__Condition__c;
    global Date smagicinteract__Date__c;
    global Date smagicinteract__End_Date__c;
    global String smagicinteract__Exclude_Phone_Json__c;
    global String smagicinteract__Failure_Reason__c;
    global String smagicinteract__Job_ID__c;
    global smagicinteract__List_View_Configuration__c smagicinteract__List_View_Configuration__r;
    global Id smagicinteract__List_View_Configuration__c;
    global String smagicinteract__Name_Field__c;
    global String smagicinteract__Object__c;
    global String smagicinteract__Optout_Field__c;
    global String smagicinteract__Phone_Field__c;
    global String smagicinteract__Record_Ids__c;
    global smagicinteract__SMS_Template__c smagicinteract__SMS_Template__r;
    global Id smagicinteract__SMS_Template__c;
    global String smagicinteract__SMS_Text__c;
    global String smagicinteract__Schedule_JobId__c;
    global String smagicinteract__Schedule_Name__c;
    global Datetime smagicinteract__Scheduled_Date__c;
    global String smagicinteract__Selected_Days_RecurWeek__c;
    global String smagicinteract__Selected_Months_RecurMonthly__c;
    global String smagicinteract__Selected_Months_RecurYearly__c;
    global User smagicinteract__Selected_User__r;
    global Id smagicinteract__Selected_User__c;
    global String smagicinteract__SenderId__c;
    global Boolean smagicinteract__Show_Other_Users__c;
    global String smagicinteract__Status__c;
    global String smagicinteract__Template_Id_Json__c;
    global String smagicinteract__Unrelated_Object_ID__c;
    global String smagicinteract__Variable_Day_RecurDay__c;
    global String smagicinteract__isOptout__c;
    global Boolean smagicinteract__isRecurring__c;
    global String smagicinteract__recursTypeForDaily__c;
    global String smagicinteract__recursTypeMonthly__c;
    global String smagicinteract__recursTypeYearly__c;
    global String smagicinteract__recursType__c;
    global String smagicinteract__selectedDateForYear__c;
    global String smagicinteract__selectedDayForMonth1__c;
    global String smagicinteract__selectedDayForMonth2__c;
    global String smagicinteract__selectedMonthForYear__c;
    global String smagicinteract__selectedMonth__c;
    global String smagicinteract__selectedWeekDayForYear__c;
    global String smagicinteract__selectedWeekForMonth__c;
    global String smagicinteract__selectedWeekForYear__c;
    global String smagicinteract__variableMonth1__c;
    global String smagicinteract__variableMonth2__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<NetworkActivityAudit> ParentEntities;
    global List<NetworkUserHistoryRecent> NetworkUserHistoryRecentToRecord;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<SurveySubject> SurveySubjectEntities;
    global List<Task> Tasks;
    global List<TaskRelation> TaskRelations;
    global List<TopicAssignment> TopicAssignments;
    global List<smagicinteract__Converse_App_Action__c> smagicinteract__Converse_App_Actions__r;
    global List<smagicinteract__SMS_Schedule__History> Histories;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__SMS_Schedule__c () 
    {
    }
}