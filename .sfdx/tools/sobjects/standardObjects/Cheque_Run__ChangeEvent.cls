// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Cheque_Run__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global SObject Owner;
    global Id OwnerId;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String Cheque_Run_Report__c;
    /* Cancelling a Cheque Run will dissociate the Settlements and return them to 'Submitted for Payment'
    */
    global String Status__c;
    global String Voucher_Payment_Report__c;
    global Decimal Total_Amount__c;
    /* Changing this will update the status for all of the associated Settlements
    */
    global String Settlements_Status__c;
    global String Cheque_Run_Type__c;

    global Cheque_Run__ChangeEvent () 
    {
    }
}