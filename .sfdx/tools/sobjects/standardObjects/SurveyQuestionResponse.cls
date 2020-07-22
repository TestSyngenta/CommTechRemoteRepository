// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SurveyQuestionResponse {
    global Id Id;
    global Boolean IsDeleted;
    global String ResponseShortText;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global SurveyResponse Response;
    global Id ResponseId;
    global SurveyQuestion Question;
    global Id QuestionId;
    global SurveyQuestionChoice QuestionChoice;
    global Id QuestionChoiceId;
    global SurveyVersion SurveyVersion;
    global Id SurveyVersionId;
    global SurveyInvitation Invitation;
    global Id InvitationId;
    global String Datatype;
    global Integer Rank;
    global Date DateValue;
    global Datetime DateTimeValue;
    global String ChoiceValue;
    global String ResponseValue;
    global Boolean IsTrueOrFalse;
    global Integer NumberValue;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<TopicAssignment> TopicAssignments;
    global List<FlowRecordRelation> RelatedRecord;

    global SurveyQuestionResponse () 
    {
    }
}