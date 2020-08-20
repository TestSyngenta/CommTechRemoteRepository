// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Message_Object_Config__c {
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
    global String smagicinteract__Name_Field__c;
    global String smagicinteract__Object_Name__c;
    global String smagicinteract__Opt_Out_Field_Value__c;
    global String smagicinteract__Opt_Out_Field__c;
    global String smagicinteract__Opt_Out_Operator__c;
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
    global List<smagicinteract__Action_Object__c> smagicinteract__Action_Objects__r;
    global List<smagicinteract__Child_Object_Config__c> smagicinteract__Child_Object_Configs__r;
    global List<smagicinteract__Conversation_Related_Objects__c> smagicinteract__Conversation_Related_Objects__r;
    global List<smagicinteract__Converse_Desk_User_Config__c> smagicinteract__Converse_Desk_User_Configs__r;
    global List<smagicinteract__Keyword_Action_Config__c> smagicinteract__Keyword_Action_Configs__r;
    global List<smagicinteract__Message_Object_Config__History> Histories;
    global List<smagicinteract__Object_Field_Config__c> smagicinteract__Object_Message_Config__r;
    global List<smagicinteract__Object_Metadata_Config__c> smagicinteract__Object_Metadata_Config__r;
    global List<smagicinteract__Unrelated_Object_Config__c> smagicinteract__Unrelated_Object_Configs__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__Message_Object_Config__c () 
    {
    }
}