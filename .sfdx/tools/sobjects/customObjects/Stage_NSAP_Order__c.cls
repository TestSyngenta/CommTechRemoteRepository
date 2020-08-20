// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Stage_NSAP_Order__c {
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
    global String BILL_BLOCK__c;
    global String COST_CENTER__c;
    global String DLV_BLOCK__c;
    global String INT_ORDER_NUMBER__c;
    global String MW_DATETIME__c;
    global String MW_PROC_STATUS__c;
    global String ORDER_REASON__c;
    global String ORDER_TYPE__c;
    global String PO_NUMBER__c;
    global String PRODUCT_NO__c;
    global String PRODUCT_QTY__c;
    global String PRODUCT_UOM__c;
    global String SALES_ORG__c;
    global String SHIPTO_ADDR__c;
    global String SHIPTO_CITY__c;
    global String SHIPTO_COUNTRY__c;
    global String SHIPTO_NAME__c;
    global String SHIPTO_NUMBER__c;
    global String SHIPTO_STATE__c;
    global String SHIPTO_ZIP__c;
    global String SOLDTO_ADDR__c;
    global String SOLDTO_CITY__c;
    global String SOLDTO_COUNTRY__c;
    global String SOLDTO_NAME__c;
    global String SOLDTO_NUMBER__c;
    global String SOLDTO_STATE__c;
    global String SOLDTO_ZIP__c;
    global String XTRA1_40__c;
    global String XTRA2_40__c;
    global String ZMSGTYPE__c;
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

    global Stage_NSAP_Order__c () 
    {
    }
}