// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SocialPost {
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
    global Case Parent;
    global Id ParentId;
    global SocialPersona Persona;
    global Id PersonaId;
    global SObject Who;
    global Id WhoId;
    global String Headline;
    global String Content;
    global Datetime Posted;
    global String PostUrl;
    global String Provider;
    global String Handle;
    global String LikedBy;
    global Double AnalyzerScore;
    global String Language;
    global Double ReviewScore;
    global Double ReviewScale;
    global User HiddenBy;
    global Id HiddenById;
    global String Notes;
    global String TruncatedContent;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Case> Cases;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<LinkedArticle> LinkedArticles;
    global List<NetworkActivityAudit> ParentEntities;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<SocialPersona> Personas;
    global List<SocialPostFeed> Feeds;
    global List<SocialPostHistory> Histories;
    global List<CaseChangeEvent> Source;
    global List<ContentVersion> FirstPublishLocation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;

    global SocialPost () 
    {
    }
}