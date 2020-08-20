// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Incoming_SMS__c {
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
    global Campaign smagicinteract__Campaign__r;
    global Id smagicinteract__Campaign__c;
    global Case smagicinteract__Case__r;
    global Id smagicinteract__Case__c;
    global Contact smagicinteract__Contact__r;
    global Id smagicinteract__Contact__c;
    global Boolean smagicinteract__Favourite__c;
    global String smagicinteract__Inbound_Number__c;
    global Lead smagicinteract__Lead__r;
    global Id smagicinteract__Lead__c;
    global String smagicinteract__MMS_Type__c;
    global String smagicinteract__MMS_Url__c;
    global String smagicinteract__Mobile_Number__c;
    global Boolean smagicinteract__New__c;
    global String smagicinteract__Quick_Reply_URL__c;
    global String smagicinteract__SMS_Text__c;
    global User smagicinteract__Sent_By__r;
    global Id smagicinteract__Sent_By__c;
    global User smagicinteract__User__r;
    global Id smagicinteract__User__c;
    global String smagicinteract__actionTaken__c;
    global String smagicinteract__external_field__c;
    global String smagicinteract__taskId__c;
    global smagicinteract__smsMagic__c SMS_History__r;
    global Id SMS_History__c;
    global String Campaign_ID_from_outgoing__c;
    global smagicinteract__Conversation__c smagicinteract__Conversation__r;
    global Id smagicinteract__Conversation__c;
    global smagicinteract__Converse_App_Action__c smagicinteract__Converse_App_Action__r;
    global Id smagicinteract__Converse_App_Action__c;
    global smagicinteract__Converse_App_Task__c smagicinteract__Converse_App_Task__r;
    global Id smagicinteract__Converse_App_Task__c;
    global smagicinteract__Converse_App__c smagicinteract__Converse_App__r;
    global Id smagicinteract__Converse_App__c;
    global String smagicinteract__Mobile_Number_without_ISD_Code__c;
    global String smagicinteract__ObjectType__c;
    global smagicinteract__smsMagic__c smagicinteract__outgoing_sms__r;
    global Id smagicinteract__outgoing_sms__c;
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
    global List<smagicinteract__Converse_App_Task__c> smagicinteract__Converse_App_Tasks__r;
    global List<smagicinteract__Incoming_MMS_Detail__c> smagicinteract__Incoming_MMS_Details__r;
    global List<smagicinteract__Message_Action__c> smagicinteract__Message_Actions__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__Incoming_SMS__c () 
    {
    }
}