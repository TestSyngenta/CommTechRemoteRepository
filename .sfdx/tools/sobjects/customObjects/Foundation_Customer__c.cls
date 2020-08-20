// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Foundation_Customer__c {
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
    global String City__c;
    global String Email__c;
    global String Fax__c;
    global String Foundation_ID__c;
    global String ICS_ID__c;
    global String Phone__c;
    global String Postal_Code__c;
    global String Province__c;
    global String SSA__c;
    global Account Salesforce_Account__r;
    global Id Salesforce_Account__c;
    global String Secondary_Phone__c;
    global String Street_Address__c;
    global String TSA__c;
    global Foundation_Customer__c Winning_Foundation_Customer__r;
    global Id Winning_Foundation_Customer__c;
    global String Account_Street__c;
    global String Account_City__c;
    global String Account_Province__c;
    global String Account_Postal_Code__c;
    global String Account_Phone__c;
    global String Account_Fax__c;
    global Boolean Reviewed__c;
    global Boolean SSA_Submitted__c;
    global Date SSA_Submitted_Date__c;
    global Account Retailer__r;
    global Id Retailer__c;
    global Contact Retailer_Contact__r;
    global Id Retailer_Contact__c;
    global String Retailer_Email__c;
    global String Retailer_City__c;
    global String Retailer_ID__c;
    global Boolean Form_Attached__c;
    global String SSA_Version__c;
    global String Retailer_Match_City__c;
    global String Retailer_Match_Fax__c;
    global String Retailer_Match_Phone__c;
    global String Retailer_Match_Postal_Code__c;
    global String Retailer_Match_Prov__c;
    global String Retailer_Match_Street__c;
    global Account Salesforce_Retailer_Account__r;
    global Id Salesforce_Retailer_Account__c;
    global Boolean Deleted_in_Foundation__c;
    global List<Account> Accounts__r;
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
    global List<Foundation_Customer__History> Histories;
    global List<Foundation_Customer__Share> Shares;
    global List<Foundation_Customer__c> Foundation_Customers__r;
    global List<NetworkActivityAudit> ParentEntities;
    global List<NetworkUserHistoryRecent> NetworkUserHistoryRecentToRecord;
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
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global Foundation_Customer__c () 
    {
    }
}