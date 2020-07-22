// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Retailer_Segment__ChangeEvent {
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
    global Decimal Retailer_Potential__c;
    global Double Share_at_Retailer__c;
    global String Retailer_Potential_Decile__c;
    global String Retailer_Share_Decile__c;
    global String Sales_Classification__c;
    global String Potential_Classification__c;
    global String Share_Classification__c;
    global String Calculated_Segmentation__c;
    /* If you do not agree with the project ENGAGE segmentation for a retailer, please provide your suggestion and outline the reasons within the TSR Rationale field below.
    */
    global String TSR_Segmentation__c;
    global String TSR_Segmentation_Rationale__c;
    global Account Retailer__c;

    global Retailer_Segment__ChangeEvent () 
    {
    }
}