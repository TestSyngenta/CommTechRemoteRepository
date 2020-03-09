@isTest
public class Programs_TriggerTest {
    
    public static TestMethod void runTest(){
        Account testAcct = new Account(Name='BeefyBurrito1928475SyngengtaTest');
        insert testAcct;
        
        
        
        Programs__c testProg = new Programs__c(Account__c=testAcct.id, Program_Year__c='2015', Offer_Type__c='TestOfferType');
        insert testProg;
        
        Programs__c testProg2 = new Programs__c(Account__c=testAcct.id, Program_Year__c='2015', Offer_Type__c='TestOfferType');
        try{
        	insert testProg2;
        }catch(DMLException e){}
        
        System.AssertEquals(null,testProg2.id);
        
    }

}