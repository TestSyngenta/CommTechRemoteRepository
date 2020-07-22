// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Bin__ChangeEvent {
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
    /* The account that the bin is related to
    */
    global Account Account__c;
    /* Does the bin support aeration?
    */
    global Boolean Aeration__c;
    /* The make of the bin
    */
    global String Bin_Make__c;
    /* The Model of the bin
    */
    global String Bin_Model__c;
    /* Any additional comments you can provide regarding the bin
    */
    global String Comments__c;
    /* Is the bin in a Conveyor System?
    */
    global Boolean In_a_Conveyor_System__c;
    /* Does the bin have a Let-down Ladder?
    */
    global Boolean Let_down_Ladder__c;
    /* Size of Bin (Bushels)
    */
    global Double Size_of_Bin_Bushels__c;
    /* Unloading Process
    */
    global String Unloading_Process__c;

    global Bin__ChangeEvent () 
    {
    }
}