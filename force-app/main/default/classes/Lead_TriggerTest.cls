//Developer: Samuel Walker
//Date: 5/24/19 - 5/30/19
//Description: Recreating the Contract Trigger Test just making it work for Lead.
//Contact Trigger Test Developers: Brian Hopkins, Trevor Cornfield

@isTest
public class Lead_TriggerTest {

    @testSetup
    static void setUp() {
        Profile testProfile = [Select id from Profile where Name like '%Sales%' limit 1];
        Profile testProfile2 = [Select id from Profile where Name like '%Integration%' limit 1];
        UserRole testRole = [Select id from UserRole where Name like '%Syngenta%' limit 1];
        User testUser1 = CLS_StaticUtils.createTestUser(testRole.id,testProfile.id,'Test','User1');
        User testUser2 = CLS_StaticUtils.createTestUser(testRole.id,testProfile2.id,'Pardot','User2');
        List<User> userList = new List<User>();
        userList.add(testUser1);
        userList.add(testUser2);
        insert userList;
    }
    
    @isTest
    static void testLead1() {
        User testUser1 = [Select Id From User Where FirstName = 'Test' and LastName = 'User1'];
        User testUser2 = [Select Id From User Where FirstName = 'Pardot' and LastName = 'User2'];
        
        Lead testLead1;
        Lead testLead2;
        
        List<Lead> insertList1 = new List<Lead>();
        List<Lead> insertList2 = new List<Lead>();
        List<Lead> deleteList1 = new List<Lead>();
        
        System.runAs(testUser1){
            // insert test Lead with phone
            testLead1 = new Lead(LastName='SyngentaContact_01', FirstName='Joe', Email = 'test1@goodtest.com', Phone='5556895253',  
                                 Pardot_Opt_In_Email_Communications__c = 'Yes (Express)', Opt_in_ECom__c = 'Yes (Opted-in)', Company = 'SQSOFT', Pardot_Do_Not_Email__c = False);//False
            insertList1.add(testLead1);
            // insert test Lead 2 with email
            testLead2 = new Lead(LastName='SyngentaContact_02', FirstName='Joe', Email='test2@goodtest.com', Pardot_Opt_In_Email_Communications__c = 'No', 
                                 Opt_in_ECom__c = 'No (Opted-out)', Company = 'SQSOFT');
            insertList1.add(testLead2);
            insert(insertList1);
        }
        
        System.assertEquals('Yes (Opted-in)', testLead1.Opt_in_ECom__c);
        testLead1.Pardot_Do_Not_Email__c = True;
        testLead1.Pardot_Opt_In_Email_Communications__c = 'No Response';
        System.runAs(testUser2) {
            update testLead1;
        }
        
        System.runAs(testUser1){   
            // delete both Leads
            deleteList1.add(testLead1);
            deleteList1.add(testLead2);
            delete(deleteList1);    
        }
    }
    
    @isTest
    static void testLead2() {
        User testUser1 = [Select Id From User Where FirstName = 'Test' and LastName = 'User1'];
        User testUser2 = [Select Id From User Where FirstName = 'Pardot' and LastName = 'User2'];
        
        Lead testLead1;
        Lead testLead2;
        Lead testLead3;
        
        List<Lead> insertList1 = new List<Lead>();
        List<Lead> insertList2 = new List<Lead>();
        List<Lead> insertList3 = new List<Lead>();        
        List<Lead> deleteList1 = new List<Lead>();
        
        System.runAs(testUser1){

           // insert test Lead with phone
            testLead1 = new Lead(LastName='SyngentaContact_04', FirstName='Joe', Email = 'test4@goodtest.com', Phone='5556895253', 
                                 Pardot_Opt_In_Email_Communications__c = 'No Response', Company = 'SQSOFT');
            insertList1.add(testLead1);
            insert(insertList1);
        }

        System.runAs(testUser1){      
            testLead2 = new Lead(LastName='SyngentaContact_03', FirstName='Joe', Email='test5@goodtest.com', Pardot_Opt_In_Email_Communications__c = 'No Response', Company = 'SQSOFT');
            insertList2.add(testLead2);
            insert(insertList2);             
        }
        System.runAs(testUser2){
            testLead2.Pardot_Opt_In_Email_Communications__c = 'No';
            update testLead2;
        }  
        
        System.runAs(testUser2){
            testLead2.Pardot_Opt_In_Email_Communications__c = 'Yes (Express)';
            update testLead2;                                 
        }  
        
    }
}