/********************************************************************************************
* Class:        Test_DynamicLinkController
* Description:  tests Dynamic Link functionality
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 29-June-2018   Sravani.D 		    Created
********************************************************************************************/
@isTest
private class Test_DynamicLinkController {

	@testSetup
	static void testSetup() {
		User admin = TestDataFactory.createTestUserRecords('A633','System Administrator - Canada');
		System.runAs(admin) {
			//move to helper
			DL_Configuration__c dl1 = new DL_Configuration__c(Name = 'Distributor CP Quantity', Access__c = 'Internal & External', Active__c = true,
			        ButtonAction__c = 'Additional_Function', Category__c = 'Quantity', Object__c = 'Opportunity',RecordType__c='DistributorCPSalesPlan',
                    DL_Type__c='Formyoula Forms & Print PDF',URL_SF1__c='formyoula://?form_id=5b29e1cc92078500172fc72a&df51-3921-2501={!Id}&redirect=https://com.salesforce.salesforce1/{!Id}',
                    URL_Web__c='https://app.formyoula.com/mobile?form_id=5b29e1cc92078500172fc72a&df51-3921-2501={!Id}&redirect=https://syngentacanada--full.cs65.my.salesforce.com/{!Id}');
			insert dl1;
            
            Territory__c L1 = new Territory__c(TerritoryLevel__c='L1:Commercial unit',Sales_Org__c='1000',name='WCU',Assigned_Rep__c=admin.Id); //,Sales_Org_Description__c='Crop Protection and Seed'
            insert L1;
            Map<string,id> accRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Account.SObjectType);
    		Account a1 = new Account(Name ='testing account',recordtypeid =accRecordtypes.get(label.Planning_Account),Territory_Lookup__c=L1.id);
    		insert a1;
            Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
            opportunity oppr = new opportunity();
        	oppr.Name='testing opp';
        	oppr.AccountId= a1.Id;
        	oppr.StageName = 'Won';
        	oppr.RecordTypeId= oppRecordtypes.get(Label.CP_Distributor_Sales_Plan);
        	oppr.Year__c='2018'; 
        	oppr.Territory__c=L1.id;
            oppr.CloseDate=Date.Today();
        	insert oppr;

		}

	}


	@isTest
	static void testMethod1() {
        opportunity oppr=[select id from Opportunity where Year__c='2018'];
        DynamicLinkController dlc = new DynamicLinkController();
          Test.startTest();
        	System.currentPageReference().getParameters().put('id', oppr.id);
			System.currentPageReference().getParameters().put('action', 'Additional_Function');
        	System.currentPageReference().getParameters().put('category', 'Quantity');
            dlc.onLoad();
        	Test.stopTest();
   }
	
}