// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Programs__c {
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
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global Boolean Registration__c;
    /* Attach the completed form using the notes and attachments link after pressing save.
    */
    global Boolean Form_Completed__c;
    global Account Account__r;
    global Id Account__c;
    global Decimal Target__c;
    global Boolean Acres_Entered__c;
    global String Program_Year__c;
    global String Business_Pay_To__c;
    global String Offer_Type__c;
    global String Payment_Type__c;
    global Boolean Grower_Treater__c;
    /* Agreed To Business Plan @ SRP
    */
    global Decimal Business_Plan__c;
    global String Strategic_Target_1__c;
    global String Strategic_Target_2__c;
    global Double Target_1_Weighting__c;
    global Double Target_2_Weighting__c;
    global Boolean X100_Commercial_Treater__c;
    /* 90% of Agreed To Business Plan @ SRP
    */
    global Decimal X90_of_Business_Plan__c;
    global Double Earnings__c;
    global Decimal Discount_Unit__c;
    global Account Retailer__r;
    global Id Retailer__c;
    global Decimal Total_Discount__c;
    global String Variety__c;
    global Double of_Units__c;
    /* Please include all additional varieties and the quantity for each.
    */
    global String Additional_Varieties__c;
    global String Most_Recent_Acreage__c;
    /* # of Units for Soybeans
    */
    global Double Seed_Business_Plan__c;
    global String Target_1_Objectives__c;
    global String Target_1_Tactics_Initiatives__c;
    global Double Target_1_Weighting_Seed__c;
    global String Target_2_Objectives__c;
    global String Target_2_Tactics_Initiatives__c;
    global Double Target_2_Weighting_Seed__c;
    /* Select the account that the treater operates their personal farm under.
    */
    global Account Grower_Account__r;
    /* Select the account that the treater operates their personal farm under.
    */
    global Id Grower_Account__c;
    global Account Distributor__r;
    global Id Distributor__c;
    global Double PY_Fall_Ship__c;
    global Double Year_1_Number_of_Bins__c;
    global Double Year_1_Bin_Capacity__c;
    global Double Year_2_Bin_Capacity__c;
    global Double Year_2_Number_of_Bins__c;
    global Double Year_3_Bin_Capacity__c;
    global Double Year_3_Number_of_Bins__c;
    global Double File_Count__c;
    global String Account_Address__c;
    global String Account_Fax__c;
    global String Account_Household_Type__c;
    global String Account_Pay_To__c;
    global String Account_Phone__c;
    global String Account_Postal_Code__c;
    global String Account_Province__c;
    global Boolean Account_Registered__c;
    global String Account_Town__c;
    global String Address__c;
    global String Company_Name__c;
    global Boolean Data_Consent__c;
    global String Email__c;
    global Boolean Farming_Partners__c;
    global String Fax__c;
    global String First_Name__c;
    global String Last_Name__c;
    global String Mobile__c;
    global String Pay_To_Name__c;
    global String Phone__c;
    global String Postal_Code__c;
    global String Province__c;
    global String Status__c;
    global String Town__c;
    global Account Old_Account__r;
    global Id Old_Account__c;
    global Boolean French__c;
    global Double Fortenza_Advanced_Bag_Equivalents__c;
    global String Acres__c;
    global Double Actual_Cashback__c;
    global String Actual_Rainfall__c;
    global Contact Contact__r;
    global Id Contact__c;
    global String Payout_Status__c;
    global String Rainfall_Exit_Point__c;
    global String Rainfall_Threshold__c;
    global String Risk_Start_Period__c;
    global String Program_Reference__c;
    global String Longitude__c;
    global String Latitude__c;
    global String Event__c;
    global Product2 Focused_Product__r;
    global Id Focused_Product__c;
    global Decimal Estimated_Cost__c;
    global String Details__c;
    /* Click if you provided a grower list for the 1% targeted grower offer
    */
    global Boolean Targeted_Grower_List_Attached__c;
    global String Miravis_Ace_Acre_Target__c;
    global String Miravis_Neo_Acre_Target__c;
    global String Elatus_Acre_Target__c;
    global String Trivapro_Acre_Target__c;
    /* To be used by Programs administrators manually updating registrations.
    */
    global Boolean Manual__c;
    global String Offer_Objectives__c;
    global String Reward_Details__c;
    global String Payment_Schedule_Details__c;
    global Boolean Qualified__c;
    global String Final_Payment_Details__c;
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
    global List<Farming_Partners__c> Farming_Partners__r;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Programs__Feed> Feeds;
    global List<Programs__History> Histories;
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

    global Programs__c () 
    {
    }
}