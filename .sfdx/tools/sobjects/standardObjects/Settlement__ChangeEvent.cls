// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Settlement__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Case Case__c;
    global String Send_To_Street__c;
    global User Approver_Level_5__c;
    global User Agronomy_Service_Rep__c;
    global String Send_To_City__c;
    global Settlement_Payment__c Settlement_Payment__c;
    global Decimal Total_Product_Value__c;
    global String Budget_Code__c;
    global User CU_Head__c;
    global Boolean Paid_in_Tool__c;
    global String Send_To_Name__c;
    global String Check_Order__c;
    global String Cheque_Status__c;
    global String Send_To_Postal_Code__c;
    global String Send_To_Province__c;
    global User Customer_Marketing_Manager__c;
    global Date Date_Cheque_Cashed__c;
    /* Auto-populated when Settlement is Approved.
    */
    global Date Date_Settlement_Approved__c;
    global Date Date_Settlement_Issued__c;
    /* Date Settlement was submitting for approval and payment.
    */
    global Date Date_Settlement_Submitted__c;
    global Datetime Date_Time_Approved__c;
    global String Pay_To_Override__c;
    global String Pay_To_City__c;
    global User District_Manager__c;
    global String Pay_To_Postal_Code__c;
    global String Pay_To_Province__c;
    global String Pay_To_Street__c;
    global String Order_Status__c;
    global String Case_Owner_DOA__c;
    global Boolean Submitted__c;
    global Double File_Count__c;
    global Date Deferred_Payment_Date__c;
    global String Payable_To_Picklist__c;
    global Double SAP_ID__c;
    global String Sales_Org__c;
    global String Send_To__c;
    global Decimal Settlement_Amount__c;
    global String Status__c;
    global String Type__c;
    global Date VDFCC_Contract_End_Date__c;
    global Decimal Veg_Cost_of_Goods__c;
    global Decimal Voucher_Value__c;
    global String Voucher__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global String Case_Type__c;
    global String Contact_Name__c;
    global String Account_Name__c;
    global Decimal Retailer_Handling_Fee__c;
    global Decimal Total_Voucher_Amount__c;
    global Product2 Settlement_Product__c;
    global Double Quantity__c;
    global String Pay_To_Name__c;
    global String Send_To_Address_CA__c;
    global Account Distributor__c;
    global String Order_Number__c;
    global Product2 Return_Product__c;
    global Double Return_Quantity__c;
    global String Seed_UOM__c;
    global User Approver_Level_1__c;
    global User Approver_Level_2__c;
    global User Approver_Level_3__c;
    global User Approver_Level_4__c;

    global Settlement__ChangeEvent () 
    {
    }
}