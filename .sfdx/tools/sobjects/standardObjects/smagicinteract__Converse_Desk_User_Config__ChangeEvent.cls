// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class smagicinteract__Converse_Desk_User_Config__ChangeEvent {
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
    /* Stores the ID of the moc for which the config is done.
    */
    global smagicinteract__Message_Object_Config__c smagicinteract__Message_Object_Config__c;
    /* Api name of the field to be displayed on the conversation listing.
    */
    global String smagicinteract__Listing_Field__c;
    /* Stores which template field to show. If blank no field will be shown
    */
    global String smagicinteract__Template_Field__c;
    /* Stores the ID of the user for whom the config is done.
    */
    global User smagicinteract__User__c;

    global smagicinteract__Converse_Desk_User_Config__ChangeEvent () 
    {
    }
}