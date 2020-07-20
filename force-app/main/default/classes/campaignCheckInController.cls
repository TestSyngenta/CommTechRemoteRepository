public class campaignCheckInController {

    @AuraEnabled
    public static CampaignMember insertCampaignMember(String campaignId, String contactId, String status){
        CampaignMember cm = new CampaignMember(CampaignId=campaignId, ContactId=contactId, Status=status);
        insert cm;
        return cm;
    }

    @AuraEnabled
    public static CampaignMember insertNewLeadCampaignMember(String campaignId, String leadId, String status){
        CampaignMember cm = new CampaignMember(CampaignId=campaignId, leadId=leadId, Status=status);
        insert cm;
        return cm;
    }

    @AuraEnabled
    public static List < sObject > fetchCampaign(String Id) {

        List <sObject> returnList = new List <sObject> ();
        String sQuery =  'select id, Name, Customer_Type__c from Campaign where Id= :Id';
        List < sObject > lstOfRecords = Database.query(sQuery);
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    @AuraEnabled
    public static List < sObject > getCampaignAttendeeCount(Id Id) {

        List <sObject> returnList = new List <sObject> ();
        String sQuery =  'select id, Total_Checked_In__c, Total_Registered2__c from Campaign where id= :Id';
        List < sObject > attendeeCount = Database.query(sQuery);
        for (sObject obj: attendeeCount) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    Public static List<List<sObject>> searchContactsAndLeads(String searchword) {
        String searchKey =  searchword;
        String searchQuery = 'FIND \''+searchKey+'*\' IN NAME FIELDS RETURNING Lead(FirstName,LastName,Id,Company), Contact(FirstName,LastName,Id,Account_Name__c) LIMIT 50';
        List<List<sObject>> searchConLead = search.query(searchQuery);
        return searchConLead;
    }


    @AuraEnabled
    public static List < sObject > fetchCampaignMembers(String searchKeyWord, String ObjectName, String searchCampaignId) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = '%' + searchKeyWord + '%';
        String campaignKey = searchCampaignId;
        List < sObject > returnList = new List < sObject > ();
        String sQuery =  'select id,CampaignMember.Campaign.Type,CampaignMember.Campaign.Name, Comments__c, Registered_Guests__c, Attending_Guests__c, CampaignMember.Contact.Account.Type, CampaignId, CompanyOrAccount, LeadId, Status, ContactId, FirstName, LastName, MobilePhone, Email from ' +ObjectName + ' where (FirstName LIKE: searchKey OR LastName LIKE: searchKey OR CompanyOrAccount LIKE: searchKey) AND CampaignId = \''+campaignKey+'\' order by lastModifiedDate DESC LIMIT 30';
        List < sObject > lstOfRecords = Database.query(sQuery);

        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    public static List < sObject > fetchCampaigns(String searchKeyWord, String ObjectName) {
        String searchKey = '%' + searchKeyWord + '%';
        List < sObject > returnList = new List < sObject > ();
        String sQuery =  'select id, Name, Customer_Type__c from Campaign where Name LIKE: searchKey AND IsActive=true order by lastModifiedDate DESC';
        List < sObject > lstOfRecords = Database.query(sQuery);
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    public static CampaignMember updateMemberStatus(Id memberRecord, String campaignId){
        CampaignMember queriedMember = [SELECT Id, Comments__c FROM CampaignMember WHERE Id=:memberRecord AND CampaignId=:campaignId LIMIT 1];
        queriedMember.Status = 'Attended';
        update queriedMember;
        return queriedMember;
    }

    @AuraEnabled
    public static CampaignMember updateMemberAction(Id memberRecord, String campaignId, String status, String comments, Integer registeredGuest, Integer attendingGuest){
        CampaignMember queriedMember = [SELECT Id FROM CampaignMember WHERE Id=:memberRecord AND CampaignId=:campaignId LIMIT 1];
        queriedMember.Status = status;
        queriedMember.Comments__c = comments;
        queriedMember.Registered_Guests__c = registeredGuest;
        queriedMember.Attending_Guests__c = attendingGuest;
        update queriedMember;
        return queriedMember;
    }


    @AuraEnabled
    public static Lead addNewLeadAction(String firstName, String lastName, String companyName, String email, String phone){
        String leadNameString = firstName + lastName;
        String leadFirstNameString = firstName;
        String leadLastNameString = lastName;
        String companyString = companyName;
        String emailString = email;
        String phoneString = phone;
        Lead myLead = new Lead(FirstName=leadFirstNameString, LastName=leadLastNameString, Company=companyString, Email=emailString, MobilePhone=phoneString);
        insert myLead;
        return myLead;
    }

    @AuraEnabled
    public static List < sObject > validateContact(String contactId, String campaignId) {
        List < sObject > returnList = new List < sObject > ();
        String sQuery =  'select id, ContactId, FirstName, LastName FROM CampaignMember where ContactId =:contactId AND CampaignId =:campaignId';
        List < sObject > lstOfRecords = Database.query(sQuery);

        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    public static List < sObject > validateLead(String contactId, String campaignId) {
        List < sObject > returnList = new List < sObject > ();
        String sQuery =  'select id, LeadId, FirstName, LastName FROM CampaignMember where LeadId =:contactId AND CampaignId =:campaignId';
        List < sObject > lstOfRecords = Database.query(sQuery);

        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    public static List < sObject > getContactName(String contactId) {

        List <sObject> returnList = new List <sObject> ();
        String sQuery =  'select id, Name from Contact where Id= :contactId';
        List < sObject > lstOfRecords = Database.query(sQuery);
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

    @AuraEnabled
    public static List < sObject > getLeadName(String leadId) {

        List <sObject> returnList = new List <sObject> ();
        String sQuery =  'select id, Name from Lead where Id= :leadId';
        List < sObject > lstOfRecords = Database.query(sQuery);
        for (sObject obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }

}