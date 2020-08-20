// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Stage_NSAP_Order_Response__c {
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
    global String ERROR_MESSAGES__c;
    global String MW_DATETIME__c;
    global String MW_PROC_STATUS__c;
    global String ORDER_NUMBER__c;
    global String ORDER_STATUS__c;
    global String PO_NUMBER__c;
    global String XTRA1_100__c;
    global String XTRA2_100__c;
    global String ZERRMSG_COUNTER__c;
    global String ZERRMSG_ERRTYPE__c;
    global String ZERRMSG_JOBNM__c;
    global String ZERRMSG_LOGDATE__c;
    global String ZERRMSG_LOGTIME__c;
    global String ZERRMSG_MSGID__c;
    global String ZERRMSG_MSGNR__c;
    global String ZERRMSG_MSGTXT__c;
    global String ZERRMSG_MSGTYPE__c;
    global String ZERRMSG_MSGV1__c;
    global String ZERRMSG_MSGV2__c;
    global String ZERRMSG_MSGV3__c;
    global String ZERRMSG_MSGV4__c;
    global String ZERRMSG_UNIQUE_ID__c;
    global String ZERRMSG_USRKEY1__c;
    global String ZERRMSG_USRKEY2__c;
    global String ZERRMSG_USRKEY3__c;
    global String ZERRMSG_USRKEY4__c;
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

    global Stage_NSAP_Order_Response__c () 
    {
    }
}