// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__smsMagic__c {
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
    global Account smagicinteract__Account__r;
    global Id smagicinteract__Account__c;
    global Campaign smagicinteract__Campaign__r;
    global Id smagicinteract__Campaign__c;
    global Case smagicinteract__Case__r;
    global Id smagicinteract__Case__c;
    global Contact smagicinteract__Contact__r;
    global Id smagicinteract__Contact__c;
    global String smagicinteract__Country__c;
    global Datetime smagicinteract__CreatedOn__c;
    global String smagicinteract__Delivery_Error_Message__c;
    global Boolean smagicinteract__Favourite__c;
    global Boolean smagicinteract__Is_Text_Unicode__c;
    global Lead smagicinteract__Lead__r;
    global Id smagicinteract__Lead__c;
    global String smagicinteract__MMS_Subject__c;
    global String smagicinteract__Message_Type__c;
    global String smagicinteract__Name__c;
    global String smagicinteract__ObjectType__c;
    global Opportunity smagicinteract__Opportunity__r;
    global Id smagicinteract__Opportunity__c;
    global String smagicinteract__PhoneNumber__c;
    global String smagicinteract__SMSText__c;
    global Double smagicinteract__SMS_Credits__c;
    global smagicinteract__SMS_Template__c smagicinteract__SMS_Template__r;
    global Id smagicinteract__SMS_Template__c;
    global String smagicinteract__SenderId__c;
    global User smagicinteract__Sent_By__r;
    global Id smagicinteract__Sent_By__c;
    global Datetime smagicinteract__Sent_On__c;
    global String smagicinteract__Source__c;
    global String smagicinteract__Type__c;
    global String smagicinteract__Unformatted_Phone_Number__c;
    global String smagicinteract__Use_Default_Sender__c;
    global User smagicinteract__User__r;
    global Id smagicinteract__User__c;
    global String smagicinteract__deliveryStatus__c;
    global Double smagicinteract__disableSMSOnTrigger__c;
    global String smagicinteract__external_field__c;
    global String smagicinteract__response__c;
    global String smagicinteract__sentStatus__c;
    global String smagicinteract__statusMessage__c;
    global smagicinteract__Conversation__c smagicinteract__Conversation__r;
    global Id smagicinteract__Conversation__c;
    global smagicinteract__Converse_App_Action__c smagicinteract__Converse_App_Action__r;
    global Id smagicinteract__Converse_App_Action__c;
    global smagicinteract__Converse_App_Task__c smagicinteract__Converse_App_Task__r;
    global Id smagicinteract__Converse_App_Task__c;
    global smagicinteract__Converse_App__c smagicinteract__Converse_App__r;
    global Id smagicinteract__Converse_App__c;
    global String smagicinteract__Direction__c;
    global Boolean smagicinteract__New__c;
    global smagicinteract__smsMagic__c smagicinteract__Previous_Message__r;
    global Id smagicinteract__Previous_Message__c;
    global String smagicinteract__Status__c;
    global String Campaign_ID_from_outgoing__c;
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
    global List<smagicinteract__Converse_App_Task__c> smagicinteract__Converse_App_Tasks__r;
    global List<smagicinteract__Incoming_SMS__c> Incoming_SMS__r;
    global List<smagicinteract__Incoming_SMS__c> smagicinteract__Incoming_SMS__r;
    global List<smagicinteract__MMS_Detail__c> smagicinteract__MMS_Details__r;
    global List<smagicinteract__Message_Action__c> smagicinteract__Message_Actions__r;
    global List<smagicinteract__smsMagic__History> Histories;
    global List<smagicinteract__smsMagic__c> smagicinteract__SMS_History__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global smagicinteract__smsMagic__c () 
    {
    }
}