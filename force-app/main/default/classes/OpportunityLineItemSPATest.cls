@isTest
public class OpportunityLineItemSPATest {
    static TestMethod void updateOpportunityLineItemspa(){
        //Creating Account
        Id accRt = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        Account a1 = new Account(Name ='Test Account1',RecordTypeid = accRt, AllowSeedsplanning__c =TRUE);
        insert a1 ;
        
        //Creating Opportunities
        Id oppRt = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('District Seeds Allocation').getRecordTypeId();
        Id oppRt2 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Account Seeds Allocations').getRecordTypeId();
        Id oppRt3 = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Territory Seeds Allocation').getRecordTypeId();
        Date dt = Date.Today();
        opportunity opp = new opportunity();
        opp.Name='Test Account1';
        opp.AccountId= a1.Id;
        opp.StageName = 'Won';
        opp.CloseDate = dt;
        opp.RecordTypeId= oppRt;
        insert opp;
        
        opportunity opp1 = new opportunity();
        opp1.Name='Test Account1';
        opp1.AccountId= a1.Id;
        opp1.StageName = 'Won';
        opp1.CloseDate = dt;
        opp1.RecordTypeId= oppRt;
        opp1.Year__c = '2017';
        insert opp1;
        
        opportunity opp2 = new opportunity();
        opp2.Name='Test Account1';
        opp2.AccountId= a1.Id;
        opp2.StageName = 'Won';
        opp2.CloseDate = dt;
        opp2.RecordTypeId= oppRt;
        opp2.Year__c = '2016';
        insert opp2;
  
        
        
       
       //creating Product
        Id prodRt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Seeds Product').getRecordTypeId();
        Product2 p1 = new Product2(Product_ID__c='3467',Volume_L__c=47,Variety__c='SY ROWYN',Product_Line__c='Seed',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN SEED Test',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=1.5,Brand__c='SYN CEREAL SEED',Base_UOM__c='KG',RecordTypeid = prodRt,AvailableforPlanning__c = True,isactive=true);
        insert p1;
        
        //creating pricebook and pricebook entires
        PriceBook_for_SalesPlan__mdt custommetadata = [select id,Seeds_Price_BookID__c from PriceBook_for_SalesPlan__mdt where SeedsPriceBook__c = 'Seeds Price Book'];
        Pricebook2 seedpricebook = new Pricebook2(id=custommetadata.seeds_price_bookId__c,name='Seeds Price Book',IsActive = true);
        upsert seedpricebook;
        id stdpricebook = Test.getStandardPricebookId();
        PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=stdpricebook,IsActive=true);
        PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=seedpricebook.id,IsActive=true);
        insert pbe1;
        insert pbe2;
        
        //creating Opportunity Line Item
        OpportunityLineItem oli=new OpportunityLineItem();
        oli.CurrentAllocationUnits__c = 1000;
        oli.SP_Matching_Key__c = a1.Account_ID__c+'|'+'3467'+'|'+opp.Year__c +'|'+ 'Retail OTG Sales'+'|'+'Seeds Sales';
        oli.SP_Matching_Key_1__c = a1.Account_ID__c+'|'+'3467'+'|'+'2017' +'|'+ 'Retail OTG Sales'+'|'+'Seeds Sales';
        oli.SP_Matching_Key_2__c = a1.Account_ID__c+'|'+'3467'+'|'+'2016' +'|'+ 'Retail OTG Sales'+'|'+'Seeds Sales';
        oli.PricebookEntryId = pbe1.id;
        oli.OpportunityId = opp.id;
        insert oli;

        //creating sales plan actuals
        Id spaRt = Schema.SObjectType.Sales_Plan_Actual__c.getRecordTypeInfosByName().get('Seeds Sales').getRecordTypeId();
        Sales_Plan_Actual__c spa = new Sales_Plan_Actual__c();
        spa.Account__c = a1.id;
        spa.Product__c = p1.id;
        spa.RecordTypeId = spaRt;
        spa.SoldtoID__c = a1.Account_ID__c;
        spa.Category__c = 'Retail OTG Sales';
        spa.Year__c = opp.Year__c;
        spa.Units__c =235;
        spa.UniqueKey__c = a1.Account_ID__c+'|'+'3467'+'|'+opp.Year__c +'|'+ 'Retail OTG Sales'+'|'+'Seeds Sales';
        insert spa;
        
        Sales_Plan_Actual__c spa1 = new Sales_Plan_Actual__c();
        spa1.Account__c = a1.id;
        spa1.Product__c = p1.id;
        spa1.RecordTypeId = spaRt;
        spa1.SoldtoID__c = a1.Account_ID__c;
        spa1.Category__c = 'Retail OTG Sales';
        spa1.Year__c = '2017';
        spa1.Units__c =466;
        spa1.UniqueKey__c = a1.Account_ID__c+'|'+'3467'+'|'+'2017' +'|'+ 'Retail OTG Sales'+'|'+'Seeds Sales';
        insert spa1;
        
        Sales_Plan_Actual__c spa2 = new Sales_Plan_Actual__c();
        spa2.Account__c = a1.id;
        spa2.Product__c = p1.id;
        spa2.RecordTypeId = spaRt;
        spa2.SoldtoID__c = a1.Account_ID__c;
        spa2.Category__c = 'Retail OTG Sales';
        spa2.Year__c = '2016';
        spa2.Units__c =3634;
        spa2.UniqueKey__c = a1.Account_ID__c+'|'+'3467'+'|'+'2016' +'|'+ 'Retail OTG Sales'+'|'+'Seeds Sales';
        insert spa2;
        
        //updating opportunity line item
        if (oli.SP_Matching_Key__c == spa.UniqueKey__c){
            oli.SalesPlanActual__c = spa.id;
        }
        else if (oli.SP_Matching_Key_1__c == spa1.UniqueKey__c){
            oli.SP_Matching_Key_1__c = spa1.id;
        }
        else if (oli.SP_Matching_Key_2__c == spa2.UniqueKey__c){
            oli.SP_Matching_Key_2__c = spa2.id;
        }
        
        update oli;
    }
}