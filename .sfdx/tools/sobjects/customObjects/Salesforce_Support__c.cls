// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Salesforce_Support__c {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
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
    global String Comments__c;
    global String Priority__c;
    global String Status__c;
    global String Platform__c;
    global String Support_Type__c;
    global User Assigned_To__r;
    global Id Assigned_To__c;
    global Date Completed_Date__c;
    global String Primary_Department__c;
    global Salesforce_Support__c Parent_Ticket__r;
    global Id Parent_Ticket__c;
    global String Level_of_Effort__c;
    global String Delivery_Team__c;
    global String Percentage_Complete__c;
    global Date Build_Start_Date__c;
    global Date Build_End_Date__c;
    global User Syngenta_Contact__r;
    global Id Syngenta_Contact__c;
    global Date Release_Date__c;
    global Double Release_Priority__c;
    global String Project__c;
    global String Communication_Details__c;
    global String Testing_Details__c;
    global String Value__c;
    global Double Estimated_Hours__c;
    /* Release that the Salesforce Feedback will be included in.
    */
    global Release__c Release_1__r;
    /* Release that the Salesforce Feedback will be included in.
    */
    global Id Release_1__c;
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
    global List<Salesforce_Support__Feed> Feeds;
    global List<Salesforce_Support__History> Histories;
    global List<Salesforce_Support__Share> Shares;
    global List<Salesforce_Support__c> Salesforce_Support__r;
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

    global Salesforce_Support__c () 
    {
    }
}