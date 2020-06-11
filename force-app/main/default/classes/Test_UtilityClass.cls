/**************************************************************************************
* Apex Class Name    :     Test_UtilityClass
* Version            :     1.0
* Created Date       :     05/Jan/2018
* Function           :     This is Test class for Data Setup
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     05/Jan/2018                Created.
*************************************************************************************/
@isTest
global class Test_UtilityClass {
 /********************************************************************************************
 * Method   : dataTestMethod
 * Description: To Insert Required Data in Seeds Allocation
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 05-Jan-2018  Srni       Created 
 * 05-Feb-2018  Pratibha    Modified    
 ********************************************************************************************/
    
    @isTest global static void dataTestMethod() 
    {
        
        Profile pf= [Select Id from profile where Name='System Administrator - Canada']; 

        String orgId=UserInfo.getOrganizationId(); 
        String dateString=String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');

        Integer RandomId=Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName=orgId+dateString+RandomId; 
        
        User RunningUser = new User(firstname = 'ABC', 
        lastName = 'XYZ', 
        email = uniqueName + '@test' + orgId + '.org', 
        Username = uniqueName + '@test' + orgId + '.org', 
        EmailEncodingKey = 'ISO-8859-1', 
        Alias = uniqueName.substring(18, 23), 
        TimeZoneSidKey = 'America/New_York', 
        LocaleSidKey = 'en_CA', 
        LanguageLocaleKey = 'en_US', 
        ProfileId = pf.Id, 
        user_country__c = 'CA',
        Territory_Code__c = 'WCU'
        //UserRoleId = obj.Id
        ); 
 
        System.runAs(RunningUser)
        {
                      
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=RunningUser.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Territory__c L2 = new Territory__c(TerritoryLevel__c='L2:District',Sales_Org__c='1000',name='NA34 (US E Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L2;
            Territory__c L3 = new Territory__c(TerritoryLevel__c='L3:Territory',Sales_Org__c='3000',name='NA34 (US A Dealer)',Assigned_Rep__c=RunningUser.Id,CommercialUnit__c=L1.Id);
            insert L3;
            
            Id rt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
         
            Product2 p1 = new Product2(Product_ID__c='456',Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            Product2 p2 = new Product2(Product_ID__c='123',Volume_L__c=22.7,Variety__c='SY087',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            insert p1;
            Insert p2;
            
          /*  List<Product2> productlist = new List<Product2>();
            for (Integer i=0; i<102; i++){
            Product2 p = new Product2(Product_ID__c='123'+i,Volume_L__c=22.7,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CEREAL SEED',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=22.7,Brand__c='SYN CEREAL SEED',Base_UOM__c='kg',RecordTypeid = rt,AvailableforPlanning__c = True,isactive=true);
            productlist.add(p);                
            }
            insert productlist; */
        
            PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
            
            Pricebook2 seedpricebook = new Pricebook2(id=custommetadata.seeds_price_bookId__c,name='Seeds Price Book',IsActive = true);
            upsert seedpricebook;
            
            id stdpricebook = Test.getStandardPricebookId();
            
            PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=seedpricebook.id,IsActive=true);
            PricebookEntry pbe3=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=stdpricebook,IsActive=true);
            PricebookEntry pbe4=new PricebookEntry(UnitPrice=1,Product2Id=p2.id,Pricebook2Id=stdpricebook,IsActive=true);    
            
            insert pbe3;
            insert pbe4;
            insert pbe2;
            insert pbe1;
            
           
    Date closeDt = Date.Today();
    Map<string,id> accRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Account.SObjectType);
    Account a1 = new Account(Name ='testing account',recordtypeid =accRecordtypes.get(label.Planning_Account),Territory_Lookup__c=L1.id);
    insert a1;            

    Account a2 = new Account(Name ='testing acc',recordtypeid =accRecordtypes.get(label.Planning_Account),Territory_Lookup__c=L2.id);
    insert a2;
    
    Account a3=new Account(Name='Test Account',recordtypeid =accRecordtypes.get(label.Planning_Account),Territory_Lookup__c=L3.id);
    insert a3;
    Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
    
    opportunity oppr = new opportunity();
        oppr.Name='testing opp';
        oppr.AccountId= a1.Id;
        oppr.StageName = 'Won';
        oppr.CloseDate = closeDt;
        oppr.RecordTypeId= oppRecordtypes.get(Label.District_Seeds_Sales_Plan);
        oppr.Year__c='2018'; 
        oppr.Territory__c=L1.id;
        insert oppr;
     opportunity oppr1 = new opportunity();
        oppr1.Name='testing opp1';
        oppr1.AccountId= a2.Id;
        oppr1.StageName = 'Acquire';
        oppr1.CloseDate = closeDt;
        oppr1.RecordTypeId =oppRecordtypes.get(Label.Seeds_Allocation_Dist_RT);
        oppr1.Year__c='2018'; 
       // oppr1.Territory__c=L2.id;   
        insert oppr1;
      opportunity oppr2 = new opportunity();
        oppr2.Name='testing opp2';
        oppr2.AccountId= a2.Id;
        oppr2.StageName = 'Acquire';
        oppr2.CloseDate = closeDt;
        oppr2.RecordTypeId =oppRecordtypes.get(Label.Seeds_Allocation_Dist_RT);
        oppr2.Year__c='2018'; 
        oppr2.Territory__c=L3.id;   
        insert oppr2;      
            

  
     Account_Territory__c acctrr=new Account_Territory__c();
        acctrr.Account__c=a1.id;
        acctrr.Territory__c=l1.Id;
        insert acctrr;
            
     Account_Territory__c acctrr1=new Account_Territory__c();
        acctrr1.Account__c=a2.id;
        acctrr1.Territory__c=l2.Id;
        insert acctrr1; 
   
     Account_Territory__c acctrr2=new Account_Territory__c();
        acctrr2.Account__c=a3.id;
        acctrr2.Territory__c=l3.Id;
        insert acctrr2;
            
     // Inserting data in OpportunityLineItem
    /*     OpportunityLineItem opplnitem=new OpportunityLineItem();
         opplnitem.CY_Planned_Sales1__c=1000;
         opplnitem.CY_1_Forecast_Sales__c=2000;
         opplnitem.OliMatchingKey__c='0014F0000032oSoQAI|2017|539362';
         opplnitem.SP_Matching_Key__c = '0014F0000032oSoQAI|539362|2017|Retail OTG Sales|Seeds_Sales';
         opplnitem.SP_Matching_Key_1__c = '0014F0000032oSoQAI|539362|2016|Retail OTG Sales|Seeds_Sales';
         opplnitem.SP_Matching_Key_2__c = '0014F0000032oSoQAI|539362|2015|Retail OTG Sales|Seeds_Sales';
         opplnitem.OpportunityId=oppr.Id;
         opplnitem.PriceBookEntryId=pbe2.Id;
         insert opplnitem; */
       OpportunityLineItem opplnitem=new OpportunityLineItem();
         opplnitem.CY_Planned_Sales1__c=1000;
         opplnitem.CY_1_Forecast_Sales__c=2000;
         opplnitem.OliMatchingKey__c='P1234';
         opplnitem.OpportunityId=oppr.Id;
         opplnitem.SP_Matching_Key__c = '0014F0000032oSoQAI|539362|2017|Retail OTG Sales|Seeds_Sales';
         opplnitem.SP_Matching_Key_1__c = '0014F0000032oSoQAI|539362|2016|Retail OTG Sales|Seeds_Sales';
         opplnitem.SP_Matching_Key_2__c = '0014F0000032oSoQAI|539362|2015|Retail OTG Sales|Seeds_Sales';
         opplnitem.Quantity=4; 
         opplnitem.UnitPrice=0.02;
         opplnitem.PriceBookEntryId=pbe2.Id;
         insert opplnitem;         
     
         OpportunityLineItem opplnitem1=new OpportunityLineItem();
         opplnitem1.CY_Planned_Sales1__c=1000;
         opplnitem1.CY_1_Forecast_Sales__c=2000;
         opplnitem1.OliMatchingKey__c='P1234';
         opplnitem1.OpportunityId=oppr1.Id;
         opplnitem1.Quantity=2; 
         opplnitem1.UnitPrice=0.01;
         opplnitem1.PriceBookEntryId=pbe2.Id;
         insert opplnitem1;     
          
            
     // Inserting data in OpportunityLineItem
        Sales_Plan_Actual__c spa1=new Sales_Plan_Actual__c(Account__c=a1.Id,Product__c=p1.id,Territory__c=L2.id,UniqueKey__c='0014F0000032oSoQAI|539362|2017|Retail OTG Sales|Seeds_Sales');        
        Sales_Plan_Actual__c spa2=new Sales_Plan_Actual__c(Account__c=a2.Id,Product__c=p1.id,Territory__c=L2.id,UniqueKey__c='0014F0000032oSoQAI|539362|2016|Retail OTG Sales|Seeds_Sales');
        Sales_Plan_Actual__c spa3=new Sales_Plan_Actual__c(Account__c=a3.Id,Product__c=p2.id,Territory__c=L2.id,UniqueKey__c='0014F0000032oSoQAI|539362|2015|Retail OTG Sales|Seeds_Sales');
        insert spa1;
        insert spa2;
        insert spa3;
            
      //
        }
    }
}