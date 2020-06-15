/**************************************************************************************
* Apex Class Name    :     CTR_Product_Drill_Down_CA_Test
* Version            :     1.0
* Created Date       :     23/March/2018
* Function           :     This is Test class for CTR_Product_Drill_Down_CA Class
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     23/March/2018                Created.
*************************************************************************************/

@isTest
private class CTR_Product_Drill_Down_CA_Test {
 /********************************************************************************************
 * Method   : testdrilldown
 * Description: To Test ProductDrill Down
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 05-Jan-2018  Srni       Created     
 ********************************************************************************************/
    @isTest static void testdrilldown()
    {
   // To insert data in Opportunity Line Item, Setting up Required dependent data
    Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);  
    Date closeDt = Date.Today();

    List<Account> acclst=new List<Account>();
    Account a1 = new Account(Name ='Retailer acc');
    acclst.add(a1);
    
    Account a2 = new Account(Name ='Territory Account');
    acclst.add(a2);
        
    Account a3 = new Account(Name ='Distributor Account');
    acclst.add(a3);
        
    Account a4 = new Account(Name ='CU Account');
    acclst.add(a4);
        
    Account a5 = new Account(Name ='Head Office Account');
    acclst.add(a5);
    insert acclst;
        
     List<opportunity> opplst=new List<opportunity>();
        opportunity oppr3 = new opportunity();
        oppr3.Name='CU opp3';
        oppr3.AccountId= a1.Id;
        oppr3.StageName = 'Acquire';
        oppr3.CloseDate = closeDt;
        oppr3.Year__c='2018';
        oppr3.RecordTypeId =oppRecordtypes.get(Label.Seeds_CU_Sales_Plan_Record_Type_Name);
        opplst.add(oppr3); //insert oppr3;
        
        opportunity oppr1 = new opportunity();
        oppr1.Name='Distributor opp1';
        oppr1.AccountId= a2.Id;
        oppr1.StageName = 'Acquire';
        oppr1.CloseDate = closeDt;
        oppr1.Year__c='2018';
        oppr1.RelatedCUPlan__c=oppr3.id;
        oppr1.RecordTypeId =oppRecordtypes.get(Label.Seeds_Distributor_Sales_Plan);
        opplst.add(oppr1); //insert oppr1;
                
        opportunity oppr2 = new opportunity();
        oppr2.Name='Territory opp2';
        oppr2.AccountId= a1.Id;
        oppr2.StageName = 'Acquire';
        oppr2.CloseDate = closeDt;
        oppr2.Year__c='2018';
        oppr2.RecordTypeId =oppRecordtypes.get(Label.Territory_Seeds_Sales_Plan);
        opplst.add(oppr2); //insert oppr2;
        
        opportunity oppr = new opportunity();
        oppr.Name='Retailer opp';
        oppr.AccountId= a1.Id;
        oppr.StageName = 'Won';
        oppr.CloseDate = closeDt;
        oppr.Year__c='2018';
        oppr.RelatedTerritoryPlan__c=oppr2.id;
        oppr.RelatedDistributorPlan__c=oppr1.id;
        oppr.RecordTypeId =oppRecordtypes.get(Label.Retailer_Seed_Sales_Plan);
        opplst.add(oppr);
        
        opportunity oppr5 = new opportunity();
        oppr5.Name='Retailer Head Office opp';
        oppr5.AccountId= a5.Id;
        oppr5.StageName = 'Won';
        oppr5.CloseDate = closeDt;
        oppr5.Year__c='2018';
        oppr5.RelatedTerritoryPlan__c=oppr2.id;
        oppr5.RelatedDistributorPlan__c=oppr1.id;
        oppr5.RecordTypeId =oppRecordtypes.get(Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name);
        opplst.add(oppr5);
        
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
         opplnitem.OpportunityId=oppr.Id;
         opplnitem.Quantity=4; 
         opplnitem.UnitPrice=0.02;
         opplnitem.Product2Id=pro2.id;
         opplnitem.PriceBookEntryId=pbe2.Id;
         olilst.add(opplnitem); //insert opplnitem;         
     
         OpportunityLineItem opplnitem1=new OpportunityLineItem();
         opplnitem1.CY_Planned_Sales1__c=1000;
         opplnitem1.CY_1_Forecast_Sales__c=2000;
         opplnitem1.Product2Id=pro2.id;
         opplnitem1.OpportunityId=oppr1.Id;
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
        
        OpportunityLineItem opplnitem3=new OpportunityLineItem();
         opplnitem3.FNS_CY__c=2000;
         opplnitem3.CY_1_Forecast_Sales__c=1000;
         opplnitem3.OpportunityId=oppr3.Id;
         opplnitem3.Quantity=4; 
         opplnitem3.UnitPrice=0.02;
         opplnitem3.Product2Id=pro2.id;
         opplnitem3.PriceBookEntryId=pbe2.Id;
         olilst.add(opplnitem3); //insert opplnitem3;
        
        OpportunityLineItem opplnitem4=new OpportunityLineItem();
         opplnitem4.FNS_CY__c=2000;
         opplnitem4.CY_1_Forecast_Sales__c=1000;
         opplnitem4.OpportunityId=oppr5.Id;
         opplnitem4.Quantity=4; 
         opplnitem4.UnitPrice=0.02;
         opplnitem4.Product2Id=pro2.id;
         opplnitem4.PriceBookEntryId=pbe2.Id;
         olilst.add(opplnitem4);
        
        insert olilst;
        
        Test.startTest();
        PageReference pageRef = Page.VF_Product_Drill_down_CA;
        pageRef.getParameters().put('oliId', String.valueOf(opplnitem3.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController con = new ApexPages.StandardController(opplnitem3);
        CTR_Product_Drill_Down_CA cntr = new CTR_Product_Drill_Down_CA(con);
        pageRef.getParameters().put('oliId', String.valueOf(opplnitem2.Id));
        Test.setCurrentPage(pageRef);
        con = new ApexPages.StandardController(opplnitem2);
        cntr = new CTR_Product_Drill_Down_CA(con);
        pageRef.getParameters().put('oliId', String.valueOf(opplnitem1.Id));
        Test.setCurrentPage(pageRef);
        con = new ApexPages.StandardController(opplnitem1);
        cntr = new CTR_Product_Drill_Down_CA(con);
        pageRef.getParameters().put('oliId', String.valueOf(opplnitem4.Id));
        Test.setCurrentPage(pageRef);
        con = new ApexPages.StandardController(opplnitem4);
        cntr = new CTR_Product_Drill_Down_CA(con);
        test.stopTest();
 }  
}