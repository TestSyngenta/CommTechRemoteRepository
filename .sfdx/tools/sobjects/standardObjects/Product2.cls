// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Product2 {
    global Id Id;
    global String Name;
    global String ProductCode;
    global String Description;
    global Boolean IsActive;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global String Family;
    global RecordType RecordType;
    global Id RecordTypeId;
    global ExternalDataSource ExternalDataSource;
    global Id ExternalDataSourceId;
    global String ExternalId;
    global String DisplayUrl;
    global String QuantityUnitOfMeasure;
    global Boolean IsDeleted;
    global Boolean IsArchived;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String StockKeepingUnit;
    global Double Quantity_Acres_Conversion_A633__c;
    global Boolean AvailableforPlanning__c;
    global Crop_Group__c PrimaryECUCrop__r;
    global Id PrimaryECUCrop__c;
    global String Base_UOM__c;
    global Crop_Group__c PrimaryWCUCrop__r;
    global Id PrimaryWCUCrop__c;
    global String Min_Saleable_UoM__c;
    global Boolean RR_Stewardship_Required__c;
    global Boolean Non_RR_Stewardship_Required__c;
    global Boolean Has_Current_Year_Orders__c;
    global Boolean Available_for_Distributor_Planning_ECU__c;
    global String Product_Description_Min_Saleable_UOM__c;
    global Boolean Commercial_Treated_Seedcare__c;
    global String Product_Name_Field_UOM__c;
    global Boolean Available_for_Distributor_Planning_WCU__c;
    global String Package_UOM__c;
    global String Product_Country__c;
    global String Product_ID__c;
    global Boolean Available_for_Non_Dist_Planning_ECU__c;
    global Boolean Available_for_Non_Dist_Planning_WCU__c;
    global String Sales_Org__c;
    global String Species__c;
    global Decimal Suggested_Dealer_Price__c;
    global String Treatment__c;
    global String Variety__c;
    /* Conversion from Base UoM to Field UoM
    */
    global Double Volume_L__c;
    global String Product_Line__c;
    global String Active_Ingredient__c;
    global String Maturity_Group__c;
    global String Selective_Herbicide_Category__c;
    global String Brand__c;
    global Double Min_Saleable_UoM_Conversion__c;
    global Double Quantity_Acres_Conversion_A623__c;
    global List<ActivityHistory> ActivityHistories;
    global List<Asset> Assets;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Case> Cases__r;
    global List<Channel_Sales__c> Channel_Sales_Product_Rel__r;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OTG_Sales_History__c> OTG_Sales_History_Records__r;
    global List<OTG_Sales__c> OTG_Sales__r;
    global List<OpenActivity> OpenActivities;
    global List<Price_List__c> Price_Lists__r;
    global List<PricebookEntry> PricebookEntries;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Product2Feed> Feeds;
    global List<Product2History> Histories;
    global List<Programs__c> Programs__r;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Replants__c> Replants__r;
    global List<Sales_Plan_Actual__c> Sales_Plan_Actual__r;
    global List<Settlement__c> Settlements1__r;
    global List<Settlement__c> Settlements__r;
    global List<SurveySubject> SurveySubjectEntities;
    global List<Syngenta_Product__c> Syngenta_Products__r;
    global List<Task> Tasks;
    global List<TaskRelation> TaskRelations;
    global List<AssetChangeEvent> Product2;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<OpportunityLineItem> Product2;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global Product2 () 
    {
    }
}