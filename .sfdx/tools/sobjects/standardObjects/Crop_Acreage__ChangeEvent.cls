// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Crop_Acreage__ChangeEvent {
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
    global Account Account__c;
    global Double Acres__c;
    global String ComboKey__c;
    global String Crop_Code_Formula__c;
    global Crop__c Crop__c;
    global String Crop_description_formula__c;
    /* The source of the updated acreage information.
    */
    global String Data_Source__c;
    global String Year__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    global Boolean Most_Recent__c;
    /* The biopotential value of this Crop Acreage
    */
    global Decimal BioPotential__c;
    global String Comments__c;

    global Crop_Acreage__ChangeEvent () 
    {
    }
}