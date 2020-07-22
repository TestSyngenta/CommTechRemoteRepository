// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Survey {
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
    global Integer TotalVersionsCount;
    global String DeveloperName;
    global String Description;
    global SurveyVersion ActiveVersion;
    global Id ActiveVersionId;
    global String SurveyType;
    global SurveyVersion LatestVersion;
    global Id LatestVersionId;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<SurveyFeed> Feeds;
    global List<SurveyInvitation> SurveyInvitations;
    global List<SurveyQuestionScore> SurveyQuestionScores;
    global List<SurveyResponse> SurveyResponses;
    global List<SurveySubject> SurveySubjects;
    global List<SurveyVersion> SurveyVersions;
    global List<TopicAssignment> TopicAssignments;
    global List<ContentVersion> FirstPublishLocation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;

    global Survey () 
    {
    }
}