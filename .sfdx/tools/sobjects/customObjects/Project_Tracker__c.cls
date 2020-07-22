// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Project_Tracker__c {
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
    global Decimal Actual_Budget__c;
    global String Brands__c;
    global String Budget_Notes__c;
    global String Budget_Status__c;
    global String Budget_Year__c;
    global String Commercial_Unit__c;
    global String Cost_Centres__c;
    global String Crops__c;
    global String Customer_Type__c;
    global String Description__c;
    global Date In_Field_End_Date__c;
    global Date In_Field_Start_Date__c;
    global String KPI__c;
    global Date Kick_Off_Date__c;
    global Boolean Trinity__c;
    global Boolean Legal_Required__c;
    global String Micromarkets__c;
    global String Objective__c;
    global Project_Tracker__c Parent_Project__r;
    global Id Parent_Project__c;
    global String Parent_Team__c;
    global Decimal Planned_Budget__c;
    global User Project_Manager__r;
    global Id Project_Manager__c;
    global String Project_Name__c;
    global String Project_Number__c;
    global String Project_Status__c;
    global Campaign Related_Campaign__r;
    global Id Related_Campaign__c;
    global Date Required_Date__c;
    global String Status_Actions_del__c;
    global String Team__c;
    global String Type__c;
    global String Vendors__c;
    global String Weekly_Status_Update__c;
    global String Weekly_Status__c;
    global String In_Field_Year__c;
    global Boolean French_Required__c;
    global Boolean DSA__c;
    global String Link_to_Trinity__c;
    global String Link_to_DSA__c;
    global String Link_to_Collateral_Centre__c;
    global Boolean Approved_by_Legal__c;
    global Date Sent_to_Legal_Date__c;
    global Date Appoved_by_Legal_Date__c;
    global Boolean Collateral_Centre__c;
    global User Customer_Marketing_Lead__r;
    global Id Customer_Marketing_Lead__c;
    global String Campaign_Year__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Budget_Tracker__c> Budget_Tracker__r;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<LookedUpFromActivity> Activities__r;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Project_Tracker__Feed> Feeds;
    global List<Project_Tracker__History> Histories;
    global List<Project_Tracker__Share> Shares;
    global List<Project_Tracker__c> Tactics__r;
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

    global Project_Tracker__c () 
    {
    }
}