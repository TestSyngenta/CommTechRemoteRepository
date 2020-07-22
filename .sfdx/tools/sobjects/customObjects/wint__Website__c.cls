// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class wint__Website__c {
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
    /* If checked then system will allow changing Email of related Website Accounts.
    */
    global Boolean wint__AllowEmailChange__c;
    /* If unchecked, anonymous submissions will be auto-validated and applied immediately. This is default behaviour.
If checked, then anonymous submissions will not be applied unless it's validated. This can be used if country implements double opt-in.
    */
    global Boolean wint__Anonymous_Verification_Required__c;
    /* The mapping used to extract values from Any Data JSON object to Website Account in JSON notation: 
{ 
"<wa-field>" : "<any-data-property>"
}
    */
    global String wint__Any_To_Website_Account_Sync__c;
    global String wint__Country__c;
    global Boolean wint__DoNotSyncOnContact2Change__c;
    /* If checked, Website Account will not be synchronised to Contact when Contact has changed. Website Account will still be synchronised to Contact when Website Account has changed.
    */
    global Boolean wint__DoNotSyncOnContactChange__c;
    global Boolean wint__DoNotSyncOnLead2Change__c;
    /* If checked, Website Account will not be synchronised to Lead when Lead has changed. Website Account will still be synchronised to Lead when Website Account has changed.
    */
    global Boolean wint__DoNotSyncOnLeadChange__c;
    /* URL to be polled when Website Account is modified in SFDC.
    */
    global String wint__PULL_webhook__c;
    global String wint__Unique_Key__c;
    global String wint__Website_Account_Alternative_Condition__c;
    global String wint__Website_Account_To_Contact2_Match2__c;
    global String wint__Website_Account_To_Contact2_Match__c;
    global String wint__Website_Account_To_Contact2_Sync__c;
    /* The matching pattern used to build a matching key for Contact from Website Account in form: 
[“<field/value-1>”, …., “<field/value-n>”]. 
Fields will be concatenated in the same order, separated with “|” and converted to uppercase.
    */
    global String wint__Website_Account_To_Contact_Match2__c;
    /* The matching pattern used to build a matching key for Contact from Website Account in form:
[“<field/value-1>”, …., “<field/value-n>”].
Fields will be concatenated in the same order, separated with “|” and converted to uppercase.
    */
    global String wint__Website_Account_To_Contact_Match__c;
    /* The mapping used to synchronize Website Account and Contact in JSON notation:
{
"<contact-field>" : "<website-account-field>",
"<contact-field>" : "<website-account-field>::<null-value>",
"<contact-field>" : "::<constant-value>"
}
    */
    global String wint__Website_Account_To_Contact_Sync__c;
    global String wint__Website_Account_To_Individual2_Match__c;
    /* The matching key of Individual in form: [“<field/value-1>”, …., “<field/value-n>”]. 
Will always be prepended with website's country. 
Fields will be concatenated in the same order, separated with “|” and converted to uppercase.
    */
    global String wint__Website_Account_To_Individual_Match__c;
    global String wint__Website_Account_To_Lead2_Match2__c;
    global String wint__Website_Account_To_Lead2_Match__c;
    global String wint__Website_Account_To_Lead2_Sync__c;
    /* The matching pattern used to build a matching key for Lead from Website Account in form: 
[“<field/value-1>”, …., “<field/value-n>”]. 
Fields will be concatenated in the same order, separated with “|” and converted to uppercase.
    */
    global String wint__Website_Account_To_Lead_Match2__c;
    /* The matching pattern used to build a matching key for Lead from Website Account in form:
[“<field/value-1>”, …., “<field/value-n>”].
Fields will be concatenated in the same order, separated with “|” and converted to uppercase.
    */
    global String wint__Website_Account_To_Lead_Match__c;
    /* The mapping used to synchronize Website Account and Lead in JSON notation:
{
"<lead-field>" : "<website-account-field>",
"<lead-field>" : "<website-account-field>::<null-value>",
"<lead-field>" : "::<constant-value>"
}
    */
    global String wint__Website_Account_To_Lead_Sync__c;
    global String wint__Website_Account_To_New_Individual2_Sync__c;
    global String wint__Website_Account_To_New_Individual_Sync__c;
    global String wint__Website_Account_To_New_Lead2_Sync__c;
    /* The mapping used to create new Lead from Website Account in JSON notation:
{
"<lead-field>" : "<website-account-field>",
"<lead-field>" : "<website-account-field>::<null-value>",
"<lead-field>" : "::<constant-value>"
}
    */
    global String wint__Website_Account_To_New_Lead_Sync__c;
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
    global List<wint__Website_Account_Biopotential__c> wint__Website_Account_Biopotentials__r;
    global List<wint__Website_Account_Subscription__c> wint__Website_Account_Subscriptions__r;
    global List<wint__Website_Account__c> wint__Website_Accounts__r;
    global List<wint__Website_Anonymous_Submission__c> wint__Website_Anonymous_Submission__r;
    global List<wint__Website_Subscription__c> wint__Website_Subscriptions__r;
    global List<wint__Website__Share> Shares;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global wint__Website__c () 
    {
    }
}