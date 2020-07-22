// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Commercial_Experience_Demos__c {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global RecordType RecordType;
    global Id RecordTypeId;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Date LastActivityDate;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String Activating_Rain_within_7_days_of_applica__c;
    global String Additional_Comments__c;
    global String Age__c;
    global Double Air_temperature__c;
    global Date Application_Date__c;
    global String Application_Issues__c;
    global String Application_Staging__c;
    global String Application_Timing__c;
    global String Combine_Speed_Difference__c;
    global String Comments_Application__c;
    global String Comments_First_Field_Visit__c;
    global String Comments_Second_Field_Visit__c;
    global String Comments__c;
    global String Commercial_Experience_Reference__c;
    /* Links to the Pre-Commercial Record (If Required)
    */
    global Customer_Experience_Trials__c Commercial_Trials_Reference__r;
    /* Links to the Pre-Commercial Record (If Required)
    */
    global Id Commercial_Trials_Reference__c;
    global Double Competitor_1_DON_ppm__c;
    global Double Competitor_1_FDK__c;
    global Double Competitor_1_Yield_bu_ac__c;
    global Double Competitor_2_DON_ppm__c;
    global Double Competitor_2_FDK__c;
    global Double Competitor_2_Yield_bu_ac__c;
    global String Competitor_Product_1__c;
    global String Competitor_Product_2__c;
    global String Crop_Health__c;
    global String Crop_Stage_BBCH__c;
    global String Crop_Stage_Second_Visit__c;
    global String Crop_Stage__c;
    global String Crop_Stage_drop_down__c;
    global String Crop__c;
    /* 1=Low | 5=High
    */
    global String Customer_Satisfaction_Rating__c;
    global String Disease_2__c;
    global String Disease_First__c;
    global String Disease_Pressure_1__c;
    global String Disease_Pressure_2__c;
    global String District__c;
    global Date Drone_Consent_Date__c;
    /* I consent to the Syngenta Group operating one or more remotely piloted aircraft systems at the address identified above (the “Property”).
    */
    global Boolean Drone_Consent__c;
    /* (Does Not Apply To CASL) - I consent to receiving communications by electronic means (including telephone, fax, email, text message, instant message, social media and email) from the Syngenta Group.
    */
    global Boolean Electronic_Messages_Consent__c;
    global Date First_Visit_Date__c;
    global Account Grower__r;
    global Id Grower__c;
    global String Main_Weeds_Present_1__c;
    global String Main_Weeds_Present_2__c;
    global String Main_Weeds_Present_3__c;
    global String Main_Weeds_Present_Second__c;
    global String Main_weeds_present__c;
    global String Miravis_Ace_Adjuvant__c;
    global Double Miravis_Ace_DON_ppm__c;
    global Double Miravis_Ace_FDK__c;
    global Double Miravis_Ace_Yield_bu_ac__c;
    global Double Miravis_Neo_Yield_bu_ac__c;
    global String Notes__c;
    /* I consent to the collection and use by the Syngenta Group of a) my likeness and/or voice and/or transcript as taken from video, photography or any other material or means; and b) images and/or video created by me, and for which I have ownership
    */
    global Boolean Photo_Video_and_Testimonial_ConsentPhot__c;
    global Boolean Photos_Taken_Second_Visit__c;
    global Boolean Photos_Taken__c;
    global Date Planting_Date__c;
    global String Previous_Crop__c;
    global Double Product_Rate_L_ha__c;
    global String Reference__c;
    global Account Retailer__r;
    global Id Retailer__c;
    global Double Row_Spacing_Inches__c;
    global String Satisfied_With_Product_Performance__c;
    global Date Second_Field_Visit_Date__c;
    global String Tank_mix_partner_Miravis__c;
    global Double Seed_Entry_Yield_bu_ac__c;
    /* I consent to the collection and use by the Syngenta Group of my personal information, including my contact information, property information, yield and agronomic data as taken from video, photography or any other material or means.
    */
    global Boolean Testimonial_Data_Consent__c;
    global String Tillage__c;
    global String Timings__c;
    global Boolean Untreated_Check__c;
    global Double Untreated_DON_ppm__c;
    global Double Untreated_FDK__c;
    global Double Untreated_Yield_bu_ac__c;
    global Double Product_Rate_L_ac__c;
    global Boolean Waiver_Release_Form_Signed__c;
    global String Weed_Pressure_1__c;
    global String Weed_Pressure_2__c;
    global String Weed_Pressure_3__c;
    global String Weed_Pressure_Second_Visit__c;
    global String Weed_Stage_1__c;
    global String Weed_Stage_2__c;
    global String Weed_Stage_3__c;
    global String Weed_pressure_for_each_weed_listed__c;
    global Boolean Willing_To_Do_Testimonial__c;
    global String Would_Consider_Using_Acuron_Flexi_Again__c;
    global String Would_You_Recommend_This_Product__c;
    global String Wuld_consider_using_product_again__c;
    global String X2_Comments__c;
    global String X2_Main_Weeds_Present_1__c;
    global String X2_Main_Weeds_Present_2__c;
    global String X2_Main_Weeds_Present_3__c;
    global String X2_Weed_Pressure_1__c;
    global String X2_Weed_Pressure_2__c;
    global String X2_Weed_Pressure_3__c;
    global String X2_Weed_Stage_1__c;
    global String X2_Weed_Stage_2__c;
    global String X2_Weed_Stage_3__c;
    global String Year__c;
    global String Tank_mix_partner__c;
    global String Soil_Type__c;
    global String Population__c;
    global String Variety__c;
    global String Variety_Text__c;
    global String Product_Acuron__c;
    global Double file_count__c;
    global Boolean File_Count_Check__c;
    global Boolean Attached_Picture_s__c;
    global Boolean Attached_Video_s__c;
    global String Attachment_Details__c;
    global List<ActivityHistory> ActivityHistories;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<AttachedContentNote> AttachedContentNotes;
    global List<Attachment> Attachments;
    global List<CollaborationGroupRecord> RecordAssociatedGroups;
    global List<CombinedAttachment> CombinedAttachments;
    global List<Commercial_Experience_Demos__Feed> Feeds;
    global List<Commercial_Experience_Demos__History> Histories;
    global List<ContactRequest> ContactRequests;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<DuplicateRecordItem> DuplicateRecordItems;
    global List<EmailMessage> Emails;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<Note> Notes;
    global List<NoteAndAttachment> NotesAndAttachments;
    global List<OpenActivity> OpenActivities;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<RecordAction> RecordActions;
    global List<RecordActionHistory> RecordActionHistories;
    global List<SurveySubject> SurveySubjectEntities;
    global List<Task> Tasks;
    global List<TaskRelation> TaskRelations;
    global List<TopicAssignment> TopicAssignments;
    global List<ContentDistribution> RelatedRecord;
    global List<ContentVersion> FirstPublishLocation;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global Commercial_Experience_Demos__c () 
    {
    }
}