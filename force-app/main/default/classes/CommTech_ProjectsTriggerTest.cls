@isTest

public class CommTech_ProjectsTriggerTest {
    public static testMethod void testMethod1() {
        //List<Trello__c> insertTrello = new List<Trello__c>();
        Trello__c CommTech_Project = new Trello__c();
        CommTech_Project.Name = 'Testproject1';
        CommTech_Project.CommTech_Project_Lead__c = 'Aakash Sidana';
        CommTech_Project.Members__c = 'Aakash';
        insert CommTech_Project;
try{
    Delete CommTech_Project;
}
Catch(Exception ee)
{}
    }
}