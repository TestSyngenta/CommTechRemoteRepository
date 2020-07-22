// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class GridBuddy_Visibility__ChangeEvent {
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
    global String Country__c;
    global String GB_Admin__c;
    global Boolean IsActive__c;
    global String Last_Deployment__c;
    global String Last_Submission__c;
    global String Object__c;
    global String Record_Type__c;
    global Boolean Submit_to_deployment__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Eight_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using.

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Eight_Label_Source__c;
    global String Tab_Eight_Label_Type__c;
    global String Tab_Eight_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Eight_Relation__c;
    global String Tab_Eight_URL__c;
    global Boolean Tab_Eight_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Eleven_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using.

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Eleven_Label_Source__c;
    global String Tab_Eleven_Label_Type__c;
    /* Name of the grid that will load in this tab. Use the 2-digit country code for a region-specific grid.
    */
    global String Tab_Eleven_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Eleven_Relation__c;
    global String Tab_Eleven_URL__c;
    global Boolean Tab_Eleven_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Fifteen_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Fifteen_Label_Source__c;
    global String Tab_Fifteen_Label_Type__c;
    global String Tab_Fifteen_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Fifteen_Relation__c;
    global String Tab_Fifteen_URL__c;
    global Boolean Tab_Fifteen_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Five_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Five_Label_Source__c;
    global String Tab_Five_Label_Type__c;
    global String Tab_Five_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Five_Relation__c;
    global String Tab_Five_URL__c;
    global Boolean Tab_Five_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Four_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Four_Label_Source__c;
    global String Tab_Four_Label_Type__c;
    global String Tab_Four_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Four_Relation__c;
    global String Tab_Four_URL__c;
    global Boolean Tab_Four_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Fourteen_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Fourteen_Label_Source__c;
    global String Tab_Fourteen_Label_Type__c;
    global String Tab_Fourteen_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Fourteen_Relation__c;
    global String Tab_Fourteen_URL__c;
    global Boolean Tab_Fourteen_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Nine_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Nine_Label_Source__c;
    global String Tab_Nine_Label_Type__c;
    global String Tab_Nine_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Nine_Relation__c;
    global String Tab_Nine_URL__c;
    global Boolean Tab_Nine_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_One_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using.
    */
    global String Tab_One_Label_Source__c;
    global String Tab_One_Label_Type__c;
    global String Tab_One_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_One_Relation__c;
    global String Tab_One_URL__c;
    global Boolean Tab_One_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Seven_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Seven_Label_Source__c;
    global String Tab_Seven_Label_Type__c;
    global String Tab_Seven_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Seven_Relation__c;
    global String Tab_Seven_URL__c;
    global Boolean Tab_Seven_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Six_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Six_Label_Source__c;
    global String Tab_Six_Label_Type__c;
    global String Tab_Six_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Six_Relation__c;
    global String Tab_Six_URL__c;
    global Boolean Tab_Six_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Sixteen_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Sixteen_Label_Source__c;
    global String Tab_Sixteen_Label_Type__c;
    global String Tab_Sixteen_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Sixteen_Relation__c;
    global String Tab_Sixteen_URL__c;
    global Boolean Tab_Sixteen_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Ten_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Ten_Label_Source__c;
    global String Tab_Ten_Label_Type__c;
    global String Tab_Ten_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Ten_Relation__c;
    global String Tab_Ten_URL__c;
    global Boolean Tab_Ten_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Thirteen_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Thirteen_Label_Source__c;
    global String Tab_Thirteen_Label_Type__c;
    global String Tab_Thirteen_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Thirteen_Relation__c;
    global String Tab_Thirteen_URL__c;
    global Boolean Tab_Thirteen_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Three_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Three_Label_Source__c;
    global String Tab_Three_Label_Type__c;
    global String Tab_Three_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Three_Relation__c;
    global String Tab_Three_URL__c;
    global Boolean Tab_Three_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Twelve_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Twelve_Label_Source__c;
    global String Tab_Twelve_Label_Type__c;
    global String Tab_Twelve_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Twelve_Relation__c;
    global String Tab_Twelve_URL__c;
    global Boolean Tab_Twelve_Visible__c;
    /* Use the API name of the field that connects the parent object on the grid to the page the grid is embedded on (e.g. "AccountId" on a Contact grid embedded on the Account detail page). Maps to the GridBuddy fpf URL parameter.
    */
    global String Tab_Two_Field__c;
    /* Please enter the Name of the Object or Custom Label (API Name) that you're using. 

To setup Custom Label: Setup | Custom Label : please set up API name with "GB_ "prefix and Category = "Gridbuddy"
    */
    global String Tab_Two_Label_Source__c;
    global String Tab_Two_Label_Type__c;
    global String Tab_Two_Page__c;
    /* Value on the object page will filter the grid (e.g. 'Id'). Maps to the GridBuddy fpv URL parameter.
    */
    global String Tab_Two_Relation__c;
    global String Tab_Two_URL__c;
    global Boolean Tab_Two_Visible__c;
    /* Populated by workflow: Object__c & "|" & Record_Type__c& "|"Country__c
e.g. Account|Grower|Default
    */
    global String Unique_Key__c;
    global Double Version__c;
    global String Your_Record_Permission__c;

    global GridBuddy_Visibility__ChangeEvent () 
    {
    }
}