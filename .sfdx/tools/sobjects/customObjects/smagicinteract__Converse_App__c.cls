// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Converse_App__c {
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
    global Double smagicinteract__Action_Count__c;
    global Datetime smagicinteract__End_Date__c;
    global String smagicinteract__ErrorMessages__c;
    global Boolean smagicinteract__ErrorState__c;
    global String smagicinteract__Object__c;
    global User smagicinteract__Owner__r;
    global Id smagicinteract__Owner__c;
    global String smagicinteract__PrimaryType__c;
    global String smagicinteract__Purpose__c;
    global Datetime smagicinteract__Start_Date__c;
    global String smagicinteract__Status__c;
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
    global List<smagicinteract__Converse_App_Action__c> smagicinteract__Converse_App_Action__r;
    global List<smagicinteract__Converse_App_Template_Map__c> smagicinteract__Converse_App_Template_Maps__r;
    global List<smagicinteract__Converse_App_User_Map__c> smagicinteract__Converse_App_User_Maps__r;
    global List<smagicinteract__Incoming_SMS__c> smagicinteract__Incoming_SMS__r;
    global List<smagicinteract__smsMagic__c> smagicinteract__SMS_History__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__Converse_App__c () 
    {
    }
}