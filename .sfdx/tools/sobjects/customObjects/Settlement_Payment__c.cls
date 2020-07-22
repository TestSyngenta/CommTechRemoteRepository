// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Settlement_Payment__c {
    global Id Id;
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
    global Cheque_Run__c Cheque_Run__r;
    global Id Cheque_Run__c;
    global Account Account__r;
    global Id Account__c;
    global Decimal Amount__c;
    global Case Case__r;
    global Id Case__c;
    global String Pay_To_Name__c;
    global String Pay_To__c;
    global Account Purchased_From_Account__r;
    global Id Purchased_From_Account__c;
    global String Send_To_City__c;
    global String Send_To_Name__c;
    global String Send_To_Postal_Code__c;
    global String Send_To_Province__c;
    global String Send_To_Street__c;
    global String Status__c;
    global String Type__c;
    global String District__c;
    global String Pay_To_City__c;
    global String Pay_To_Postal_Code__c;
    global String Pay_To_Province__c;
    global String Pay_To_Street__c;
    global String Program_Name__c;
    global String Rep_Email__c;
    global String Rep_Name__c;
    global String Rep_Number__c;
    global String Rep_Phone_No__c;
    global String Rep_Title__c;
    global String Send_To__c;
    /* When this value is changed, it will trigger an update to the associated Settlements with the Cheque Information
    */
    global String Cheque_Number__c;
    global String Cheque_Status__c;
    global Date Date_Cheque_Cashed__c;
    global Date Date_Settlement_Issued__c;
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
    global List<Settlement__c> Settlements__r;
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

    global Settlement_Payment__c () 
    {
    }
}