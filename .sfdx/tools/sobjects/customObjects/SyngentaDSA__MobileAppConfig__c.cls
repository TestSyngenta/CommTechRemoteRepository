// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SyngentaDSA__MobileAppConfig__c {
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
    global Boolean SyngentaDSA__Active__c;
    global String SyngentaDSA__ButtonDefaultAttachmentId__c;
    global String SyngentaDSA__ButtonHighlightAttachmentId__c;
    global String SyngentaDSA__ButtonHighlightTextColor__c;
    global Double SyngentaDSA__ButtonTextAlpha__c;
    global String SyngentaDSA__ButtonTextColor__c;
    global Boolean SyngentaDSA__Check_In_Enabled__c;
    global Double SyngentaDSA__IntroTextAlpha__c;
    global String SyngentaDSA__IntroTextColor__c;
    global String SyngentaDSA__IntroText__c;
    global String SyngentaDSA__LandscapeAttachmentId__c;
    global String SyngentaDSA__Language__c;
    global String SyngentaDSA__LinkToEditor__c;
    global String SyngentaDSA__LogoAttachmentId__c;
    global String SyngentaDSA__PortraitAttachmentId__c;
    global String SyngentaDSA__ProfileText__c;
    global String SyngentaDSA__Profile_Names__c;
    global String SyngentaDSA__Profiles__c;
    global String SyngentaDSA__Report_an_Issue__c;
    global Double SyngentaDSA__TitleBgAlpha__c;
    global String SyngentaDSA__TitleBgColor__c;
    global Double SyngentaDSA__TitleTextAlpha__c;
    global String SyngentaDSA__TitleTextColor__c;
    global String SyngentaDSA__TitleText__c;
    global Boolean SyngentaDSA__inEdit__c;
    global String SyngentaDSA__MAC_Locale__c;
    global String SyngentaDSA__Mac_Locale_Multi__c;
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
    global List<SyngentaDSA__CategoryMobileConfig__c> SyngentaDSA__Category_Mobile_Configurations__r;
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

    global SyngentaDSA__MobileAppConfig__c () 
    {
    }
}