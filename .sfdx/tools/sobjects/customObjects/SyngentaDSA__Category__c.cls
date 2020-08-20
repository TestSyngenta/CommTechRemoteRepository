// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SyngentaDSA__Category__c {
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
    global String SyngentaDSA__GalleryAttachmentId__c;
    global Double SyngentaDSA__Is_Parent_Category__c;
    global Boolean SyngentaDSA__Is_Parent__c;
    global Double SyngentaDSA__Is_Top_Level__c;
    global String SyngentaDSA__Language__c;
    global Double SyngentaDSA__Order__c;
    global SyngentaDSA__Category__c SyngentaDSA__Parent_Category__r;
    global Id SyngentaDSA__Parent_Category__c;
    global Boolean SyngentaDSA__Todays_Special__c;
    global Boolean SyngentaDSA__Hide_Category_Name__c;
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
    global List<NetworkActivityAudit> ParentEntities;
    global List<NetworkUserHistoryRecent> NetworkUserHistoryRecentToRecord;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<SurveySubject> SurveySubjectEntities;
    global List<SyngentaDSA__Cat_Content_Junction__c> SyngentaDSA__Cat_Content_Junction__r;
    global List<SyngentaDSA__CategoryMobileConfig__c> SyngentaDSA__Category_Mobile_Configurations__r;
    global List<SyngentaDSA__CategoryMobileConfig__c> SyngentaDSA__Category_Mobile_Configurations1__r;
    global List<SyngentaDSA__Category__Share> Shares;
    global List<SyngentaDSA__Category__c> SyngentaDSA__SubCategories__r;
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

    global SyngentaDSA__Category__c () 
    {
    }
}