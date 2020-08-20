// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Business_Plan__c {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
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
    global Account Account__r;
    global Id Account__c;
    global String Country__c;
    global Boolean Lock_Business_Plan__c;
    global Territory__c Territory__r;
    global Id Territory__c;
    global String Unique_key__c;
    global String Year__c;
    global String CropAcreage__c;
    global String CropProtectionPlans__c;
    global String Implications__c;
    global String MutualGoals__c;
    global String Owner_Name__c;
    global String RecordType__c;
    global String RetailerChallenges__c;
    global String RetailerGoals__c;
    global String RetailerOpportunities__c;
    global String RetailerShareofSyngentaSales__c;
    global String SoybeanSeedPlans__c;
    global String SyngentaChallenges__c;
    global String SyngentaCompetitiveness__c;
    global String SyngentaGoals__c;
    global String SyngentaMarketSharevsCompetitors__c;
    global String SyngentaOpportunities__c;
    global String SyngentaShareofShelfatRetailer__c;
    global String UseIntensity__c;
    global String Grower_Challenges__c;
    global String Grower_Goals__c;
    global String Grower_Opportunities__c;
    global Boolean Retailer_is_Parent__c;
    /* Description of the business (Crop / Livestock – what pays the bills? Other businesses operating – elevator, custom work, trucking, value chain, coffee roaster, commercial seed cleaning and treating)
    */
    global String Farm_Business_Dynamics__c;
    /* Long term aspirations of the business
    */
    global String Long_Term_Farm_Goals__c;
    /* Description of the people in the business:Decision Maker(s).  Relationship to each other, Succession Plan
    */
    global String Farm_People_Dynamics__c;
    global String Account_Name__c;
    global String DiSC_style_of_Main_Contact__c;
    global Double Number_Of_Full_Time_Employees__c;
    global Double Number_Of_Seasonal_Employees__c;
    /* Who/What else influences the grower’s decision making? Agronomist, retailer. Provide Name, follow on social media
    */
    global Double External_Influencers__c;
    /* What are the goals of the farm for the coming year?
    */
    global String Current_Status_Of_The_Farm__c;
    /* What is our share of the farm business? Which competitors are on the farm and what is their share and in which category?
    */
    global String Syngenta_Share_vs_Competitor__c;
    /* What are the opportunities for Syngenta to increase our value?
Information, Products, Business support.
    */
    global String Syngenta_Opportunities__c;
    /* What does/could stand in our way?
    */
    global String Syngenta_Challenges__c;
    global String Maintenance_Upsell_Products__c;
    global String Maintenance_Products__c;
    global List<Activities__c> Activities__r;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Business_Plan__History> Histories;
    global List<Business_Plan__Share> Shares;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<FinancialCommitments__c> Financial_Commitments__r;
    global List<Key_Growers__c> Key_Growers__r;
    global List<NetworkActivityAudit> ParentEntities;
    global List<NetworkUserHistoryRecent> NetworkUserHistoryRecentToRecord;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<Opportunity> Opportunities__r;
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

    global Business_Plan__c () 
    {
    }
}