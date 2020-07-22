// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SyngentaDSA__ContentReview__c {
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
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global Contact SyngentaDSA__ContactId__r;
    global Id SyngentaDSA__ContactId__c;
    global String SyngentaDSA__ContentId__c;
    global String SyngentaDSA__ContentLink__c;
    global String SyngentaDSA__ContentTitle__c;
    global Boolean SyngentaDSA__Document_Emailed__c;
    global Double SyngentaDSA__Geolocation__Latitude__s;
    global Double SyngentaDSA__Geolocation__Longitude__s;
    global Location SyngentaDSA__Geolocation__c;
    global String SyngentaDSA__PLaylist_Title__c;
    global String SyngentaDSA__Playlist_Id__c;
    global Double SyngentaDSA__Rating__c;
    global Double SyngentaDSA__TimeViewed__c;
    global String Brand__c;
    global String Region__c;
    global String Type__c;
    global String Year__c;
    global String User_District_Manager__c;
    global String User_Commercial_Unit__c;
    global String Title__c;
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
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global SyngentaDSA__ContentReview__c () 
    {
    }
}