/*	Jan 26, 2015
 * 	Brian Hopkins
 * 	This is a utility class of static variables and functions, such as profile and record type data.
 * 	Triggers and classes can use this, to save on SOQL queries.  Since they're static, the queries will only
 * 	be done the first time they are each referenced.
 *  
 * 	There are also a couple other useful functions for test classes
*/  
public class CLS_StaticUtils {
    
    public static Map<Id,RecordType> RecordTypeMap{ 
        get{
            if (RecordTypeMap == null){
	            RecordTypeMap = new Map<Id,RecordType>([Select Id, Name, DeveloperName, SObjectType from RecordType]);
            }
            return RecordTypeMap;
        }
        private set;
    }
    
    public static ID getRecordTypeId(String SObj, String devname){
        for(RecordType rt : RecordTypeMap.values()){
            if (rt.SobjectType.equals(SObj) && rt.DeveloperName.equals(devname)){
                return rt.id;
            }
        }
        return null;
    }
    
	public static User createTestUser(Id roleId, Id profID, String fName, String lName) {
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tuser = new User(  firstname = fName,
                                lastName = lName,
                                email = uniqueName + '@test' + orgId + '.org',
                                Username = uniqueName + '@test' + orgId + '.org',
                                EmailEncodingKey = 'ISO-8859-1',
                                Alias = uniqueName.substring(18, 23),
                                TimeZoneSidKey = 'America/New_York',
                                LocaleSidKey = 'en_CA',
                                LanguageLocaleKey = 'en_US',
                                ProfileId = profId,
                                UserRoleId = roleId);
        return tuser;
    }
    
}