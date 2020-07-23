// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Converse_App_Task__c {
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
    global String smagicinteract__Automation_Key_Reference__c;
    global Contact smagicinteract__Contact__r;
    global Id smagicinteract__Contact__c;
    global smagicinteract__Converse_App_Action__c smagicinteract__Converse_App_Action__r;
    global Id smagicinteract__Converse_App_Action__c;
    global Boolean smagicinteract__Enable_Duplicate_Check__c;
    global String smagicinteract__ErrorMessages__c;
    global String smagicinteract__Event_Id__c;
    global smagicinteract__Incoming_SMS__c smagicinteract__Incoming_SMS__r;
    global Id smagicinteract__Incoming_SMS__c;
    global Lead smagicinteract__Lead__r;
    global Id smagicinteract__Lead__c;
    global smagicinteract__smsMagic__c smagicinteract__SMS_History__r;
    global Id smagicinteract__SMS_History__c;
    global String smagicinteract__Status__c;
    global String smagicinteract__Task_Id__c;
    global smagicinteract__SMS_Template__c smagicinteract__Template__r;
    global Id smagicinteract__Template__c;
    global String smagicinteract__Type__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<EventRelation> EventRelations;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<SurveySubject> SurveySubjectEntities;
    global List<TaskRelation> TaskRelations;
    global List<TopicAssignment> TopicAssignments;
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

    global smagicinteract__Converse_App_Task__c () 
    {
    }
}