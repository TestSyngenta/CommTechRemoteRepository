/**************************************************************************************
* Apex Class Name    :     Test_UtilityClass
* Version            :     1.0
* Created Date       :     05/Feb/2018
* Function           :     This is Test class for GenericUtils
* Developer          :     Hema                     
*************************************************************************************/
@istest
public class GenericUtilsTest {
    public static Id recordTypeId;
    public static Id CUseedsrecordTypeId;
    Public Static Opportunity opp;
    Public Static String recordtype;
    static TestMethod void GetRecordTypeIdsByDeveloperNameTest(){
        recordtype = label.CU_SeedsSalesPlan;
        test.startTest();
        RecordType rt;
        //opp = [select id, recordtypeid from opportunity where recordtype.developername =: recordtype limit 1];
        rt = [select id from RecordType where developername =: recordtype limit 1];
        CUseedsrecordTypeId = rt.id;
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        recordTypeId = oppRecordtypes.get(label.CU_SeedsSalesPlan); 
        system.assertEquals(CUseedsrecordTypeId, recordTypeId);
        test.stopTest();
    }
}