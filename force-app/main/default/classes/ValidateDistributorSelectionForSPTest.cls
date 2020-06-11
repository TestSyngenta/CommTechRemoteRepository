@isTest
private class ValidateDistributorSelectionForSPTest 
{
    static TestMethod void validateDistributorSelectionTest()
    {
        List<Business_Plan__c> bpList=new List<Business_Plan__c>();
        List<Opportunity> oppList=new List<Opportunity>();
        List<Opportunity> oppList1=new List<Opportunity>();
        List<Account> acclist=new List<Account>();
        
        Id accRt = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
        Id accRt1 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        Id accRt2 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Grower').getRecordTypeId();
        
        Account a1=new Account(Name='TestAcc1',RecordTypeId= accRt1);
        Account a2=new Account(Name='TestAcc2',RecordTypeId= accRt);
        Account a3=new Account(Name='TestAcc3',RecordTypeId= accRt);
        Account a = new Account(Name ='Test Account',RecordTypeid = accRt1);
        Account a4 = new Account(Name ='Test Account1',RecordTypeid = accRt2);
        acclist.add(a1);
        acclist.add(a2);
        acclist.add(a3);
        acclist.add(a);
        acclist.add(a4);
        insert acclist;
        
        Date d1=Date.newInstance(2017, 5, 12);
        Date d2=Date.newInstance(2017, 7, 24);
        try
        {
            RecordType rctr = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
            RecordType rctg = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Grower_Business_Plan'];
            Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2017', Account__c = a1.id, RecordTypeId = rctr.id, Country__c = 'CA');
            insert bp1;
            Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP2' ,Year__c = '2017', Account__c = a4.id, RecordTypeId = rctg.id, Country__c = 'CA');
            insert bp2;
            
            Id oppRt1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(Label.RetailerSalesPlanRecordType).getRecordTypeId();
            Opportunity o1=new Opportunity(Name='TestOpp1',RecordTypeId=oppRt1,AccountId=a1.Id,CloseDate=d1,StageName='Closed',Probability=0,RelatedDistributor__c=a2.Id,Year__c='2017',AccountBusinessPlan__c=bp1.Id);
            Opportunity o2=new Opportunity(Name='TestOpp2',RecordTypeId=oppRt1,AccountId=a1.Id,CloseDate=d1,StageName='Closed',Probability=0,Year__c='2017',AccountBusinessPlan__c=bp1.Id);
            Id oppRt = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(Label.GrowerCPSalesPlanRecordType).getRecordTypeId();
            Opportunity o4=new Opportunity(Name='TestOpp3',RecordTypeId=oppRt, AccountId=a4.Id,CloseDate=d1,StageName='Closed',Probability=0,Related_Retailer__c=a.Id,Year__c='2017',AccountBusinessPlan__c=bp2.Id);
            Opportunity o5=new Opportunity(Name='TestOpp4',RecordTypeId=oppRt, AccountId=a4.Id,CloseDate=d1,StageName='Closed',Probability=0,Year__c='2017',AccountBusinessPlan__c=bp2.Id);
            oppList.add(o5);
            oppList.add(o4);
            oppList.add(o1);
            opplist.add(o2);
            insert oppList;
            system.debug('Testing Distributor');
            system.debug('Testing Retailer');
            o2.RelatedDistributor__c = a2.id;
            o5.Related_Retailer__c = a.id;
            oppList1.add(o2);
            oppList1.add(o5);
      
            test.startTest();
            system.debug('Testing Distributor1');
            system.debug('Testing Retailer1');
            update oppList1;
            test.stopTest();
         }
        catch(Exception e)
        {
            System.Debug(e.getMessage());
            Boolean expectedExceptionThrown=e.getMessage().contains('This distributor is already related with some other Sales Plan')?true:false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        
    }
    static TestMethod void validateDistributorSelectionInsertTest(){
        try{
        Date d1=Date.newInstance(2017, 5, 12);
        Date d2=Date.newInstance(2017, 7, 24);
        Id accRt1 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        Id accRt2 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Grower').getRecordTypeId();
        Account a1=new Account(Name='TestAcc1',RecordTypeId= accRt1);
        Account a2=new Account(Name='TestAcc2',RecordTypeId= accRt2);
        insert a1;
        insert a2;
        
        RecordType rctr = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
        RecordType rctg = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Grower_Business_Plan'];
        Business_Plan__c bp1 = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2017', Account__c = a1.id, RecordTypeId = rctr.id, Country__c = 'CA');
        insert bp1;
        Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP2' ,Year__c = '2017', Account__c = a2.id, RecordTypeId = rctg.id, Country__c = 'CA');
        insert bp2;

        List<Opportunity> oppList=new List<Opportunity>();
        Id oppRt1 = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(Label.RetailerSalesPlanRecordType).getRecordTypeId();
        Id oppRt = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(Label.GrowerCPSalesPlanRecordType).getRecordTypeId();
        //Retailer Opportunities
        Opportunity o1=new Opportunity(Name='TestOpp1',RecordTypeId=oppRt1,AccountId=a1.ID,CloseDate=d1,StageName='Commercial - Start up',Probability=0,Year__c='2017',AccountBusinessPlan__c=bp1.Id);
        Opportunity o2=new Opportunity(Name='TestOpp2',RecordTypeId=oppRt1,AccountId=a1.ID,CloseDate=d1,StageName='Commercial - Start up',Probability=0,Year__c='2017',AccountBusinessPlan__c=bp1.Id);
        // Grower Opportunitties
        Opportunity o3=new Opportunity(Name='TestOpp1',RecordTypeId=oppRt1,AccountId=a2.ID,CloseDate=d1,StageName='Commercial - Start up',Probability=0,Year__c='2017',AccountBusinessPlan__c=bp2.Id);
        Opportunity o4=new Opportunity(Name='TestOpp2',RecordTypeId=oppRt1,AccountId=a2.ID,CloseDate=d1,StageName='Commercial - Start up',Probability=0,Year__c='2017',AccountBusinessPlan__c=bp2.Id);
        insert o1;
        insert o3;
        oppList.add(o2);
        oppList.add(o4);
        test.startTest();
        insert oppList;
        test.stopTest();
            }
        catch(Exception e)
        {
            
        }
        
   }
    
    static TestMethod void updateAccountTerritory(){
        Id accRt = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        Account a = new Account(Name ='Test Account',RecordTypeid = accRt);
        insert a;
        
        Territory__c trr = new Territory__c(Name='A6234A',TerritoryLevel__c='L3:Territory',sales_org__C='1000');
        Territory__c trr1 = new Territory__c(Name='A6234B',TerritoryLevel__c='L3:Territory',sales_org__C='1ST');
        insert trr;
        insert trr1;
        
        Account_Territory__c acctr = new Account_Territory__c(account__c=a.Id,territory__c =trr.Id);
        Account_Territory__c acctr1 = new Account_Territory__c(account__c=a.Id,territory__c =trr1.Id);
        insert acctr;
        insert acctr1;
        
        RecordType rctr = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Retail_Business_Plan'];
        Business_Plan__c bp2 = new Business_Plan__c(name = 'TestBP1' ,Year__c = '2017', Account__c = a.id, RecordTypeId = rctr.id, Country__c = 'CA');
        insert bp2;
        Id oppRt = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get('RetailerCPSalesPlan').getRecordTypeId();
        Date dt = Date.Today();
        opportunity opp = new opportunity();
        opp.Name='Test Account';
        opp.AccountId= a.Id;
        opp.StageName = 'Won';
        opp.CloseDate = dt;
        opp.RecordTypeId= oppRt;
        opp.Territory__c = trr.id;
        opp.AccountBusinessPlan__c = bp2.Id;
        insert opp;
        
        opp.Territory__c = trr1.id;
        test.startTest();
        update opp;
        test.stopTest();
        
    }
}