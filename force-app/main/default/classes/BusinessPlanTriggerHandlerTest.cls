@isTest
public class BusinessPlanTriggerHandlerTest {
        Static Territory__c cu;
        Static Territory__c district;
        Static Territory__c territory;
    static TestMethod void validateBusinessPlanDuplicates(){
       //Creating Account
       Id accRt = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
        
        User RunningUser = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
        Account a = new Account(Name ='Test Account',RecordTypeid = accRt, ownerId = RunningUser.Id);
        insert a;
        
        System.Runas(RunningUser){
        
        Id bpRt = Schema.SObjectType.Business_Plan__c.getRecordTypeInfosByName().get('Distributor Business Plan').getRecordTypeId();
        Business_Plan__c bp = new Business_Plan__c();
        bp.RecordTypeId = bpRt;
        bp.Name = 'Test Plan';
        bp.Account__c = a.id;
        bp.Year__c ='2018';
        insert bp;
     
/*        Id oppRt = Schema.SObjectType.Opportunity.getRecordTypeInfosByDeveloperName().get(Label.DistributorCPSalesPlan).getRecordTypeId();
        Date dt = Date.Today();
        opportunity opp = new opportunity();
        opp.Name='Test Account';
        opp.AccountId= a.Id;
        opp.StageName = 'Won';
        opp.CloseDate = dt;
        opp.RecordTypeId= oppRt;
        opp.AccountBusinessPlan__c = bp.id;
        insert opp;
        
        //creating Product
        Id prodRt = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('CP Product').getRecordTypeId();
        Product2 p1 = new Product2(Product_ID__c='3467',Volume_L__c=47,Product_Line__c='CP',Product_Country__c='CA',Package_UOM__c='BG',Name='SYN CP Test',Min_Saleable_UoM__c='BG',Min_Saleable_UoM_Conversion__c=1.5,Base_UOM__c='KG',RecordTypeid = prodRt,AvailableforPlanning__c = True,isactive=true);
        insert p1;
        
        //creating pricebook and pricebook entires
        PriceBook_for_SalesPlan__mdt custommetadata = [select id,CPPriceBookID__c from PriceBook_for_SalesPlan__mdt where CPPriceBook__c = 'CP and SeedCare Price Book'];
        Pricebook2 cppricebook = new Pricebook2(id=custommetadata.CPPriceBookID__c,name='CP and SeedCare Price Book',IsActive = true);
        upsert cppricebook;
        id stdpricebook = Test.getStandardPricebookId();
        PricebookEntry pbe1=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=stdpricebook,IsActive=true);
        PricebookEntry pbe2=new PricebookEntry(UnitPrice=1,Product2Id=p1.id,Pricebook2Id=cppricebook.id,IsActive=true);
        insert pbe1;
        insert pbe2;
        
        //creating Opportunity Line Item
        OpportunityLineItem oli=new OpportunityLineItem();
        oli.PricebookEntryId = pbe1.id;
        oli.OpportunityId = opp.id;
        oli.CY_Planned_Sales1__c = 10;
        oli.Rolled_Up_CY_1_OTG_Sales_c__c  =10;
        oli.CY_1_Whole_Sale_OTG_Units__c =100;
        oli.Updated_OTG_Forecast_CY__c =100;
        oli.OTG_FRCST_CY__c=20;
        oli.Ending_Inventory_CY_1__c=90;
        oli.Ending_Inventory_Projection_CY__c =10;
        system.debug('Testing OLI creation');
        insert oli;
  */      
        //Updating BP
        
            Id bpRt2 = Schema.SObjectType.Business_Plan__c.getRecordTypeInfosByName().get('Distributor Business Plan').getRecordTypeId();
            Business_Plan__c bp2 = new Business_Plan__c();
            bp2.RecordTypeId = bpRt;
            bp2.Name = 'Test Plan';
            bp2.Account__c = a.id;
            bp2.Year__c ='2018';
            test.startTest();
        
            try{
                insert bp2;
            }
             catch(Exception e){
                System.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, Duplicate Error: Already Business Plan exists for the same Year: []', e.getMessage());
            }    
            test.stopTest();

        }
   }
}