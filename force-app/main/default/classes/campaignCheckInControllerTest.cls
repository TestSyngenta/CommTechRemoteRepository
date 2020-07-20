@isTest
public class campaignCheckInControllerTest {
//    @isTest static void fetchCampaignMembers() {
    public static testmethod void fetchCampaignMembers(){
        Account testAcc = new Account(Name = 'Test Account');
        testAcc.RecordTypeId = '012o0000000Bjt4';
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        testCampaign.Customer_Type__c = 'Grower';
        insert testCampaign;

        CampaignMember newMember = new CampaignMember(ContactId=testContact.id, campaignid = testCampaign.Id);
        insert newMember;

        campaignCheckInController.fetchCampaignMembers('TestContactF', 'CampaignMember', testCampaign.Id);

        List<CampaignMember> listCm =[select id from CampaignMember where CampaignId=: testCampaign.Id];
        System.assertEquals(1,listCm.size());

    }

    @isTest static void insertCampaignMember() {
        Account testAcc = new Account(Name = 'Test Account');
        testAcc.RecordTypeId = '012o0000000Bjt4';
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        testCampaign.Customer_Type__c = 'Grower';
        insert testCampaign;

        campaignCheckInController.insertCampaignMember(testCampaign.Id, testContact.Id, 'Registered');

        List<CampaignMember> listCm =[select id from CampaignMember where CampaignId=: testCampaign.Id];
        System.assertEquals(1,listCm.size());
    }

    @isTest static void insertNewLeadCampaignMember() {
        Account testAcc = new Account(Name = 'Test Account');
        testAcc.RecordTypeId = '012o0000000Bjt4';
        insert testAcc;

        Lead testLead = new Lead(FirstName='TestContactF',LastName='TestContactL', Company=testAcc.Name);
        insert testLead;

        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        testCampaign.Customer_Type__c = 'Lead';
        insert testCampaign;

        campaignCheckInController.insertNewLeadCampaignMember(testCampaign.Id, testLead.Id, 'Registered');

        List<CampaignMember> listCm =[select id from CampaignMember where CampaignId=: testCampaign.Id];
        System.assertEquals(1,listCm.size());
    }

    @isTest static void fetchCampaign() {
        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        insert testCampaign;
        campaignCheckInController.fetchCampaign(testCampaign.Id);
        List<Campaign> listCm =[select id from Campaign where Id=: testCampaign.Id];
        System.assertEquals(1,listCm.size());
    }

    @isTest static void searchContactsAndLeads() {
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        Lead testLead = new Lead(FirstName='TestContactF',LastName='TestContactL',Company='Test Account');
        insert testLead;

        campaignCheckInController.searchContactsAndLeads('TestContactF');

        List<List<sObject>> testList =[FIND 'TestContactF' IN NAME FIELDS RETURNING Lead(Id), Contact(Id)];
        System.assertEquals(2,testList.size());
    }

    @isTest static void fetchCampaigns() {
        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        insert testCampaign;
        campaignCheckInController.fetchCampaigns('TestCampaign','Campaign');
        List<Campaign> listCm =[select id from Campaign where Name LIKE 'TestCampaign'];
        System.assertEquals(1,listCm.size());
    }

    @isTest static void updateMemberStatus() {
        Account testAcc = new Account(Name = 'Test Account');
        testAcc.RecordTypeId = '012o0000000Bjt4';
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        testCampaign.Customer_Type__c = 'Grower';
        insert testCampaign;

        CampaignMember newMember = new CampaignMember(ContactId=testContact.id, campaignid = testCampaign.Id, status='Registered');
        insert newMember;
        newMember.Status = 'Attended';
        update newMember;

        campaignCheckInController.updateMemberStatus(newMember.Id, testCampaign.Id);

        List<CampaignMember> listCm =[SELECT Id FROM CampaignMember WHERE CampaignId=: testCampaign.Id];
        System.assertEquals(1,listCm.size());

    }




    @isTest static void addNewLeadAction() {
        Lead testLead = new Lead(FirstName='TestContactF',LastName='TestContactL',Company='Test Account');
        insert testLead;

        campaignCheckInController.addNewLeadAction('TestContactF', 'TestContactL', 'Test Account','email@email.com','phone');

        List<Lead> testList =[SELECT Id FROM Lead WHERE Id=: testLead.Id];
        System.assertEquals(1,testList.size());

    }

    @isTest static void getContactName() {
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        campaignCheckInController.getContactName(testContact.Id);
        List<Contact> testList =[SELECT Id,FirstName FROM Contact WHERE Id=: testContact.Id];
        System.assertEquals(1,testList.size());

    }

    @isTest static void getLeadName() {
        Account testAcc = new Account(Name = 'Test Account');
        insert testAcc;

        Lead testLead = new Lead(FirstName='TestContactF',LastName='TestContactL',Company='Test Account');
        insert testLead;

        campaignCheckInController.getLeadName(testLead.Id);

        List<Lead> testList =[SELECT Id,FirstName FROM Lead WHERE Id=: testLead.Id];
        System.assertEquals(1,testList.size());

    }

    @isTest static void getCampaignAttendeeCount() {
        Account testAcc = new Account(Name = 'Test Account');
        testAcc.RecordTypeId = '012o0000000Bjt4';
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        testCampaign.Customer_Type__c = 'Grower';
        insert testCampaign;

        CampaignMember newMember = new CampaignMember(ContactId=testContact.id, campaignid = testCampaign.Id);
        insert newMember;

        campaignCheckInController.getCampaignAttendeeCount(testCampaign.Id);

        List<Campaign> listCm =[select id,Total_Checked_In__c,Total_Registered2__c from Campaign where Id=: testCampaign.Id];

        System.assertEquals(1,listCm.size());

    }

    @isTest static void validateContact() {
        //validateContact(String contactId, String campaignId)
        Account testAcc = new Account(Name = 'Test Account');
        testAcc.RecordTypeId = '012o0000000Bjt4';
        insert testAcc;

        Contact testContact = new Contact(FirstName='TestContactF',LastName='TestContactL',accountid=testAcc.Id);
        insert testContact;

        Campaign testCampaign = new Campaign();
        testCampaign.Name = 'TestCampaign';
        testCampaign.Customer_Type__c = 'Grower';
        insert testCampaign;

        CampaignMember newMember = new CampaignMember(ContactId=testContact.id, CampaignId = testCampaign.Id);
        insert newMember;

        campaignCheckInController.validateContact(testContact.Id,testCampaign.Id);
        List<CampaignMember> listCm =[SELECT id, ContactId, FirstName, LastName FROM CampaignMember where ContactId =:testContact.Id AND CampaignId =:testCampaign.Id];

        System.assertEquals(1,listCm.size());
    }

}