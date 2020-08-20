// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Account {
    global Id Id;
    global Boolean IsDeleted;
    global Account MasterRecord;
    global Id MasterRecordId;
    global String Name;
    global String Type;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Account Parent;
    global Id ParentId;
    global String BillingStreet;
    global String BillingCity;
    global String BillingState;
    global String BillingPostalCode;
    global String BillingCountry;
    global String BillingStateCode;
    global String BillingCountryCode;
    global Double BillingLatitude;
    global Double BillingLongitude;
    global String BillingGeocodeAccuracy;
    global Address BillingAddress;
    global String ShippingStreet;
    global String ShippingCity;
    global String ShippingState;
    global String ShippingPostalCode;
    global String ShippingCountry;
    global String ShippingStateCode;
    global String ShippingCountryCode;
    global Double ShippingLatitude;
    global Double ShippingLongitude;
    global String ShippingGeocodeAccuracy;
    global Address ShippingAddress;
    global String Phone;
    global String Fax;
    global String Website;
    global String PhotoUrl;
    global String Industry;
    global Integer NumberOfEmployees;
    global String Description;
    /* Please change the ownership of this account by editing the Territory # field.
    */
    global User Owner;
    /* Please change the ownership of this account by editing the Territory # field.
    */
    global Id OwnerId;
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
    global String JigsawCompanyId;
    /* The average Household SDP from the last 3 full years divided by the current Total Bio Potential of the Household.
    */
    global Double Share_Of_Opportunity__c;
    global Decimal PY0_Household_SDP__c;
    global Decimal PY1_Household_SDP__c;
    global String Account_ID__c;
    global String Account_Main_Contact_Account__c;
    global String Account_Main_Contact_Name__c;
    /* Primary Contact is managed on the contact record.  To update drill into the appropriate contact and check the Primary Contact checkbox.
    */
    global Contact Account_Main_Contact__r;
    /* Primary Contact is managed on the contact record.  To update drill into the appropriate contact and check the Primary Contact checkbox.
    */
    global Id Account_Main_Contact__c;
    global Date Date_Inactivated__c;
    global Decimal PY2_Household_SDP__c;
    global Decimal PY3_Household_SDP__c;
    global Boolean AllowSeedsplanning__c;
    global Decimal PY0_Individual_SDP__c;
    global Decimal PY1_Individual_SDP__c;
    global Decimal PY2_Individual_SDP__c;
    global Decimal PY3_Individual_SDP__c;
    global String Household_Type__c;
    global String Household_type_code__c;
    global String Most_Recent_Acreage__c;
    global String SSA__c;
    global String Decile_Colour__c;
    global String Treater_Type__c;
    global String Decile_Segment__c;
    global Boolean Top_1000__c;
    global Double PY0_Brand_Count__c;
    /* Account that survives as the winner of a merge.
    */
    global Account Winner_Account__r;
    /* Account that survives as the winner of a merge.
    */
    global Id Winner_Account__c;
    global String Primary_Contact_Email__c;
    global String Customer_Retention__c;
    global String Account_Type_Wave__c;
    global String Rep_Territory__c;
    global String CA_Commercial_Unit__c;
    global String CMD_Auto_Number__c;
    global String CMD_Grower_Account_ID__c;
    global String CMD_Grower_Main_Contact_ID__c;
    global String CP_Retail_ID__c;
    global Boolean HasEmail_old__c;
    global String CP_Territory__c;
    global Boolean HasPhone_old__c;
    global Boolean HasAcreage__c;
    global String Decile_Wave__c;
    global Boolean HasEmail__c;
    global Boolean HasPhone__c;
    global String Retailer_Product_Lines_Last_Year__c;
    global Territory__c Territory_Lookup__r;
    global Id Territory_Lookup__c;
    global String Primary_Contact_Mobile__c;
    /* This account purchased at least 70% of their total purchases last year from this Retailer.
    */
    global Account Preferred_Retailer__r;
    /* This account purchased at least 70% of their total purchases last year from this Retailer.
    */
    global Id Preferred_Retailer__c;
    global Boolean Commercial_Treater__c;
    global String Early_Adopter_Score__c;
    global Double PY1_Brand_Count__c;
    global String Category__c;
    global String Contact_Website__c;
    global String General_Email__c;
    global String Government_Level__c;
    global String Grower_Name_Wave__c;
    global String Relevant_Crops__c;
    global Double Contact_Count__c;
    /* An account has preferred status if it has opted in for Emails and has reported acreage in the last 3 years
    */
    global Boolean Preferred_Status__c;
    global Account Retailer_Head_Office_Rel__r;
    global Id Retailer_Head_Office_Rel__c;
    global Boolean Do_Not_Mail__c;
    global String Retailer_Head_Office__c;
    global Foundation_Customer__c Foundation_Customer__r;
    global Id Foundation_Customer__c;
    /* This customer has requested not to receive Marketing phone campaigns. Please contact the CIC to make any changes.
    */
    global Boolean Do_Not_Call__c;
    global Boolean Has_Opted_In_Contact__c;
    global Boolean Household_Has_Acreage_in_Last_3_Years__c;
    global Boolean Household_Has_Opted_In_Contact__c;
    global String Retailer_Name_Wave__c;
    global Boolean Retailer_is_Head_Office__c;
    global String Account_Main_Contact_FirstName__c;
    global String Account_Main_Contact_LastName__c;
    global Double Total_Most_Recent_Acres__c;
    global String Retailer_Key_Account__c;
    global Boolean Preferred_Status_2018__c;
    global String Crop_Type__c;
    global String SF_SSA__c;
    global String Foundation_Status__c;
    global String SSA_Num__c;
    global Date AWSA_Expiry__c;
    global String AWSA__c;
    global Boolean X100_CT__c;
    global Boolean Seed_Associate__c;
    global String Crop_Treatment_s__c;
    global Boolean isActive__c;
    global String Shipping_Point__c;
    global String District_Manager_Email__c;
    global String District_Manager__c;
    global String District__c;
    global String Carrier_Type__c;
    global String SCAC__c;
    global String XPO_Carrier_Code__c;
    global String Grower_Parent_Name_Wave__c;
    global String Email__c;
    global String Grower_Parent_Touchpoint__c;
    /* East-only association of an Agronomic Service Rep to a Retailer
    */
    global User Account_ASR__r;
    /* East-only association of an Agronomic Service Rep to a Retailer
    */
    global Id Account_ASR__c;
    global String Carrier_Function__c;
    global Boolean Hazmat__c;
    global String MC__c;
    global Double Retailer_RR_Compliance_Percent__c;
    global Double Retailer_Non_RR_Compliance_Percent__c;
    /* Formula field that determines if the sales region is East or West based on Account's Shipping State Code value.
    */
    global String SalesRegion__c;
    /* Formula field that converts the “Most Recent Acreage” text field into a true/false value as 0, 1 for reporting formulas & dashboard purposes.
    */
    global Double Has_Acreage_Formula__c;
    global Double Accounts__c;
    /* Formula field that converts the “2017 Brand Count” field into a 0,1 value based on the total number.
    */
    global Double Brand_Loyalty_Brand_Count__c;
    global User Inactivated_By__r;
    global Id Inactivated_By__c;
    global Boolean Seed_Production_Grower__c;
    global Boolean Retailer_Head_Office_SSA__c;
    global Boolean Grower_RR_Stewardship_Compliant__c;
    global Boolean Grower_Non_RR_Stewardship_Compliant__c;
    global Boolean Preferred_Status_2019__c;
    global String Retailer_Area_Wave__c;
    global String Foundation_ID__c;
    global Boolean Seed_Reporting__c;
    global String Retailer_Segment__c;
    global Boolean Retailer_is_Parent__c;
    /* Share of Opportunity determines Get/Grow/Keep.
Less than 5% of Share of Opportunity = Get
At least 5% but less than 30% of Share of Opportunity = Grow
At least 30% of Share of Opportunity = Keep
    */
    global String GetGrowKeep__c;
    global String Account_Main_Contact_First_Name__c;
    global String Account_Main_Contact_Last_Name__c;
    global Boolean Hutterite__c;
    global String ICS_Code__c;
    global Boolean Preferred_Status_2020__c;
    /* Please create a Programs Team inquiry to inactivate an account. The Programs Team will make sure that all necessary steps are taken in the back-end before inactivating the account.
    */
    global Boolean Inactive__c;
    global Boolean Retailer_Seed_Seedcare_Only__c;
    global Boolean Touchpoint_Flag__c;
    global Double Flag_Check__c;
    global String Lead_Touch_Point__c;
    global Boolean CRM_Pilot_Grower__c;
    global Boolean X2019_VSR__c;
    global Boolean Mail_Returned__c;
    global String Legal_Land_Description__c;
    global String Account_Owner_Full_Name__c;
    global String Seed_Treater_Type__c;
    global String Micromarket__c;
    global Boolean Migrated_Record__c;
    global String Migration_ID__c;
    global String NSAP_ID__c;
    /* The total Bio Potential of all accounts across Canada is divided into 10 buckets (Deciles). The highest Bio Potential accounts are in Decile 1 and the lowest in Decile 10.
    */
    global String Opportunity_Decile__c;
    global String Pay_To_Name__c;
    global String RSA__c;
    global Boolean Registered__c;
    global String SF_Full_ID__c;
    global String TGT_Account_ID__c;
    global String TSA__c;
    global String Territory__c;
    /* The greater value of:
a) The sum of all Bio Potential from Crop Acreage data on each account in the household. The most recent acres are used for each account and must be < 5 years old.
b) The highest SDP sales for the household in the last 3 full years
    */
    global Decimal Total_Opportunity__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global String Commercial_Unit__c;
    global String Sales_Rep__c;
    global String Seed_Care_Specialist__c;
    global List<Account> ChildAccounts;
    global List<Account> Accounts1__r;
    global List<Account> Retailer_Head_Office__r;
    global List<Account> Accounts__r;
    global List<AccountContactRole> AccountContactRoles;
    global List<AccountFeed> Feeds;
    global List<AccountHistory> Histories;
    global List<AccountPartner> AccountPartnersFrom;
    global List<AccountPartner> AccountPartnersTo;
    global List<AccountShare> Shares;
    global List<AccountTeamMember> AccountTeamMembers;
    global List<Account_Management_Call__c> Account_Management_Calls__r;
    global List<Account_Plan__c> Inventory__r;
    global List<Account_Plan__c> Retailer_Account_Plans__r;
    global List<Account_Plan__c> Account_Plans__r;
    global List<Account_Snapshot__c> Account_Historical_Details__r;
    global List<Account_Territory__c> Account_Territories__r;
    global List<Account_Territory__c> Account_Territories2__r;
    global List<Account_Territory__c> Account_Territories1__r;
    global List<ActivityHistory> ActivityHistories;
    global List<Asset> Assets;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Bin__c> Bins__r;
    global List<Business_Plan__c> Business_Plans__r;
    global List<CA_Seed_Booking__c> Seed_Bookings__r;
    global List<CA_Seed_Booking__c> Seed_Bookings2__r;
    global List<CA_Seed_Booking__c> Seed_Bookings1__r;
    global List<CA_Seed_Booking__c> Production_Seed_Bookings__r;
    global List<CampaignMember> Campaign_Members__r;
    global List<Case> Cases;
    global List<Case> Duplicate__r;
    global List<Case> Cases__r;
    global List<Channel_Sales__c> Ship_To_Customer_Rel__r;
    global List<Channel_Sales__c> Sold_To_Customer_Rel__r;
    global List<Client_List_Independent_Agronomist__c> Client_List_Independent_Agronomist1__r;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<Commercial_Experience_Demos__c> Commercial_Experience__r;
    global List<Commercial_Experience_Demos__c> Commercial_Experience1__r;
    global List<Contact> Contacts;
    global List<Contact> Contacts__r;
    global List<ContactPointEmail> ContactPointEmails;
    global List<ContactPointPhone> ContactPointPhones;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<Contract> Contracts;
    global List<Crop_Acreage__c> Crop_Acreage__r;
    global List<Customer_Call__c> Customer_Calls__r;
    global List<Customer_Experience_Trials__c> Customer_Experience_Trials__r;
    global List<Customer_Experience_Trials__c> Customer_Experience_Trials1__r;
    global List<Customer_Knowledge__c> Customer_Knowledge__r;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<Duplicate_Records__c> Duplicate_Records1__r;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<Foundation_Customer__c> Foundation_Customers1__r;
    global List<Foundation_Customer__c> Foundation_Customers__r;
    global List<Foundation_Customer__c> Retailer_Foundation_Customer__r;
    global List<LookedUpFromActivity> Activities__r;
    global List<NetworkActivityAudit> ParentEntities;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OTG_Sales_History__c> OTG_Sales_History_Records__r;
    global List<OTG_Sales__c> OTG_Sales__r;
    global List<OTG_Sales__c> OTG_Sales1__r;
    global List<OpenActivity> OpenActivities;
    global List<Opportunity> Opportunities;
    global List<Opportunity> Opportunities__r;
    global List<Opportunity> Opportunities1__r;
    global List<OpportunityLineItem> Opportunity_Product__r;
    global List<OpportunityPartner> OpportunityPartnersTo;
    global List<Order> Orders;
    global List<Partner> PartnersFrom;
    global List<Partner> PartnersTo;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Programs__c> Programs__r;
    global List<Programs__c> Distributor__r;
    global List<Programs__c> Programs2__r;
    global List<Programs__c> Programs3__r;
    global List<Programs__c> Programs1__r;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Replants__c> Replants__r;
    global List<Retailer_Segment__c> Retailer_Segmentation__r;
    global List<Sales_Plan_Actual__c> Sales_Plan_Actual__r;
    global List<Settlement_Payment__c> Settlement_Payments__r;
    global List<Settlement_Payment__c> Settlement_Payments_PurchasedFrom__r;
    global List<Settlement__c> Settlements2__r;
    global List<SocialPersona> Personas;
    global List<SocialPost> Posts;
    global List<Stewardship_Agreements__c> Stewardship_Agreements__r;
    global List<Stewardship_Agreements__c> Stewardship_Agreements1__r;
    global List<Summary_OTGS_Child_Account_Brand__c> Summary_OTGS_Child_Acct_Brand__r;
    global List<SurveySubject> SurveySubjectEntities;
    global List<Task> Tasks;
    global List<TaskRelation> TaskRelations;
    global List<TopicAssignment> TopicAssignments;
    global List<User> Users;
    global List<smagicinteract__Conversation__c> smagicinteract__conversations__r;
    global List<smagicinteract__smsMagic__c> smagicinteract__SMS_History__r;
    global List<AcceptedEventRelation> Account;
    global List<AccountChangeEvent> Parent;
    global List<AccountContactRoleChangeEvent> Account;
    global List<ActivityHistory> PrimaryAccount;
    global List<AssetChangeEvent> Account;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<ContractChangeEvent> Account;
    global List<EventChangeEvent> What;
    global List<EventRelation> Account;
    global List<EventRelationChangeEvent> Relation;
    global List<EventWhoRelation> Account;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<Lead> ConvertedAccount;
    global List<NetworkSelfRegistration> Account;
    global List<OpenActivity> PrimaryAccount;
    global List<OpportunityChangeEvent> Account;
    global List<TaskChangeEvent> What;
    global List<TaskRelation> Account;
    global List<TaskRelationChangeEvent> Relation;
    global List<TaskWhoRelation> Account;
    global List<UserRole> PortalAccount;

    global Account () 
    {
    }
}