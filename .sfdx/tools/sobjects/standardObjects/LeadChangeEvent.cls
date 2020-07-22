// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class LeadChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String LastName;
    global String FirstName;
    global String Salutation;
    global String Name;
    global String Title;
    global String Company;
    global String Street;
    global String City;
    global String State;
    global String PostalCode;
    global String Country;
    global String StateCode;
    global String CountryCode;
    global Double Latitude;
    global Double Longitude;
    global String GeocodeAccuracy;
    global Address Address;
    global String Phone;
    global String MobilePhone;
    global String Email;
    global String LeadSource;
    global String Status;
    global String Industry;
    global Integer NumberOfEmployees;
    global User Owner;
    global Id OwnerId;
    global Boolean HasOptedOutOfEmail;
    global Boolean IsConverted;
    global Date ConvertedDate;
    global Account ConvertedAccount;
    global Id ConvertedAccountId;
    global Contact ConvertedContact;
    global Id ConvertedContactId;
    global Opportunity ConvertedOpportunity;
    global Id ConvertedOpportunityId;
    global Boolean IsUnreadByOwner;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global String JigsawContactId;
    global String EmailBouncedReason;
    global Datetime EmailBouncedDate;
    global Individual Individual;
    global Id IndividualId;
    global String pi__campaign__c;
    global String pi__comments__c;
    global Datetime pi__conversion_date__c;
    global String pi__conversion_object_name__c;
    global String pi__conversion_object_type__c;
    global Datetime pi__created_date__c;
    global Datetime pi__first_activity__c;
    global String pi__first_search_term__c;
    global String pi__first_search_type__c;
    global String pi__first_touch_url__c;
    global String pi__grade__c;
    global Datetime pi__last_activity__c;
    global String pi__notes__c;
    global Double pi__score__c;
    global String pi__url__c;
    global String pi__utm_campaign__c;
    global String pi__utm_content__c;
    global String pi__utm_medium__c;
    global String pi__utm_source__c;
    global String pi__utm_term__c;
    global Boolean pi__pardot_hard_bounced__c;
    global String Pardot_First_Name__c;
    global String Pardot_Last_Name__c;
    global Boolean Pardot_Do_Not_Email__c;
    global String Account_Name__c;
    global String Reviewed_Status__c;
    global Boolean smagicinteract__SMSOptOut__c;
    global String Primary_Source_Activity__c;
    global String Lead_Type__c;
    global String API_Lead_ID__c;
    global String Dietary_Restriction__c;
    global Double Registered_Guests__c;
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
    global Boolean Do_Not_Email__c;
    /* Emails sent to this email address were refused by the email provider. Either the email address no longer exists or messages were refused at least 5 times for reasons such as full mailbox, etc.
    */
    global Boolean Email_Bounced__c;
    global String Opt_in_ECom__c;
    global Boolean Pardot_DNE_Reset_Required__c;
    global String Pardot_Implied_Consent__c;
    global String Pardot_Mailable__c;
    global String Pardot_Opt_In_Email_Communications__c;
    global Date Pardot_Implied_Consent_Expiry_Date__c;
    global Boolean TempGuestFlag__c;
    global Double Registered_Guests_Dec619__c;
    global String wint__WebsiteAccountMatchingKey2__c;
    global String wint__WebsiteAccountMatchingKey__c;
    global String Pardot_URL_from_Pardot__c;
    global Boolean Pardot_Formula__c;

    global LeadChangeEvent () 
    {
    }
}