// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class CaseChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String CaseNumber;
    global Contact Contact;
    global Id ContactId;
    global Account Account;
    global Id AccountId;
    global SObject Source;
    global Id SourceId;
    global String SuppliedName;
    global String SuppliedEmail;
    global String SuppliedPhone;
    global String SuppliedCompany;
    global String Type;
    global RecordType RecordType;
    global Id RecordTypeId;
    global String Status;
    global String Reason;
    global String Origin;
    global String Language;
    global String Subject;
    global String Priority;
    global String Description;
    global Boolean IsClosed;
    global Datetime ClosedDate;
    global User Owner;
    global Id OwnerId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Boolean French_Call__c;
    global String Field_Name__c;
    global String Call_Duration__c;
    global String Account_Type__c;
    global Double Acres_Affected__c;
    global Double Acres_Planted__c;
    global String Adjuvant_Rate__c;
    global String Legal_Land_Description__c;
    global String Adjuvant__c;
    global Double Affected_Amount__c;
    /* Acreage (or other UOM) with symptoms.  This amount is generally less than the treated area (except for drift).
    */
    global Double Affected_Area__c;
    global String Affected_Plant_Part__c;
    global Boolean No_Settlement_Required__c;
    global String Review_Status__c;
    global String Alleged_Problem_PQ__c;
    global String Controlled_2nd_Pest__c;
    global String Amount_UOM__c;
    global Date Application_Date__c;
    global String Application_Method__c;
    global Boolean Fortenza__c;
    global String Application_Rate_UOM__c;
    global Double Application_Rate__c;
    global Boolean Lumiderm__c;
    global String Application_Timing__c;
    global Pest__c Secondary_Pest__c;
    global String Applied_By__c;
    /* Date Enhancement approved.
    */
    global Date Approved_Date__c;
    global String Stage_2nd_Pest__c;
    global String Competitor_Offer__c;
    global String Competitor_Product__c;
    global Double Field_Size__c;
    global String Competitor__c;
    global String Payment_Calculation__c;
    global Decimal Potential_Exposure__c;
    global String Program_Name__c;
    global String BatchCode__c;
    global String Budget_Code_Formula__c;
    global String Reason_for_Exception__c;
    global String Budget_Code_Reporting__c;
    global String Scope_of_Offer__c;
    global String Year__c;
    global String CROPID__c;
    global String CU_Code__c;
    global String Assurance_Offer__c;
    global Datetime Call_End__c;
    global Datetime Call_Start__c;
    global String Call_Status__c;
    /* Case Age (Days)
    */
    global Double Case_Age__c;
    global String Damage__c;
    global String Damage_2nd_Pest__c;
    /* Check for customer that should not be included in the CIC follow up survey.
    */
    global Boolean Do_Not_Contact_for_Survey__c;
    global String ProductFilter_Picklist__c;
    global String Reason_for_Payment__c;
    global String Payment_Type__c;
    global String Category__c;
    global Boolean validcontact__c;
    global String Comments__c;
    /* Include name, date and all details relevant to the case (additional Pests, Fields and description of the complaint).
    */
    global String Case_Comments__c;
    /* A follow up survey has been completed by the CIC.
    */
    global Boolean Survey_Completed__c;
    global String Complaint_Justified__c;
    global String Complaint_Origin__c;
    /* Reported in Product Unit of Measure.
    */
    global Double Complaint_Quantity__c;
    global String Complaint_Type__c;
    /* From Lot Number
    */
    global String VDFCC_Batch__c;
    global String Case_Category_Old__c;
    global String Year_Opened__c;
    global String Crop_Name_Species__c;
    /* Refers to unit of measurement for the price field.
    */
    global String Crop_UOM__c;
    global User Assigned_To__c;
    global Boolean Replant__c;
    global Double Hour_of_Call__c;
    global Double Duration_of_Call__c;
    global String Correct_Pay_To__c;
    /* Indicate parent and all child accounts for the household with account numbers.
    */
    global String PI_Details__c;
    /* Include Invoice Number, Date, Product and Quantity for all missing invoices.  Attach all invoices to the case.
    */
    global String Invoice_Details__c;
    global Boolean Payment_Issue__c;
    global String Delivery_BOL__c;
    global Date Delivery_Date__c;
    global String Resolution_Comments__c;
    global String Details__c;
    global String Resolution_Status__c;
    /* Include all details to complete the retail change.
    */
    global String Retail_Change_Details__c;
    global String Retail_Change__c;
    global String of_Attempts__c;
    global String Question_1__c;
    global String Question_2__c;
    global String Question_3__c;
    global String Field_Area_UOM__c;
    global Date Grower_Detect_Date__c;
    global String Question_4__c;
    global String Hybrid_Variety__c;
    global String Question_5__c;
    global Date InspectDate__c;
    global String Intelix_Reliance_No__c;
    global String Invoice__c;
    global String CIC_Brand__c;
    global String Case_Category__c;
    global String Issue_Type_PQ_Dependant__c;
    global String Issue_Type_Seeds_Dependent__c;
    global Boolean Detection_date_is_valid__c;
    global String Brand__c;
    global Double of_Replants__c;
    global Double Total_Units_Affected__c;
    /* Check this box if any non-Syngenta party to the complaint has retained legal counsel.
    */
    global Boolean Legal_Involvement__c;
    global Account Duplicate_Account__c;
    /* Please enter all lot numbers on separate lines.
    */
    global String LotNumber__c;
    global Double File_Count__c;
    global String Account__c;
    global String Order__c;
    global Decimal Original_Price_Unit__c;
    global String PQA__c;
    global String Duplicate_Account_No__c;
    /* Reported in Product Unit of Measure.
    */
    global Double Pickup_Quantity__c;
    global Date Planting_Date__c;
    global String Planting_Depth_UOM__c;
    global Double Planting_Depth__c;
    /* The date that the issue was identified
    */
    global Date Date_Identified__c;
    /* The date by which the issue is expected to be resolved
    */
    global Date Estimated_Completion_Date__c;
    /* The date by which the issue was actually resolved
    */
    global Date Actual_Completion_Date__c;
    /* Any case ID's associated with this issue. Please put each ID on a new line!
    */
    global String Associated_ID_s__c;
    /* A summary of the impact of the issue
    */
    global String Impact_Summary__c;
    global String Product_ID__c;
    /* What actions will be taken in order to resolve the issue?
    */
    global String Action_Steps__c;
    global Double Product_Quantity__c;
    global Product2 Product__c;
    /* What was the final resolution for the issue, and what were the reasons for choosing it?
    */
    global String Final_Resolution_and_Rationale__c;
    global String Business_Unit__c;
    global String Question__c;
    global User Project_Manager_1__c;
    global User Project_Manager_2__c;
    global User Project_Manager_3__c;
    global String Purchased_From_City__c;
    global String Call_Sentiment__c;
    global String Seed_Reliance_Complaint_Type__c;
    global String Seed_Reliance_Issue_Type__c;
    global Boolean Fortenza_Advanced__c;
    global String Crop_Exceptions__c;
    global String Related_Site__c;
    global String Soil_Moisture__c;
    global String Soil_Organic_Matter__c;
    global String Soil_Texture__c;
    global Double Soil_pH__c;
    global String Symptom__c;
    global String Tank_Mix_Product_1__c;
    global String Tank_Mix_Product_2__c;
    global String Total_Units_Purchased_UOM__c;
    global Double Total_Units_Purchased__c;
    /* Total acreage (or other UOM) receiving application.
    */
    global Double Treated_Area__c;
    global String UOM__c;
    /* Please explain what happened to quality-impaired inventory that cannot be returned.
    */
    global String Unreturnable_Units_Disposition__c;
    global Double k_Seeds_Per_Acre__c;
    global Double of_Cases__c;
    global Double of_Units_Affected__c;
    global Double of_Units_Physically_Returned__c;
    global Double of_Units_Physically_Unreturnable__c;
    global Double Settlements_in_Approval__c;
    global Double Total_of_Settlements__c;
    global Double of_Open_Settlements__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    /* Check the box if AgCall Rep completed the PSE.
    */
    global Boolean Completed_by_AgCall__c;
    /* Add a Retailer for PSEs created on Grower accounts or a Distributor for PSEs created on Retailer accounts.
    */
    global Account Purchased_From__c;
    global Crop__c Crop__c;
    global String Variety__c;
    global String Crop_Stage_at_Application__c;
    global String Controlled__c;
    /* Include any additional pests in the comments field.
    */
    global Pest__c Pest__c;
    global String Stage__c;

    global CaseChangeEvent () 
    {
    }
}