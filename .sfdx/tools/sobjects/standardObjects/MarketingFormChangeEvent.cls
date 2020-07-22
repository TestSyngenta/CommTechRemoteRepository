// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class MarketingFormChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Campaign Campaign;
    global Id CampaignId;
    global Integer TotalViews;
    global Integer UniqueViews;
    global Integer TotalSubmissions;
    global Integer UniqueSubmissions;
    global Integer TotalErrors;
    global Integer UniqueErrors;
    global Integer TotalTrackedLinkClicks;
    global Integer UniqueTrackedLinkClicks;
    global String Type;

    global MarketingFormChangeEvent () 
    {
    }
}