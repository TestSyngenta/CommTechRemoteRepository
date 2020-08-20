// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CommTech_Project_Task__c {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
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
    global String Card_ID__c;
    global String Subject__c;
    global String Sprint__c;
    global Trello__c Martech_Project__r;
    global Id Martech_Project__c;
    /* Estimated Number of Hours
    */
    global Double Story_Points__c;
    global String Description__c;
    global String Members__c;
    global Date Due_Date__c;
    global String Status__c;
    global String Board_ID__c;
    global String Dept__c;
    global User Requested_By__r;
    global Id Requested_By__c;
    /* (Running Total Of All Project Tasks)
    */
    global Double Total_Points__c;
    global Date Completed_Date__c;
    global Trello__c Martech_Tracker_Project__r;
    global Id Martech_Tracker_Project__c;
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
    global User Task_Lead__r;
    global Id Task_Lead__c;
    global Double Hours_Variance__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<CommTech_Project_Task__Feed> Feeds;
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
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global CommTech_Project_Task__c () 
    {
    }
}