// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Territory__c {
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
    global User Assigned_Rep__r;
    global Id Assigned_Rep__c;
    global Boolean Migrated_Record__c;
    global String Description__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global Boolean Inactive__c;
    global String Sales_Org__c;
    global String Sales_Org_Description__c;
    global String Territory_Map__c;
    global String Map_Id__c;
    /* to store the CU of the respective territory  (will be blank for CU records)
    */
    global Territory__c CommercialUnit__r;
    /* to store the CU of the respective territory  (will be blank for CU records)
    */
    global Id CommercialUnit__c;
    /* to store the district of the respective territory (will be blank for District & CU records)
    */
    global Territory__c District__r;
    /* to store the district of the respective territory (will be blank for District & CU records)
    */
    global Id District__c;
    global String TerritoryLevel__c;
    global List<Account> Territory__r;
    global List<Account_Snapshot__c> Account_Historical_Details__r;
    global List<Account_Territory__c> Account_Territories__r;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Business_Plan__c> Business_Plans__r;
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
    global List<Opportunity> Opportunities1__r;
    global List<Opportunity> Opportunities__r;
    global List<OpportunityLineItem> Opportunity_Product__r;
    global List<OpportunityLineItem> Opportunity_Product1__r;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Sales_Plan_Actual__c> Sales_Plan_Actual__r;
    global List<SeedsAllocation__c> SeedsAllocations__r;
    global List<SurveySubject> SurveySubjectEntities;
    global List<TaskRelation> TaskRelations;
    global List<Territory__History> Histories;
    global List<Territory__c> Territories1__r;
    global List<Territory__c> Territories__r;
    global List<TopicAssignment> TopicAssignments;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global Territory__c () 
    {
    }
}