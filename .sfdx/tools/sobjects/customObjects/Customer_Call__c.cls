// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Customer_Call__c {
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
    global Date Meeting_Date__c;
    global String Meeting_Attendees__c;
    global String Outcomes__c;
    global String Purpose__c;
    global String Objectives__c;
    global String Call_Type__c;
    global Account Account__r;
    global Id Account__c;
    /* Specific adapting strategies you want to use, taken from the online Customer DiSC Report for this client.
    */
    global String Adapting_to_my_Client__c;
    global Contact Contact__r;
    global Id Contact__c;
    /* Specific questions you want to ask or topics you would like to explore.
    */
    global String Current_Status__c;
    global String DiSC__c;
    global String Notes_and_Background__c;
    /* Specific pain-gain and evidence questions to have on hand.
    */
    global String Strategic_Requirements__c;
    global String Value_Style__c;
    /* Specific questions you want to ask or topics you would like to explore.
    */
    global String Visions_and_Goals__c;
    /* What you want to say in order to start the confirmation process.
    */
    global String a_Confirmation__c;
    /* What you want to say about next time to continue discovery or discuss solutions.
    */
    global String b_Next_Meeting__c;
    global String Follow_Up__c;
    global Campaign Related_Campaign__r;
    global Id Related_Campaign__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<Customer_Call__History> Histories;
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
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global Customer_Call__c () 
    {
    }
}