// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CampaignMemberChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global Campaign Campaign;
    global Id CampaignId;
    global Lead Lead;
    global Id LeadId;
    global Contact Contact;
    global Id ContactId;
    global String Status;
    global Boolean HasResponded;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Date FirstRespondedDate;
    global String Comments__c;
    global String Email_Status__c;
    global String API_ID__c;
    global String Contact_Type__c;
    global String Campaign_Name_and_Status__c;
    global String Company_Name__c;
    global String Dietary_Restrictions__c;
    /* Calculates Campaign Members who have status = Attended
    */
    global Double Attendee_Count_Formula__c;
    /* How many guests related to this Campaign Member are attending this event?
    */
    global Double Attending_Guests__c;
    /* How many guests related to this Campaign Member are registered for event?
    */
    global Double Registered_Guests__c;
    /* Read-Only Field Updated by Field Update Workflow Rule: Registered_Status_Ever_Campaign_Member.
    */
    global Double Registered_Status_Ever_Count__c;
    global Double Total_Checked_In_Formula__c;
    /* Calculates Total of All Campaign Members Status = “Registered” Plus Total # in Registered Guests Field.
    */
    global Double Total_Registered_Formula__c;
    global String Dietary_Restriction__c;
    global Double Power_of_1__c;
    /* The number of intended units (early booking contest)
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
    global String Sentiment__c;
    global String Level_Of_Interest__c;
    global String Commitment__c;
    global String Number_Of_Attempts__c;
    global Boolean TSR_Follow_Up__c;
    global Account Preferred_Retailer1__c;

    global CampaignMemberChangeEvent () 
    {
    }
}