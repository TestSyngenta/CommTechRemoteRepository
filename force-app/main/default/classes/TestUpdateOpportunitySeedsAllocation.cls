/**************************************************************************************
* Apex Class Name    :     TestUpdateOpportunitySeedsAllocation
* Version            :     1.0
* Created Date       :     05/Jan/2018
* Function           :     This is Test class for UpdateOpportunitySeedsAllocation Trigger
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     05/Jan/2018                Created.
*************************************************************************************/

@isTest
private class TestUpdateOpportunitySeedsAllocation {
 /********************************************************************************************
 * Method   : initData
 * Description: To Insert Required Data in Opportunity Line Item
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 05-Jan-2018  Srni       Created     
 ********************************************************************************************/
    @TestSetup static void initData()
    {
   // To insert data in Opportunity Line Item, Setting up Required dependent data
    Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);  
    Date closeDt = Date.Today();

    List<Account> acclst=new List<Account>();
    Account a2 = new Account(Name ='testing acc');
    //insert a2;
    acclst.add(a2);
    
    Account a1 = new Account(Name ='Testing Account');
    //insert a1;
    acclst.add(a1);
    insert acclst;
        
     List<opportunity> opplst=new List<opportunity>();
        
        opportunity oppr = new opportunity();
        oppr.Name='testing opp';
        oppr.AccountId= a2.Id;
        oppr.StageName = 'Won';
        oppr.CloseDate = closeDt;
        oppr.Year__c='2018';
        oppr.RecordTypeId =oppRecordtypes.get(Label.Seeds_Allocation_Dist_RT);
        opplst.add(oppr); //insert oppr;
     opportunity oppr1 = new opportunity();
        oppr1.Name='testing opp1';
        oppr1.AccountId= a2.Id;
        oppr1.StageName = 'Acquire';
        oppr1.CloseDate = closeDt;
        oppr1.Year__c='2018';
        oppr1.RecordTypeId =oppRecordtypes.get(Label.District_Seeds_Sales_Plan);
        opplst.add(oppr1); //insert oppr1;
        
        opportunity oppr2 = new opportunity();
        oppr2.Name='testing opp2';
        oppr2.AccountId= a1.Id;
        oppr2.StageName = 'Acquire';
        oppr2.CloseDate = closeDt;
        oppr2.Year__c='2018';
        oppr2.RecordTypeId =oppRecordtypes.get(Label.Territory_Seeds_Sales_Plan);
        opplst.add(oppr2); //insert oppr2;
        
        opportunity oppr3 = new opportunity();
        oppr3.Name='testing opp3';
        oppr3.AccountId= a1.Id;
        oppr3.StageName = 'Acquire';
        oppr3.CloseDate = closeDt;
        oppr3.Year__c='2018';
        oppr3.RecordTypeId =oppRecordtypes.get(Label.Seeds_Allocation_Territory);
        opplst.add(oppr3); //insert oppr3;
        insert opplst;

    Pricebook2 pb22 = new Pricebook2(Name='testprc');
    insert pb22;

    Product2 pro2 = new Product2(Product_Line__c='DIE',Name='BXCD',Product_ID__c='23654', isActive=true,Variety__c='XYZ');
    insert pro2;

    PricebookEntry pbe2 =new PricebookEntry(unitprice=0.01,Product2Id=pro2.Id,Pricebook2Id=Test.getStandardPricebookId(),
                                         isActive=true,UseStandardPrice = false);
    insert pbe2;
        
        List<OpportunityLineItem> olilst=new List<OpportunityLineItem>();
        // Inserting data in OpportunityLineItem
         OpportunityLineItem opplnitem=new OpportunityLineItem();
         opplnitem.FNS_CY__c=1000;
         opplnitem.CY_1_Forecast_Sales__c=2000;
         opplnitem.OpportunityId=oppr1.Id;
         opplnitem.Quantity=4; 
         opplnitem.UnitPrice=0.02;
         opplnitem.Product2Id=pro2.id;
         opplnitem.PriceBookEntryId=pbe2.Id;
         olilst.add(opplnitem); //insert opplnitem;         
     
         OpportunityLineItem opplnitem1=new OpportunityLineItem();
         opplnitem1.CY_Planned_Sales1__c=1000;
         opplnitem1.CY_1_Forecast_Sales__c=2000;
         opplnitem1.Product2Id=pro2.id;
         opplnitem1.OpportunityId=oppr.Id;
         opplnitem1.Quantity=2; 
         opplnitem1.UnitPrice=0.01;
         opplnitem1.PriceBookEntryId=pbe2.Id;
         opplnitem1.OliMatchingKey__c=oppr.AccountId + '|' + oppr.Year__c + '|' + pro2.Variety__c;
         olilst.add(opplnitem1); //insert opplnitem1;
        
        OpportunityLineItem opplnitem2=new OpportunityLineItem();
         opplnitem2.FNS_CY__c=2000;
         opplnitem2.CY_1_Forecast_Sales__c=1000;
         opplnitem2.OpportunityId=oppr2.Id;
         opplnitem2.Quantity=4; 
         opplnitem2.UnitPrice=0.02;
         opplnitem2.Product2Id=pro2.id;
         opplnitem2.PriceBookEntryId=pbe2.Id;
         olilst.add(opplnitem2); //insert opplnitem2;
        insert olilst; 
 }
 /********************************************************************************************
 * Method   : testData
 * Description: To Test the Data
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 05-Jan-2018  Srni       Created     
 ********************************************************************************************/   
    @isTest static void testData()
    {

        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
    //  System.assertEquals(1, [SELECT COUNT() FROM OpportunityLineItem Where opportunity.RecordTypeId = '0124F00000007IH']);
        OpportunityLineItem opplnitm = [SELECT Id,FNS_CY__c,CY_1_Forecast_Sales__c,OliMatchingKey__c FROM OpportunityLineItem Where opportunity.RecordTypeId = :oppRecordtypes.get(Label.District_Seeds_Sales_Plan)];
        System.debug('Opp Line Item---->>'+opplnitm);
        opplnitm.FNS_CY__c=5000;
        Test.startTest();
        update opplnitm;
        Test.stopTest();
 
    }
 /********************************************************************************************
 * Method   : testseedsallocation
 * Description: To Test the Data
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 13-Feb-2018  Srni       Created     
 ********************************************************************************************/   
    @isTest static void testseedsallocation()
    {

        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
   //  System.assertEquals(1, [SELECT COUNT() FROM OpportunityLineItem Where opportunity.RecordTypeId = '0124F00000007IH']);
        OpportunityLineItem opplnitm1 = [SELECT Id,FNS_CY__c,opportunity.recordtype.developername,CY_1_Forecast_Sales__c,OliMatchingKey__c FROM OpportunityLineItem Where opportunity.RecordTypeId = :oppRecordtypes.get(Label.Seeds_Allocation_Dist_RT)];
        System.debug('Opp Line Item $$$---->>'+opplnitm1 + ' '+opplnitm1.opportunity.recordtype.developername);
        opplnitm1.CurrentAllocationUnits__c=4000;
        Test.startTest();
        update opplnitm1;
        Test.stopTest();
 
    }
  /********************************************************************************************
 * Method   : testinsertseedsallocation
 * Description: To Test the insert
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 13-Feb-2018  Srni       Created     
 ********************************************************************************************/   
    @isTest static void testinsertseedsallocation()
    {

        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
   //  System.assertEquals(1, [SELECT COUNT() FROM OpportunityLineItem Where opportunity.RecordTypeId = '0124F00000007IH']);
        Opportunity oppr3 = [SELECT Id,AccountId,Year__c,recordtype.developername FROM Opportunity Where RecordTypeId = :oppRecordtypes.get(Label.Seeds_Allocation_Territory)];
        Product2 prd3 = [SELECT Id,Variety__c FROM Product2 Where Product_Line__c='DIE'];
        PricebookEntry pr3 = [SELECT Id FROM PricebookEntry Where unitprice=0.01];
        System.debug('Opportunity Record Type:##'+oppr3.recordtype.developername);
        OpportunityLineItem opplnitem3=new OpportunityLineItem();
         opplnitem3.CY_Planned_Sales1__c=12;
         opplnitem3.CY_1_Forecast_Sales__c=13;
         opplnitem3.AllocatedBaselineUnits__c=1100;
         opplnitem3.OpportunityId=oppr3.Id;
         opplnitem3.Quantity=4; 
         opplnitem3.UnitPrice=0.02;
         opplnitem3.Product2Id=prd3.id;
         opplnitem3.PriceBookEntryId=pr3.Id;
         opplnitem3.OliMatchingKey__c=oppr3.AccountId + '|' + oppr3.Year__c + '|' + prd3.Variety__c;
        Test.startTest();
        insert opplnitem3;
        Test.stopTest();
 
    }
}