// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SurveyVersion {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global Survey Survey;
    global Id SurveyId;
    global Integer VersionNumber;
    global String SurveyStatus;
    global BrandingSet BrandingSet;
    global Id BrandingSetId;
    global String Description;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<SurveyPage> SurveyPages;
    global List<SurveyQuestion> SurveyQuestions;
    global List<SurveyQuestionScore> SurveyQuestionScores;
    global List<SurveyResponse> SurveyResponses;
    global List<FlowRecordRelation> RelatedRecord;
    global List<Survey> ActiveVersion;
    global List<Survey> LatestVersion;
    global List<SurveyQuestionChoice> SurveyVersion;

    global SurveyVersion () 
    {
    }
}