// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SurveyResponse {
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
    global SurveyInvitation Invitation;
    global Id InvitationId;
    global FlowInterview Interview;
    global Id InterviewId;
    global String InterviewGuid;
    global SObject Submitter;
    global Id SubmitterId;
    global String Status;
    global String Language;
    global Datetime CompletionDateTime;
    global String IpAddress;
    global Double Latitude;
    global Double Longitude;
    global Location Location;
    global SurveyVersion SurveyVersion;
    global Id SurveyVersionId;
    global Survey Survey;
    global Id SurveyId;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<SurveyQuestionResponse> SurveyQuestionResponses;
    global List<SurveySubject> SurveySubjects;
    global List<FlowRecordRelation> RelatedRecord;

    global SurveyResponse () 
    {
    }
}