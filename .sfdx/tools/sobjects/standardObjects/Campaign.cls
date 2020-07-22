// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Campaign {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global Campaign Parent;
    global Id ParentId;
    /* Campaign Type
    */
    global String Type;
    global RecordType RecordType;
    global Id RecordTypeId;
    global String Status;
    global Date StartDate;
    global Date EndDate;
    global Decimal ExpectedRevenue;
    global Decimal BudgetedCost;
    global Decimal ActualCost;
    global Double ExpectedResponse;
    global Double NumberSent;
    global Boolean IsActive;
    global String Description;
    global Integer NumberOfLeads;
    global Integer NumberOfConvertedLeads;
    global Integer NumberOfContacts;
    global Integer NumberOfResponses;
    global Integer NumberOfOpportunities;
    global Integer NumberOfWonOpportunities;
    global Decimal AmountAllOpportunities;
    global Decimal AmountWonOpportunities;
    global Integer TotalEmailsDelivered;
    global Integer UniqueEmailOpens;
    global Integer UniqueEmailTrackedLinkClicks;
    global Integer TotalFormViews;
    global Integer TotalFormSubmissions;
    global Integer UniqueMarketingLinkClicks;
    global Integer TotalLandingPageViews;
    global Integer TotalLandingPageFormSubmissions;
    global Integer HierarchyTotalEmailsDelivered;
    global Integer HierarchyUniqueEmailOpens;
    global Integer HierarchyUniqueEmailTrackedLinkClicks;
    global Integer HierarchyTotalFormViews;
    global Integer HierarchyTotalFormSubmissions;
    global Integer HierarchyUniqueMarketingLinkClicks;
    global Integer HierarchyTotalLandingPageViews;
    global Integer HierarchyTotalLandingPageFormSubmissions;
    global User Owner;
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
    global RecordType CampaignMemberRecordType;
    global Id CampaignMemberRecordTypeId;
    global String Commercial_Unit__c;
    global String Crop__c;
    global String Customer_Type__c;
    global String Membership__c;
    global String Objective__c;
    global String Micromarket_s__c;
    global String KPIs__c;
    global Contact Campaign_Contact__r;
    global Id Campaign_Contact__c;
    global String Campaign_Member_Status__c;
    /* Roll-up Summary Totaling All Leads & Contacts plus all Attending Guests so long as Campaign Member Status = Attended.
    */
    global Double Total_Checked_In__c;
    /* Roll-up Summary Totaling All Leads & Contacts plus all Registered Guests # Associated to Campaign Members where Status = "Registered."
    */
    global Double Total_Registered__c;
    global Double Total_Registered2__c;
    global Double Campaign_Members_Registered__c;
    /* Total (Identified) Guests By Invitees
    */
    global Double Total_Registered_Guests__c;
    /* Choose the offline tactic type for this campaign
    */
    global String Tactic_Type__c;
    global Boolean French__c;
    global String Brand__c;
    global String District_s__c;
    global String Campaign_Year__c;
    global Boolean Tactical_Plan__c;
    global Date Deployment_Date__c;
    global String Email_KPI__c;
    global String Budget_Year__c;
    global String Objective_Text__c;
    global String Audience__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<Campaign> ChildCampaigns;
    global List<CampaignFeed> Feeds;
    global List<CampaignHistory> Histories;
    global List<CampaignMember> CampaignMembers;
    global List<CampaignMemberStatus> CampaignMemberStatuses;
    global List<CampaignShare> Shares;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<Customer_Call__c> Customer_Calls__r;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<LandingPage> LandingPages;
    global List<ListEmail> ListEmails;
    global List<ListEmailRecipientSource> ListEmailRecipientSources;
    global List<MarketingForm> MarketingForms;
    global List<MarketingLink> MarketingLinks;
    global List<OpenActivity> OpenActivities;
    global List<Opportunity> Opportunities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<Project_Tracker__c> Project_Tracker__r;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<Task> Tasks;
    global List<TaskRelation> TaskRelations;
    global List<TopicAssignment> TopicAssignments;
    global List<smagicinteract__Conversation__c> smagicinteract__Conversations__r;
    global List<smagicinteract__Incoming_SMS__c> smagicinteract__Incoming_SMS__r;
    global List<smagicinteract__SMS_Batch_Execution_Tracker__c> smagicinteract__SMS_Batch_Execution_Tracker__r;
    global List<smagicinteract__smsMagic__c> smagicinteract__smsMagic__r;
    global List<CampaignChangeEvent> Parent;
    global List<CampaignMemberChangeEvent> Campaign;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<LandingPageChangeEvent> Campaign;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global Campaign () 
    {
    }
}