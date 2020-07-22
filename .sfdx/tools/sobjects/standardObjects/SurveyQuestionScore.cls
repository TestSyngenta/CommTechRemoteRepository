// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SurveyQuestionScore {
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
    global Survey Survey;
    global Id SurveyId;
    global SurveyVersion SurveyVersion;
    global Id SurveyVersionId;
    global SurveyInvitation SurveyInvitation;
    global Id SurveyInvitationId;
    global SurveyQuestion Question;
    global Id QuestionId;
    global SurveyQuestionChoice QuestionChoice;
    global Id QuestionChoiceId;
    global String QuestionName;
    global Double ResponseValue;
    global Double Score;
    global Integer ResponseCount;
    global String ScoreType;
    global Integer QuestionSkippedCount;
    global List<FlowRecordRelation> RelatedRecord;

    global SurveyQuestionScore () 
    {
    }
}