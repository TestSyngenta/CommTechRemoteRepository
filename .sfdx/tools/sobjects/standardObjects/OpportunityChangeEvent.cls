// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class OpportunityChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global Account Account;
    global Id AccountId;
    global RecordType RecordType;
    global Id RecordTypeId;
    global String Name;
    global String Description;
    global String StageName;
    global Decimal Amount;
    global Date CloseDate;
    global String Type;
    global String NextStep;
    global String LeadSource;
    global Boolean IsClosed;
    global Boolean IsWon;
    global String ForecastCategory;
    global String ForecastCategoryName;
    global Campaign Campaign;
    global Id CampaignId;
    global Boolean HasOpportunityLineItem;
    global Pricebook2 Pricebook2;
    global Id Pricebook2Id;
    global User Owner;
    global Id OwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Contact Contact;
    global Id ContactId;
    global Quote SyncedQuote;
    global Id SyncedQuoteId;
    global Business_Plan__c AccountBusinessPlan__c;
    global Account_Territory__c Account_Territory__c;
    global String CommercialUnit__c;
    global String CurrentBusinessPlanYear__c;
    global String Dist_Oppy_Id__c;
    global Territory__c District__c;
    global String Product_Type__c;
    global Opportunity RelHeadOfficePlan__c;
    global Opportunity RelatedASPplan__c;
    global Opportunity RelatedCUPlan__c;
    global Opportunity RelatedDistributorPlan__c;
    global Account RelatedDistributor__c;
    global Opportunity RelatedTerritoryPlan__c;
    global String Related_Business_Plan_Locked__c;
    global Account Related_Retailer__c;
    global String SalesRep__c;
    global String Sales_Plan_Type__c;
    global Territory__c Territory__c;
    global String Year__c;
    global Double CountofOppProducts__c;
    global String Account_Name__c;
    global String Owner_Name__c;
    global String Instructions__c;
    global Double Forecast_Line_Item_Count__c;
    global Boolean Forecast_Locked__c;
    global Boolean Area_Level_Forecast__c;
    global Double Sum_of_CY_OTG_Growth__c;
    global Double Forecast_Rollup_Indicator__c;
    global String Retailer_Forecast_Type__c;
    global String Account_Record_Type__c;
    global String Account_Province__c;
    global String Account_Name_Wave__c;
    global String Related_Distributor_Name__c;
    global Double Sum_of_OTG_Forecast__c;
    global String Edit_Forecast__c;
    global String Retailer_Segment__c;
    global String Retailer_Key_Account__c;
    global String Commercial_Unit_Text__c;

    global OpportunityChangeEvent () 
    {
    }
}