/********************************************************************************************
    * Description:  Generic Utils
    *               A list of generic helper classes
    * ------------------------------------------------------------------------------------------
    * Date          Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 08-Jan-2017   Sruthi            Created          
    ********************************************************************************************/
public class GenericUtils {


   //maps to hold the record type info

    private static Map<String,Map<Id,RecordType>> recordTypesById = new Map<String,Map<Id,RecordType>>();
    private static Map<String,Map<String,RecordType>> recordTypesByName = new Map<String,Map<String,RecordType>>();
    private static Map<String, String> profileMap = new Map<String,String>();

    private static void fillMapsForRecordTypeObject(string objectName) {
        // get the object recordtypes
        if (!recordTypesById.containsKey(objectName)) {
            Map<Id,RecordType> tmpRecordTypesById = new Map<Id,RecordType>([select id, name, developername from RecordType where sobjecttype = :objectName]);

            //System.debug('ids:' + tmpRecordTypesById);
            recordTypesById.put(objectName, tmpRecordTypesById);

            Map<String, RecordType> tmpRecordTypesByName = new Map<String, Recordtype>();
            For(RecordType rt : tmpRecordTypesById.values()){
                //System.debug(rt);
                tmpRecordTypesByName.put(rt.developername, rt);
            }

            recordTypesByName.put(objectName, tmpRecordTypesByName);
        }
    }

    /*public static Id getRecordTypeId(String objectName, String recordTypeName) {
        // make sure we have this object's record types mapped
        if (!recordTypesByName.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);

        // now grab and return the requested id
        Map<String,RecordType> rtMap = recordTypesByName.get(objectName);
        if (rtMap != null && rtMap.containsKey(recordTypeName)) {
            return rtMap.get(recordTypeName).id;
        } else {
            return null;
        }
    }

    public static String getRecordTypeDeveloperName(String objectName, Id recordTypeId) {
        // make sure we have this object's record types mapped
        if (!recordTypesById.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);

        // now grab and return the requested id
        Map<Id,RecordType> rtMap = recordTypesById.get(objectName);
        if (rtMap != null && rtMap.containsKey(recordTypeId)) {
            return rtMap.get(recordTypeId).Developername;
        } else {
            return null;
        }
    }

    public static String getRecordTypeName(String objectName, Id recordTypeId) {
        // make sure we have this object's record types mapped
        if (!recordTypesById.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);

        // now grab and return the requested id
        Map<Id,RecordType> rtMap = recordTypesById.get(objectName);
        if (rtMap != null && rtMap.containsKey(recordTypeId)) {
            return rtMap.get(recordTypeId).name;
        } else {
            return null;
        }
    }

    public static RecordType getRecordType(String objectName, String developerName) {
        if (!recordTypesByName.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);

        // now grab and return the requested id
        Map<String,RecordType> rtMap = recordTypesByName.get(objectName);
        if (rtMap != null && rtMap.containsKey(developerName)) {
            return rtMap.get(developerName);
        } else {
            return null;
        }
    }*/

    public static Map<String, Id> GetRecordTypeIdsByDeveloperName(
            Schema.SObjectType token
    ) {
        Map<String, Id> listOFDeveloperNametoId = new Map<String, Id>();

        String objectName = token.getDescribe().getName();

        // make sure we have this object's record types mapped
        if (!recordTypesById.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);


        // now grab and return the requested id
        Map<Id,RecordType> rtMap = recordTypesById.get(objectName);
        for(RecordType rt : rtMap.values()){
            listOFDeveloperNametoId.put(rt.developername, rt.id);
        }

        return listOFDeveloperNametoId;

    }

   /* public static Map<String, Id> getRecordTypes(String objectName) {

        Map<String, Id> listOFDeveloperNametoId = new Map<String, Id>();

        // make sure we have this object's record types mapped
        if (!recordTypesById.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);


        // now grab and return the requested id
        Map<Id,RecordType> rtMap = recordTypesById.get(objectName);
        for(RecordType rt : rtMap.values()){
            listOFDeveloperNametoId.put(rt.developername, rt.id);
        }

        return listOFDeveloperNametoId;
    }

    public static Map<String, Id> getRecordTypesAvailableForUser(String objectName) {

        Map<String, Id> listOFDeveloperNametoId = new Map<String, Id>();

        // make sure we have this object's record types mapped
        if (!recordTypesById.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);


        // Get the Describe Result
        Schema.DescribeSObjectResult obj = Schema.getGlobalDescribe().get(objectName).getDescribe();

        // Obtain the RecordTypeInfos for this SObjectType token
        Map<Id,Schema.RecordTypeInfo> recordTypeInfos = obj.getRecordTypeInfosByID();

        // now grab and return the requested id
        Map<Id,RecordType> rtMap = recordTypesById.get(objectName);
        for(RecordType rt : rtMap.values()){
            if (recordTypeInfos.get(rt.Id).isAvailable()) {
                listOFDeveloperNametoId.put(rt.developername, rt.id);
            }

        }

        return listOFDeveloperNametoId;
    }

    //jl: added for Map of record types
    public static Map<String, RecordType> getRecordTypesObjsAvailableForUser(String objectName) {

        Map<String, RecordType> listOFDeveloperNametoId = new Map<String, RecordType>();

        // make sure we have this object's record types mapped
        if (!recordTypesById.containsKey(objectName))
            fillMapsForRecordTypeObject(objectName);


        // Get the Describe Result
        Schema.DescribeSObjectResult obj = Schema.getGlobalDescribe().get(objectName).getDescribe();

        // Obtain the RecordTypeInfos for this SObjectType token
        Map<Id,Schema.RecordTypeInfo> recordTypeInfos = obj.getRecordTypeInfosByID();

        // now grab and return the requested id
        Map<Id,RecordType> rtMap = recordTypesById.get(objectName);
        for(RecordType rt : rtMap.values()){
            if (recordTypeInfos.get(rt.Id).isAvailable()) {
                listOFDeveloperNametoId.put(rt.developername, rt);
            }

        }

        return listOFDeveloperNametoId;
    }*/

   /* HLT @testVisible
    public static User runningUser  {
        get {
            if (runningUser == null){
//          Added additional User fields to replace Process SYT_Opportunity_LAN_SetApprovers (US-132519)
                runningUser = [SELECT Id, Profile.Name, User_Country__c, Controller__c, CU_Head__c, Head_of_Sales_Sugarbeet__c,
                        Product_Development_Agronomy_Manager__c, Account_Development_Manager__c, CU_Head_Veg__c,
                        Agronomy_Service_Rep__c
                FROM User
                WHERE Id=:UserInfo.getUserId()];            }
            return runningUser;
        }
        private set;
    } */

}