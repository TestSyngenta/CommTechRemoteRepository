// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Conversation__c {
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
    global String smagicinteract__All_Mobile__c;
    global String smagicinteract__All_Sender__c;
    global Campaign smagicinteract__Campaign__r;
    global Id smagicinteract__Campaign__c;
    global Contact smagicinteract__Contact__r;
    global Id smagicinteract__Contact__c;
    global smagicinteract__Converse_App_Action__c smagicinteract__Converse_App_Action__r;
    global Id smagicinteract__Converse_App_Action__c;
    global smagicinteract__Converse_App__c smagicinteract__Converse_App__r;
    global Id smagicinteract__Converse_App__c;
    global String smagicinteract__Inbound_Number__c;
    global Boolean smagicinteract__Is_Case_Closed__c;
    global Boolean smagicinteract__Is_Lead_Converted__c;
    global Datetime smagicinteract__Last_Incoming_Time__c;
    global String smagicinteract__Last_Message_Direction__c;
    global String smagicinteract__Last_Message_Text__c;
    global Datetime smagicinteract__Last_Message_Time__c;
    global Datetime smagicinteract__Last_Outgoing_Time__c;
    global Lead smagicinteract__Lead__r;
    global Id smagicinteract__Lead__c;
    global String smagicinteract__Mobile_Number__c;
    global String smagicinteract__Mode__c;
    global Double smagicinteract__New_Count__c;
    global String smagicinteract__Object__c;
    global String smagicinteract__Opportunity_Stage__c;
    global String smagicinteract__Purpose__c;
    global smagicinteract__SMS_SenderId__c smagicinteract__Sender__r;
    global Id smagicinteract__Sender__c;
    global String smagicinteract__State__c;
    global Account smagicinteract__account__r;
    global Id smagicinteract__account__c;
    global Case smagicinteract__case__r;
    global Id smagicinteract__case__c;
    global Boolean smagicinteract__isUnread__c;
    global Opportunity smagicinteract__opportunity__r;
    global Id smagicinteract__opportunity__c;
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
    global List<smagicinteract__Conversation_Intent_Map__c> smagicinteract__Conversation_Intent_Map__r;
    global List<smagicinteract__Conversation_Recipient_Map__c> smagicinteract__Conversation_Recipient_Map__r;
    global List<smagicinteract__Conversation_Sender_Map__c> smagicinteract__Conversation_Sender_Map__r;
    global List<smagicinteract__Conversation__Feed> Feeds;
    global List<smagicinteract__Incoming_SMS__c> smagicinteract__Incoming_SMS__r;
    global List<smagicinteract__Internal_Notes__c> smagicinteract__Internal_Notes__r;
    global List<smagicinteract__smsMagic__c> smagicinteract__SMS_History__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__Conversation__c () 
    {
    }
}