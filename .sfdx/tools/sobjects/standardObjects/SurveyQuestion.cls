// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class SurveyQuestion {
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
    global SurveyVersion SurveyVersion;
    global Id SurveyVersionId;
    global SurveyPage SurveyPage;
    global Id SurveyPageId;
    global String QuestionType;
    global String DeveloperName;
    global Boolean IsDeprecated;
    global String QuestionName;
    global List<ActivityHistory> ActivityHistories;
    global List<EmailMessage> Emails;
    global List<Event> Events;
    global List<EventRelation> EventRelations;
    global List<OpenActivity> OpenActivities;
    global List<SurveyQuestionChoice> QuestionChoices;
    global List<SurveyQuestionResponse> SurveyQuestionResponses;
    global List<SurveyQuestionScore> SurveyQuestionScores;
    global List<Task> Tasks;
    global List<TaskRelation> TaskRelations;
    global List<TopicAssignment> TopicAssignments;
    global List<EventChangeEvent> What;
    global List<EventRelationChangeEvent> Relation;
    global List<FlowRecordRelation> RelatedRecord;
    global List<TaskChangeEvent> What;
    global List<TaskRelationChangeEvent> Relation;

    global SurveyQuestion () 
    {
    }
}