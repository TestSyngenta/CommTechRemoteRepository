// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Settlement__c {
    global Id Id;
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
    global Case Case__r;
    global Id Case__c;
    global String Send_To_Street__c;
    global User Approver_Level_5__r;
    global Id Approver_Level_5__c;
    global User Agronomy_Service_Rep__r;
    global Id Agronomy_Service_Rep__c;
    global String Send_To_City__c;
    global Settlement_Payment__c Settlement_Payment__r;
    global Id Settlement_Payment__c;
    global Decimal Total_Product_Value__c;
    global String Budget_Code__c;
    global User CU_Head__r;
    global Id CU_Head__c;
    global Boolean Paid_in_Tool__c;
    global String Send_To_Name__c;
    global String Check_Order__c;
    global String Cheque_Status__c;
    global String Send_To_Postal_Code__c;
    global String Send_To_Province__c;
    global User Customer_Marketing_Manager__r;
    global Id Customer_Marketing_Manager__c;
    global Date Date_Cheque_Cashed__c;
    /* Auto-populated when Settlement is Approved.
    */
    global Date Date_Settlement_Approved__c;
    global Date Date_Settlement_Issued__c;
    /* Date Settlement was submitting for approval and payment.
    */
    global Date Date_Settlement_Submitted__c;
    global Datetime Date_Time_Approved__c;
    global String Pay_To_Override__c;
    global String Pay_To_City__c;
    global User District_Manager__r;
    global Id District_Manager__c;
    global String Pay_To_Postal_Code__c;
    global String Pay_To_Province__c;
    global String Pay_To_Street__c;
    global String Order_Status__c;
    global String Case_Owner_DOA__c;
    global Boolean Submitted__c;
    global Double File_Count__c;
    global Date Deferred_Payment_Date__c;
    global String Payable_To_Picklist__c;
    global Double SAP_ID__c;
    global String Sales_Org__c;
    global String Send_To__c;
    global Decimal Settlement_Amount__c;
    global String Status__c;
    global String Type__c;
    global Date VDFCC_Contract_End_Date__c;
    global Decimal Veg_Cost_of_Goods__c;
    global Decimal Voucher_Value__c;
    global String Voucher__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global String Case_Type__c;
    global String Contact_Name__c;
    global String Account_Name__c;
    global Decimal Retailer_Handling_Fee__c;
    global Decimal Total_Voucher_Amount__c;
    global Product2 Settlement_Product__r;
    global Id Settlement_Product__c;
    global Double Quantity__c;
    global String Pay_To_Name__c;
    global String Send_To_Address_CA__c;
    global Account Distributor__r;
    global Id Distributor__c;
    global String Order_Number__c;
    global Product2 Return_Product__r;
    global Id Return_Product__c;
    global Double Return_Quantity__c;
    global String Seed_UOM__c;
    global User Approver_Level_1__r;
    global Id Approver_Level_1__c;
    global User Approver_Level_2__r;
    global Id Approver_Level_2__c;
    global User Approver_Level_3__r;
    global Id Approver_Level_3__c;
    global User Approver_Level_4__r;
    global Id Approver_Level_4__c;
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
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Settlement__Feed> Feeds;
    global List<Settlement__History> Histories;
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

    global Settlement__c () 
    {
    }
}