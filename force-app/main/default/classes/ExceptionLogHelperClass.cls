/********************************************************************************************
* Class:        ExceptionLogHelperClass
* Description:  Helper class to create instantiate Exception Log Record 
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
*02-Feb-2018    Sravani     Modified          
********************************************************************************************/
public class ExceptionLogHelperClass {
    
 /********************************************************************************************
 * Method   : createExceptionLogRecord
 * Description: To provide Exception Log
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 02/Feb/2018  Srni       Modified     
 ********************************************************************************************/
    public static Exception_Log__c createExceptionLogRecord(String objectName, String recordIds, String sourceClass, String sourceMethod, String exceptionType, Id userId, String exceptionStacktrace, String transactionCode, String exceptionMessage){
        return privatecreateExceptionLogRecord(objectName, recordIds, sourceClass, sourceMethod, exceptionType, userId, exceptionStacktrace, transactionCode, exceptionMessage);
    }

 /********************************************************************************************
 * Method   : createExceptionLogRecord
 * Description: To provide Exception Log
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 02/Feb/2018  Srni       Modified     
 ********************************************************************************************/    
    public static Exception_Log__c createExceptionLogRecord(String objectName, String recordIds, String sourceClass, String sourceMethod, String exceptionType, Id userId, String exceptionStacktrace, String exceptionMessage){
                return privatecreateExceptionLogRecord(objectName, recordIds, sourceClass, sourceMethod, exceptionType, userId, exceptionStacktrace, ' ', exceptionMessage);
    }
 /********************************************************************************************
 * Method   : privatecreateExceptionLogRecord
 * Description: To provide Exception Log and to call inside public methods
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 02/Feb/2018  Srni       Created     
 ********************************************************************************************/
    static Exception_Log__c privatecreateExceptionLogRecord(String objectName, String recordIds, String sourceClass, String sourceMethod, String exceptionType, Id userId, String exceptionStacktrace, String transactionCode, String exceptionMessage){
        Exception_Log__c exceptionLogRecord = new Exception_Log__c();
        
        exceptionLogRecord.Object_Name__c = objectName;
        exceptionLogRecord.Record_Ids__c = recordIds;
        exceptionLogRecord.Source_class__c = sourceClass;
        exceptionLogRecord.Source_Method__c = sourceMethod;
        exceptionLogRecord.Exception_Type__c = exceptionType;
        exceptionLogRecord.User__c = userId;
        exceptionLogRecord.Exception_stacktrace__c = exceptionStacktrace;
        exceptionLogRecord.Transaction_Code__c = transactionCode;
        exceptionLogRecord.Exception__c = exceptionMessage;
        
        return exceptionLogRecord;
    }
}