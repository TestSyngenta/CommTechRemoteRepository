// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class cloudx_cms__SS_Carousel_Slide__ChangeEvent {
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
    global cloudx_cms__SS_Carousel__c cloudx_cms__Carousel__c;
    global Boolean cloudx_cms__Autoplay__c;
    /* Short text for call-to-action button.
    */
    global String cloudx_cms__Button_Label__c;
    /* Add a destination URL for button. Must start with http:// or https://
    */
    global String cloudx_cms__Button_URL__c;
    /* Choose a button design: Branding Editor, Neutral, or Bare.
    */
    global String cloudx_cms__Button_Variant__c;
    /* Choose an appropriate Body text size.
    */
    global String cloudx_cms__Description_Size__c;
    /* Description text supports Hex or RGB color codes.
    */
    global String cloudx_cms__Description_Text_Color__c;
    /* Add an enticing summary of your content.
    */
    global String cloudx_cms__Description__c;
    global Double cloudx_cms__Height__c;
    /* Add an image URL. Must start with http:// or https:// for external pages.
    */
    global String cloudx_cms__Image_URL__c;
    global Boolean cloudx_cms__Loop_Video__c;
    /* Raw MP4 Video URL
    */
    global String cloudx_cms__Raw_MP4_Video_URL__c;
    /* Raw Video URL in OGG Format
    */
    global String cloudx_cms__Raw_OGG_Video_URL__c;
    /* Raw Video URL in Webm Format
    */
    global String cloudx_cms__Raw_WEBM_Video_URL__c;
    /* Show Video Controls - Play, Pause etc
    */
    global Boolean cloudx_cms__Show_Video_Controls__c;
    /* Prioritize slides in numerical order (Ie. 1, 2, 3).
    */
    global Double cloudx_cms__Slide_Order__c;
    /* Choose alignment of text: left, center, right
    */
    global String cloudx_cms__Text_Alignment__c;
    /* Caption: Height(Not applicable for overlay position. In Px)
    */
    global Double cloudx_cms__Text_Height__c;
    /* Opacity of overlay background controlled by RGBA color values.
    */
    global String cloudx_cms__Text_Overlay_Background__c;
    /* Card (bottom of image/video) or Overlay (full image/video)
    */
    global String cloudx_cms__Text_Position__c;
    /* Banner title text supports Hex color codes.
    */
    global String cloudx_cms__Title_Text_Color__c;
    /* Choose an appropriate banner title size.
    */
    global String cloudx_cms__Title_Text_Size__c;
    /* Craft a short attention-grabbing banner title.
    */
    global String cloudx_cms__Title__c;
    /* Add a video URL from YouTube or Vimeo. Must start with http:// or https://
    */
    global String cloudx_cms__Video_Embed_URL__c;

    global cloudx_cms__SS_Carousel_Slide__ChangeEvent () 
    {
    }
}