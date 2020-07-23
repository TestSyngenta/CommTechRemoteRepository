// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class wint__Website_Account__c {
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
    global String wint__Account2Name__c;
    global String wint__AccountName__c;
    /* If checked then system will allow changing Email of related Website Accounts.
    */
    global Boolean wint__AllowEmailChange__c;
    global Boolean wint__Alternative_Condition_Met__c;
    global String wint__Any01__c;
    global String wint__Any02__c;
    /* Any data stored as JSON object.
    */
    global String wint__Any__c;
    global String wint__BusinessType__c;
    global String wint__Campaign__c;
    global String wint__City__c;
    global String wint__Company2__c;
    global String wint__CompanyNumber__c;
    global String wint__Company__c;
    global String wint__Contact2MatchingKey2__c;
    global String wint__Contact2MatchingKey__c;
    global String wint__Contact2_Lead2_Key__c;
    global Contact wint__Contact2__r;
    global Id wint__Contact2__c;
    global String wint__ContactCertificationNumber__c;
    global String wint__ContactMatchingKey2__c;
    global String wint__ContactMatchingKey__c;
    global String wint__ContactPreferences__c;
    global String wint__Contact_Lead_Key__c;
    global Contact wint__Contact__r;
    global Id wint__Contact__c;
    global String wint__Country__c;
    global String wint__CustomerGroup__c;
    global String wint__CustomerType2__c;
    global String wint__CustomerType__c;
    global Boolean wint__DeletedInSource__c;
    global Boolean wint__DoNotCall__c;
    global Boolean wint__DoNotPull__c;
    global String wint__Email__c;
    global String wint__FarmBusinessType__c;
    global String wint__FarmName__c;
    global String wint__FarmSize__c;
    global String wint__Fax2__c;
    global String wint__Fax__c;
    global String wint__FirstName2__c;
    global String wint__FirstName__c;
    global Boolean wint__HasOptedOutOfEmail__c;
    global Boolean wint__HasOptedOutOfFax__c;
    global Boolean wint__HasOptedOutOfMobile__c;
    global String wint__Individual2MatchingKey__c;
    global Individual wint__Individual2__r;
    global Id wint__Individual2__c;
    global String wint__IndividualMatchingKey__c;
    global Individual wint__Individual__r;
    global Id wint__Individual__c;
    global User wint__LastModifiedInSFDCBy__r;
    global Id wint__LastModifiedInSFDCBy__c;
    global Datetime wint__LastModifiedInSFDC__c;
    global String wint__LastName2__c;
    global String wint__LastName__c;
    global String wint__Lead2MatchingKey2__c;
    global String wint__Lead2MatchingKey__c;
    global Lead wint__Lead2__r;
    global Id wint__Lead2__c;
    global String wint__LeadMatchingKey2__c;
    global String wint__LeadMatchingKey__c;
    global Lead wint__Lead__r;
    global Id wint__Lead__c;
    global Boolean wint__LegalAgreementsAccepted__c;
    global String wint__MobilePhone2__c;
    global String wint__MobilePhone__c;
    global String wint__OtherEmail2__c;
    global String wint__OtherEmail__c;
    global Datetime wint__PP_Accepted__c;
    global String wint__Phone2__c;
    global String wint__Phone__c;
    global String wint__PostalCode__c;
    global String wint__PreferredStore__c;
    global String wint__ReferenceNo__c;
    global String wint__Roles__c;
    global String wint__Salutation2__c;
    global String wint__Salutation__c;
    global String wint__State__c;
    global String wint__Status__c;
    global String wint__Street2__c;
    global String wint__Street__c;
    global String wint__Subscriptions_staging__c;
    global Datetime wint__TC_Accepted__c;
    global String wint__Title2__c;
    global String wint__Title__c;
    global String wint__Unique_Key__c;
    global String wint__UserID__c;
    global wint__Website__c wint__Website_Lookup__r;
    global Id wint__Website_Lookup__c;
    global String wint__Website_Matching_Key__c;
    global String wint__Website__c;
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
    global List<wint__Website_Account_Biopotential__c> wint__Website_Account_Biopotentials__r;
    global List<wint__Website_Account_Subscription__c> wint__Website_Account_Subscriptions__r;
    global List<wint__Website_Account__History> Histories;
    global List<wint__Website_Account__Share> Shares;
    global List<wint__Website_Anonymous_Submission__c> wint__Website_Anonymous_Submission__r;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global wint__Website_Account__c () 
    {
    }
}