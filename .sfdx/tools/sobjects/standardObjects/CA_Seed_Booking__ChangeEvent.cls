// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CA_Seed_Booking__ChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global SObject Owner;
    global Id OwnerId;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String Additional_Comments__c;
    global String District__c;
    /* Please indicate the quantity that the retailer would like regardless of allocation.  Allocation is captured in the Quantity field.
    */
    global Double Desired_Quantity__c;
    global Double File_Count__c;
    global String Seed_Booking_Type__c;
    global Account Toller__c;
    global String Toller_City__c;
    global Account Old_Account__c;
    global String Commercial_Unit__c;
    /* Number of intended units (early booking contest)
    */
    global Double Number_of_Units__c;
    /* Preferred Retailer (early booking contest)
    */
    global String Preferred_Retailer__c;
    /* Preferred City (early booking contest)
    */
    global String Preferred_City__c;
    global Double S003_Z4X__c;
    global Double S006_M4X__c;
    global Double S006_W5__c;
    global Double S007_Y4__c;
    global Double S0007_B7X__c;
    global Double S0009_M2__c;
    global Double Total_Acreage_Intentions__c;
    global String External_Key__c;
    global String First_Name__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global Account Account__c;
    global String Crop__c;
    global String Legal_Land_Description__c;
    /* Quantity UOM:
Canola- Bags
Cereals- Bushels
Soybeans- Units
    */
    global Double Quantity__c;
    global String RSA__c;
    global Account Retailer_Distributor__c;
    global String SSA__c;
    global String TSA__c;
    global String Variety__c;
    global String Year__c;
    global String Last_Name__c;
    global String Email__c;
    global String Mobile__c;
    global String CompanyFarm_Name__c;

    global CA_Seed_Booking__ChangeEvent () 
    {
    }
}