// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SyngentaDSA__CategoryMobileConfig__c {
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
    global String SyngentaDSA__Button_Text_Align__c;
    global String SyngentaDSA__CategoryBundleId__c;
    global SyngentaDSA__Category__c SyngentaDSA__CategoryId__r;
    global Id SyngentaDSA__CategoryId__c;
    global String SyngentaDSA__ContentAttachmentId__c;
    global String SyngentaDSA__ContentOverAttachmentId__c;
    global String SyngentaDSA__GalleryHeadingTextColor__c;
    global String SyngentaDSA__GalleryHeadingText__c;
    global Boolean SyngentaDSA__IsDefault__c;
    global Boolean SyngentaDSA__IsDraft__c;
    global String SyngentaDSA__LandscapeAttachmentId__c;
    global Double SyngentaDSA__LandscapeX__c;
    global Double SyngentaDSA__LandscapeY__c;
    global String SyngentaDSA__MAC_in_Edit__c;
    global SyngentaDSA__MobileAppConfig__c SyngentaDSA__MobileAppConfigurationId__r;
    global Id SyngentaDSA__MobileAppConfigurationId__c;
    global Double SyngentaDSA__OverlayBgAlpha__c;
    global String SyngentaDSA__OverlayBgColor__c;
    global String SyngentaDSA__OverlayTextColor__c;
    global String SyngentaDSA__PortraitAttachmentId__c;
    global Double SyngentaDSA__PortraitX__c;
    global Double SyngentaDSA__PortraitY__c;
    global String SyngentaDSA__Sub_Category_Background_Color__c;
    global SyngentaDSA__Category__c SyngentaDSA__Top_Level_Category__r;
    global Id SyngentaDSA__Top_Level_Category__c;
    global Boolean SyngentaDSA__UseCategoryBundle__c;
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

    global SyngentaDSA__CategoryMobileConfig__c () 
    {
    }
}