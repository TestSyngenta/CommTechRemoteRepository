// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Channel_Sales__c {
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
    global String Currency__c;
    global String ExternalKey__c;
    global Double Gross_Sales__c;
    global Date Invoice_Date__c;
    global String Invoice_Number__c;
    global Double Net_Sales__c;
    global Date Posting_Date__c;
    global Product2 Product__r;
    global Id Product__c;
    global Double Quantity__c;
    global String Sales_Org__c;
    global Account Ship_To_Customer__r;
    global Id Ship_To_Customer__c;
    global Account Sold_To_Customer__r;
    global Id Sold_To_Customer__c;
    global Double Quantity_Field_UOM__c;
    global String Version__c;
    global Double Quantity_Min_Saleable_UOM__c;
    global String Ship_To_Customer_NSAP_ID__c;
    global String Sold_To_Customer_NSAP_ID__c;
    global Double Invoice_Date_Year__c;
    global Date Seeds_Order_Date__c;
    global Date Seeds_Min_Invoice_Date__c;
    global Date Seeds_Max_Invoice_Date__c;
    global String Seeds_Billing_Doc_Number__c;
    global String Seeds_Order_Doc_Number__c;
    global String Seeds_Order_Type__c;
    global Date Program_Date__c;
    global Double Seeds_Order_Quantity__c;
    global Double Seeds_Order_Gross_Sales__c;
    global Double Seeds_Order_Net_Sales__c;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Channel_Sales__Share> Shares;
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

    global Channel_Sales__c () 
    {
    }
}