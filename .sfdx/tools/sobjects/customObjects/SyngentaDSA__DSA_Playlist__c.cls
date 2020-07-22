// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SyngentaDSA__DSA_Playlist__c {
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
    global String SyngentaDSA__Description__c;
    global Boolean SyngentaDSA__External_Approved__c;
    global Boolean SyngentaDSA__IsFeatured__c;
    /* ISO language code
    */
    global String SyngentaDSA__Language_Code__c;
    global String SyngentaDSA__Language__c;
    global String SyngentaDSA__Large_Image_URL__c;
    global Double SyngentaDSA__Order__c;
    global String SyngentaDSA__Query__c;
    /* If checked, then this Playlist will be shared with all internal users
    */
    global Boolean SyngentaDSA__Shared_Internally__c;
    global String SyngentaDSA__Small_Image_URL__c;
    global Boolean SyngentaDSA__Public__c;
    global String SyngentaDSA__User_Country_Playlist__c;
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
    global List<SyngentaDSA__DSA_Playlist__Feed> Feeds;
    global List<SyngentaDSA__Playlist_Content_Junction__c> SyngentaDSA__Playlist_Content_Junctions__r;
    global List<SyngentaDSA__Playlist_Subscription__c> SyngentaDSA__Playlist_Subscriptions__r;
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

    global SyngentaDSA__DSA_Playlist__c () 
    {
    }
}