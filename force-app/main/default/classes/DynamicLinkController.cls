/********************************************************************************************
* Class:        DynamicLinkController
* Description:  Dynamic Link functionality for Formyoula
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 22-June-2018   Sravani             Created
* 19-07-2018     Sravani             Modified
********************************************************************************************/

public with sharing class DynamicLinkController {


    private final String DEFAULT_1      = 'Default';
    private final String ADMIN_ONLY     = 'Admin Only';
    private final String INTERNAL       = 'Internal';
    private final String EXTERNAL       = 'External';
    private final String STANDARD       = 'Standard';
    private final String GLOBAL_SUPPORT = 'Global Support';

    private String userTheme;
    private Set<String> classicThemes   = new Set<String> {'Theme1', 'Theme2', 'Theme3'}; //obsolete theme, theme from 2005, theme from 2010
    //private Set<String> lightningThemes = new Set<String>{'Theme4d','Theme4t'}; //Theme4d - lightning, Theme4t - SF1 mobile

    public Map<String, Map<String, List<LinkWrap>>> linkMap {get; set;}
    public Integer dlCount {get; set;}
    public Id recordId;
    public string category;
    public String buttonAction {get; set;}

    public static User runningUser  {
        get {
            if (runningUser == null || runningUser.Id != UserInfo.getUserId()){
                runningUser = [SELECT Id, Profile.Name, User_Country__c, UserRole.DeveloperName FROM User WHERE Id=:UserInfo.getUserId()];
            } 
            return runningUser;
        }
        private set;
    } 


    public DynamicLinkController() {
   }

    public PageReference onLoad() {
        if (String.isBlank(recordId)) {
            recordId = ApexPages.currentPage().getParameters().get('id');
            buttonAction   = ApexPages.currentPage().getParameters().get('action');
            category=ApexPages.currentPage().getParameters().get('category');
          
        }

        userTheme = UserInfo.getUiTheme();
        String sObjectName = getObjectName(recordId);
        List<DL_Configuration__c> dls = getDynamicLinks(sObjectName);
        dlCount = dls.size();
        if (dlCount > 0) {
            //get all fields included in a URL (sobject and user related)
            Set<String> allFields = getFields(dls);
            String fields = setToString(allFields);
            Set<String> userAllFields = getUserFields(dls);
            String userFields = setToString(userAllFields);

            SObject record = getRecord(sObjectName, fields, recordId);
            User userRecord = (User)getRecord('User', userFields, UserInfo.getUserId());

            //Apply access based on record type and user profile
            applyAccess(dls, record, sObjectName);
            populateLinkMap(dls);
            replaceFieldsInURLs(allFields, record, false);
            replaceFieldsInURLs(userAllFields, userRecord, true);
            List<LinkWrap> lwrp=linkMap.get(dls[0].DL_Type__c).get(dls[0].Category__c);
            String url=lwrp[0].link;
            System.debug('URL :'+url);
            PageReference Page = new PageReference(url);
            Page.setRedirect(true);
            return Page;
        }
        return null;
    }

    private List<DL_Configuration__c> getDynamicLinks(String sObjectName) {
        String recordtype;
        if(sObjectName=='Opportunity')
        {
            Opportunity opp=[select id,recordtype.developername from Opportunity where id=:recordId];
            recordtype=opp.recordtype.developername;
        }
        else if(sObjectName=='Business_Plan__c')
        {
            Business_Plan__c bp=[select id,recordtype.developername from Business_Plan__c where id=:recordId];
            recordtype=bp.recordtype.developername;
        }
        
        List<DL_Configuration__c> dls = [SELECT Name, Comment__c, Record_Nr__c, toLabel(DL_Type__c), Category__c,
                                            RecordType__c, Access__c, URL_Web__c, URL_SF1__c
                                            FROM DL_Configuration__c
                                            WHERE Object__c = : sObjectName
                                            AND Active__c = true
                                            AND ButtonAction__c =: buttonAction
                                            AND RecordType__c=:recordtype
                                            AND Category__c=:category];
        return dls;
    }

    private static String getObjectName(Id id) {
        String sId = '' + id;
        String keyCode  = sid.subString(0, 3);

        for (Schema.SObjectType objectInstance : Schema.getGlobalDescribe().values()) {
            if (objectInstance.getDescribe().getKeyPrefix() == keyCode) {
                return objectInstance.getDescribe().getName();
            }
        }
        return null;
    }

    
    private Set<String> getFields(List<DL_Configuration__c> dls) {
        Set<String> fields = new Set<String>();
        Pattern myPattern = Pattern.compile('\\{![^\\$]+?}');

        for (DL_Configuration__c dl : dls) {
            String url = (classicThemes.contains(userTheme) || String.isBlank(dl.URL_SF1__c)) ? dl.URL_Web__c : dl.URL_SF1__c;
            Matcher m = myPattern.matcher(url);
            while (m.find()) {
                String fieldName = m.group();
                url = url.replace(fieldName, fieldName.toLowerCase());
                fieldName = fieldName.replace('{!', '').replace('}', '');
                fields.add(fieldName.toLowerCase());
            }
            dl.URL_Web__c = url;
            dl.URL_SF1__c = url;

        }
        System.debug(LoggingLevel.DEBUG, '*** fields: ' + fields);
        return fields;
    }

    private Set<String> getUserFields(List<DL_Configuration__c>  dls) {
        Set<String> fields = new Set<String>();
        Pattern myPattern = Pattern.compile('\\{!\\$.+?}');

        for (DL_Configuration__c dl : dls) {
            String url = (classicThemes.contains(userTheme) || String.isBlank(dl.URL_SF1__c)) ? dl.URL_Web__c : dl.URL_SF1__c;
            Matcher m = myPattern.matcher(url);
            while (m.find()) {
                String fieldName = m.group();
                url = url.replace(fieldName, fieldName.toLowerCase());
                fieldName = fieldName.replace('{!$', '').replace('}', '').replace('User.', '');
                fields.add(fieldName.toLowerCase());

            }
            dl.URL_Web__c = url;
            dl.URL_SF1__c = url;
        }
        System.debug(LoggingLevel.DEBUG, '*** fields user: ' + fields);
        return fields;
    }

    private SObject getRecord(String sObjectName, String fields, Id id) {
        SObject sObj;

        fields = String.escapeSingleQuotes(fields);

        if (!hasRecodTypes(sObjectName) && fields == '') {
            return null;
        }
        if (hasRecodTypes(sObjectName)) {
            fields = (fields == '') ? 'RecordType.DeveloperName' : 'RecordType.DeveloperName, ' + fields;
        }

        String query = 'SELECT '
                       + fields
                       + ' FROM ' + sObjectName
                       + ' WHERE Id = \'' + id + '\'';
        List<sObject> records = Database.query(query);
        if (records.size() == 1) {
            sObj = records[0];
        }
        return sObj;
    }

  private static String setToString(Set<String> stringSet) {
        String output = '';
        for (String s : stringSet) {
            output += (output == '' ? '' : ',') + s;
        }
        return output;
    }


    private void populateLinkMap(List<DL_Configuration__c> dls) {
        linkMap = new Map<String, Map<String, List<LinkWrap>>>(); //type, category > linkwrap

        for (DL_Configuration__c dl : dls) {
            if (!linkMap.containsKey(dl.DL_Type__c)) {
                linkMap.put(dl.DL_Type__c, new Map<String, List<LinkWrap>>());
            }
            if (!linkMap.get(dl.DL_Type__c).containsKey(dl.Category__c)) {
                linkMap.get(dl.DL_Type__c).put(dl.Category__c, new List<LinkWrap>());
            }
            //create a wrapper record (actual line on VF page)
            LinkWrap lw     = new LinkWrap();
            lw.name         = dl.Name;
            lw.description  = dl.Comment__c;
            lw.link         = (classicThemes.contains(userTheme) || String.isBlank(dl.URL_SF1__c)) ? dl.URL_Web__c : dl.URL_SF1__c;
            lw.recordNumber = dl.Record_Nr__c;
            linkMap.get(dl.DL_Type__c).get(dl.Category__c).add(lw);
        }
    }

    private void replaceFieldsInURLs(Set<String> allFields, SObject record, Boolean isUser) {
        List<Exception_Log__c> exception_logs = new List<Exception_Log__c>();
        for (Map<String, List<LinkWrap>> lws1 : linkMap.values()) {
            for (List<LinkWrap> lws : lws1.values()) {
                for (LinkWrap lw : lws) {

                    for (String fieldName : allFields) {
                        String[] dotNot = fieldName.split('\\.');
                        Object oValue;
                        //get the value from record
                        try {
                            if (dotNot.size() == 1) {
                                oValue = record.get(fieldName);
                            } else if (dotNot.size() == 2) {
                                oValue = record.getSObject(dotNot[0]).get(dotNot[1]);
                            } else if (dotNot.size() == 3) {
                                oValue = record.getSObject(dotNot[0]).getSObject(dotNot[1]).get(dotNot[2]);
                            } else if (dotNot.size() == 4) {
                                oValue = record.getSObject(dotNot[0]).getSObject(dotNot[1]).getSObject(dotNot[2]).get(dotNot[3]);
                            }
                        } catch (NullPointerException e) {
                            exception_logs.add(ExceptionLogHelperClass.createExceptionLogRecord('','','DynamicLinkController',
                                    'replaceFieldsInURLs','Technical exception','',e.getStackTraceString(),'TC0007',e.getMessage()));
                        }

                        String value = String.valueOf(oValue);

                        if (value == null) value = '';
                        //replace parametr by actual value in URL
                        if (isUser) {
                            //refactor
                            lw.link = lw.link.replace('{!$' + fieldName + '}', value);
                            lw.link = lw.link.replace('{!$user.' + fieldName + '}', value);
                        } else {
                            lw.link = lw.link.replace('{!' + fieldName + '}', value);
                        }
                    }
                    //US-227513 Modify the URL to replace string {$Api.Session_ID} with actual session id 
                    if (lw.link.contains('{$Api.Session_ID}')) {
                        lw.link = lw.link.replace('{$Api.Session_ID}', UserInfo.getSessionId());                            
                    }
                }
            }
        }

        if(!exception_logs.isEmpty()){
            insert exception_logs;
        }
    }

    private void applyAccess(List<DL_Configuration__c> dls, SObject record, String sObjectName) {

        String rtName;
        if (hasRecodTypes(sObjectName)) {
            rtName = (String)record.getSObject('RecordType').get('DeveloperName');
        }

        //user access
        String userProfile  = runningUser.Profile.Name;
        String userType     = UserInfo.getUserType();
        String userRole     = runningUser.UserRole.DeveloperName;

        for (Integer i = 0; i < dls.size(); i++) {
            DL_Configuration__c dl = dls[i];
            if ((dl.RecordType__c != DEFAULT_1 && dl.RecordType__c != rtName)
                    || (dl.Access__c == ADMIN_ONLY)
                    || (dl.Access__c == INTERNAL && userType != STANDARD)
                    || (dl.Access__c == EXTERNAL && userType == STANDARD)) {
                dls.remove(i);
                i--;
            }
        }
    }

    private Boolean hasRecodTypes (String sObjectName) {

        return Schema.getGlobalDescribe().get(sObjectName).getDescribe().getRecordTypeInfos().size() > 1;
    }

    public class LinkWrap {
        public String name          {get; set;}
        public String description   {get; set;}
        public String link          {get; set;}
        public String recordNumber  {get; set;}

        public LinkWrap() {

        }
    }

}