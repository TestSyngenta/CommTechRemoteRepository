// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Stage_Channel_Account_SFDC__c {
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
    global String Acct_OwnerId__c;
    global String Acct_RecordType__c;
    global String BillingCity__c;
    global String BillingCountry__c;
    global String BillingPostalCode__c;
    global String BillingState__c;
    global String BillingStreet__c;
    global String CP_Territory__c;
    global String FAX__c;
    global String FND_ECC_ID__c;
    global String ICS_Code__c;
    global Boolean IsActive__c;
    global Boolean IsStillActive__c;
    global Boolean Migrated_Record__c;
    global String NSAP_ECC_ID__c;
    global String NSAP_EPA_Establishment__c;
    global Boolean NSAP_Has_Bulk_Tanks__c;
    global String Phone__c;
    global String SFDC_Account_ID__c;
    global String Seeds_Territory__c;
    global String ShippingCity__c;
    global String ShippingCountry__c;
    global String ShippingPostalCode__c;
    global String ShippingState__c;
    global String ShippingStreet__c;
    global String Territory__c;
    global String Type__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
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

    global Stage_Channel_Account_SFDC__c () 
    {
    }
}