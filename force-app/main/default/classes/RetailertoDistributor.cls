/**************************************************************************************
* Apex Class Name  :     RetailertoDistributor
* Version            :     1.0
* Created Date       :     06/April/2018
* Function           :     This is class to insert and update OLIs on Distributor, rolledup from Retailers 
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     06/April/2018                Created.
*************************************************************************************/
public class RetailertoDistributor implements Database.Batchable<Opportunity>,database.stateful{
    // Variable declaration   
    public List<Opportunity> Opp;
    public final Id globalOppId;
    public final Opportunity parentopp;
    public List<Exception_Log__c> exceptionList;
    public List<OpportunityLineItem> oliListtoInsert;
    public List<OpportunityLineItem> oliListtoUpdate;
    public Set<Id> existingprodids;
    public final String currentYear;
    public final String previousYear;
    public final String P_previousYear;
    public final String category;
    public final String recordType;
    public final String prodType;
    public final String country;
    public final String commercialunit;
    public final String accid;
    public final Set<Id> childprodids;
    
 /********************************************************************************************
 * Method   : Constructor
 * Description: To setup the data based on Parent Opportunity(Distributor)
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 06/April/2018  Srni       Created     
 ********************************************************************************************/    
    public RetailertoDistributor(Id parentid,Set<Id> childprdids){
        exceptionList = new List<Exception_Log__c>();
        if(parentid!=Null){
        globalOppId = parentid;
        try{
        parentopp=[select id,CommercialUnit__c,Year__c,RecordType.DeveloperName,Product_Type__c,Account.Account_ID__c from opportunity where id=:parentid];
        }
        catch(Exception e)
        {
          System.debug('Exception'+ e+' '+e.getCause()+' '+e.getLineNumber());
          exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoDistributor','RetailertoDistributor Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
        }
        commercialunit=parentopp.CommercialUnit__c;
        currentYear = parentopp.Year__c;
        previousYear = String.Valueof(Integer.valueof(currentYear) -1);
        P_previousYear = String.Valueof(Integer.valueof(currentYear) -2);
        prodType=parentopp.Product_Type__c; 
        accid=parentopp.Account.Account_ID__c;
        if(parentopp.Product_Type__c == 'CP'){
            recordType = Label.CP_Sales;
            }
        else{
            recordType = Label.Seeds_Sales;
            }
        }
        existingprodids=new Set<Id>();
        country='CA';
        category=Label.Sales_Plan_Actual_Channel_Category;
        opp = new List<Opportunity>();
        childprodids=childprdids;
        oliListtoInsert = new List<OpportunityLineItem>();
        oliListtoUpdate = new List<OpportunityLineItem>();
       }
 /********************************************************************************************
 * Method   : start
 * Description: To filter the Child Opportunities
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 06/April/2018  Srni       Created     
 ********************************************************************************************/
public Iterable<Opportunity> start(Database.BatchableContext bc){
    	    if(globalOppId != null)
            {
               existingprodids.addall(OLILookupsutility.getProdids(globalOppId,childprodids));
                try{
                //Query to get Child Opportunities
                Opp = [select id,AccountId,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,territory__c,Name,
                    AccountBusinessPlan__r.Year__c,CommercialUnit__c,PriceBook2Id,Sales_Plan_Type__c,CountofOppProducts__c,Product_Type__c,
                    RecordType.DeveloperName, Year__c from Opportunity where RelatedDistributorPlan__c =:globalOppId AND Product_Type__c=:prodType];
                   }
                catch(Exception e)
                {
                    Opp=null;
                    exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','RetailertoDistributor','start','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
                }
                return Opp; 
            }
            return null;
     }
 /********************************************************************************************
 * Method   : execute
 * Description: create olis to insert and Get Olis to Update
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 06/April/2018  Srni       Created     
 ********************************************************************************************/
public void execute(Database.BatchableContext BC,List<Opportunity> oppList){
    RollUpsUtilityClassWithoutBatch rollup=new RollUpsUtilityClassWithoutBatch(parentopp,childprodids);
    if(oppList!=null && oppList.size()!=0){
        try{
             oliListtoUpdate=rollup.updateOLIlist(oppList,existingprodids);
             if(oliListtoUpdate.size()!=0){
                    update oliListtoUpdate;
                 }   
              }
              catch(Exception e)
              {
                exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoDistributor','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));    
              }
       // Method call to get Oli list to insert
         try{
           oliListtoInsert=rollup.insertOLIlist(oppList,existingprodids,category);
            if(oliListtoInsert.size()!=0)
    		{
     		 insert oliListtoInsert;
    		}
        	}
        	catch(Exception e)
        	{
            exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoDistributor','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));    
        	}
		}
    }
/********************************************************************************************
 * Method   : finish
 * Description: Update OLIs with Rolledup Values
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 09/April/2018  Srni       Created     
 ********************************************************************************************/
public void finish(Database.BatchableContext BC) {
    Opportunity opportunity;
  		if(globalOppId!=Null){
        try{
        opportunity=[select id, RelatedCUPlan__c from opportunity where id=:globalOppId];
        }
           catch(Exception e)
           {
               System.debug('Exception got :'+e);
           }
        }
    	if(opportunity!=null){
        Id cuoppid=opportunity.RelatedCUPlan__c;
            if(cuoppid!=null){
                DistributortoCUPlan batch=new DistributortoCUPlan(cuoppid,childprodids);
        		Database.executeBatch(batch);
            }
       }
   if(exceptionList!=null)
        {
            try{
            insert exceptionList;
        	}
        	catch(Exception e)
            {
                System.debug('Exception '+e.getCause()+' '+e.getLineNumber());
                System.debug('Exception Log Insert Failed :'+exceptionList);
            }
        }
	}

}