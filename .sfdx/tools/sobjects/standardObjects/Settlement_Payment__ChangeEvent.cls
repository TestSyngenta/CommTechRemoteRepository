// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Settlement_Payment__ChangeEvent {
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
    global Cheque_Run__c Cheque_Run__c;
    global Account Account__c;
    global Decimal Amount__c;
    global Case Case__c;
    global String Pay_To_Name__c;
    global String Pay_To__c;
    global Account Purchased_From_Account__c;
    global String Send_To_City__c;
    global String Send_To_Name__c;
    global String Send_To_Postal_Code__c;
    global String Send_To_Province__c;
    global String Send_To_Street__c;
    global String Status__c;
    global String Type__c;
    global String District__c;
    global String Pay_To_City__c;
    global String Pay_To_Postal_Code__c;
    global String Pay_To_Province__c;
    global String Pay_To_Street__c;
    global String Program_Name__c;
    global String Rep_Email__c;
    global String Rep_Name__c;
    global String Rep_Number__c;
    global String Rep_Phone_No__c;
    global String Rep_Title__c;
    global String Send_To__c;
    /* When this value is changed, it will trigger an update to the associated Settlements with the Cheque Information
    */
    global String Cheque_Number__c;
    global String Cheque_Status__c;
    global Date Date_Cheque_Cashed__c;
    global Date Date_Settlement_Issued__c;

    global Settlement_Payment__ChangeEvent () 
    {
    }
}