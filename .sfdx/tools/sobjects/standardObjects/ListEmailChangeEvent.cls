// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ListEmailChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global User Owner;
    global Id OwnerId;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String Subject;
    global String HtmlBody;
    global String TextBody;
    global String FromName;
    global String FromAddress;
    global String ReplyToAddress;
    global String Status;
    global Boolean HasAttachment;
    global Datetime ScheduledDate;
    global Integer TotalSent;
    global String SentVia;
    global Integer TotalSoftBounced;
    global Integer TotalHardBounced;
    global Integer TotalOpens;
    global Integer UniqueOpens;
    global Integer TotalTrackedLinkClicks;
    global Integer UniqueTrackedLinkClicks;
    global Integer UniqueOptOuts;
    global Integer TotalSpamComplaints;
    global Campaign Campaign;
    global Id CampaignId;
    global Boolean IsTracked;
    global String Type;
    global String ProgramName;

    global ListEmailChangeEvent () 
    {
    }
}