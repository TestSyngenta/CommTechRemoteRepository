// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Converse_App_Action__c {
    global Id Id;
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
    global smagicinteract__Converse_App__c smagicinteract__Converse_App__r;
    global Id smagicinteract__Converse_App__c;
    global String smagicinteract__Automation_Key__c;
    global Datetime smagicinteract__End_Date__c;
    global smagicinteract__SMS_SenderId__c smagicinteract__Fallback_SenderId__r;
    global Id smagicinteract__Fallback_SenderId__c;
    global String smagicinteract__List_View_ID__c;
    global String smagicinteract__Message_App_Trigger_Name__c;
    global String smagicinteract__Message_App_Trigger__c;
    global Double smagicinteract__Message_Sequence__c;
    global String smagicinteract__Message_Text__c;
    global String smagicinteract__Mobile_Phone_Field__c;
    global String smagicinteract__Purpose__c;
    global Boolean smagicinteract__Respect_Subscription_Setting__c;
    global smagicinteract__SMS_Schedule__c smagicinteract__SMS_Schedule__r;
    global Id smagicinteract__SMS_Schedule__c;
    global smagicinteract__SMS_Template__c smagicinteract__SMS_Template__r;
    global Id smagicinteract__SMS_Template__c;
    global String smagicinteract__SenderIDSelectionCriteria__c;
    global String smagicinteract__SenderIDSelectionType__c;
    global Datetime smagicinteract__Start_Date__c;
    global String smagicinteract__Status__c;
    global String smagicinteract__Task_Owner_Criteria__c;
    global String smagicinteract__Template_Selection_Criteria__c;
    global String smagicinteract__Template_Selection_Type__c;
    global String smagicinteract__Trigger_URL__c;
    global String smagicinteract__Type__c;
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
    global List<smagicinteract__Conversation__c> smagicinteract__Conversations__r;
    global List<smagicinteract__Converse_App_Task__c> smagicinteract__Converse_App_Tasks__r;
    global List<smagicinteract__Incoming_SMS__c> smagicinteract__Incoming_SMS__r;
    global List<smagicinteract__Keyword_Action_Map__c> smagicinteract__KeywordActionMaps__r;
    global List<smagicinteract__smsMagic__c> smagicinteract__SMS_History__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__Converse_App_Action__c () 
    {
    }
}