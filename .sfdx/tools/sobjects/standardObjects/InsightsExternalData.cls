// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class InsightsExternalData {
    global Id Id;
    global Boolean IsDeleted;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global String EdgemartAlias;
    global String EdgemartContainer;
    global String Format;
    global String Operation;
    global String Action;
    global String Status;
    global Boolean IsIndependentParts;
    global Boolean IsDependentOnLastUpload;
    global Integer MetaDataLength;
    global Integer CompressedMetadataLength;
    global String NotificationSent;
    global String NotificationEmail;
    global String EdgemartLabel;
    global String Dataflow;
    global Datetime SubmittedDate;
    global String FileName;
    global String Target;
    global String Description;
    global String StatusMessage;
    global Blob MetadataJson;
    global List<InsightsExternalDataPart> ExternalDataIds;

    global InsightsExternalData () 
    {
    }
}