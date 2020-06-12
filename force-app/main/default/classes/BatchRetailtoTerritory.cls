/**************************************************************************************
* Apex Class Name  :     BatchRetailtoTerritory
* Version            :     1.0
* Created Date       :     22/Jan/2018
* Function           :     This is Batch class to insert OLIs on Territory Plan, rolledup from Retail 
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     22/Jan/2018                Created.
*************************************************************************************/
public class BatchRetailtoTerritory  implements Database.Batchable<Opportunity>,database.stateful{
    // Variable declaration   
    public List<Opportunity> Opp;
    public final Id globalOppId;
    public final Opportunity parentopp;
    public List<OpportunityLineItem> oliListtoInsert;
    public List<OpportunityLineItem> oliListtoupdate;
    public List<Exception_Log__c> exceptionList;
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
 
 /********************************************************************************************
 * Method   : Constructor
 * Description: To setup the data based on Parent Opportunity(District)
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 22/Jan/2018  Srni       Created     
 ********************************************************************************************/    
        public BatchRetailtoTerritory(Id parentid){ 
        exceptionList = new List<Exception_Log__c>();
        if(parentid!=Null){
        globalOppId = parentid;
        try{ 
        parentopp=[select id,CommercialUnit__c,isBatchprocessing__c,Year__c,RecordType.DeveloperName,Product_Type__c,Account.Account_ID__c from opportunity where id=:parentid];
        }
        catch(Exception e)
        {
           System.debug('Exception'+ e+' '+e.getCause()+' '+e.getLineNumber());
           exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','BatchRetailtoTerritory','BatchRetailtoTerritory Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
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
        category=Label.Sales_Plan_Actual_Area_Category;
        opp = new List<Opportunity>();
        oliListtoInsert = new List<OpportunityLineItem>();
        oliListtoupdate = new List<OpportunityLineItem>();
        
       }
 /********************************************************************************************
 * Method   : start
 * Description: Batch implementation Method to pass data to execute method
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 22/Jan/2018  Srni       Created     
 ********************************************************************************************/     
         public Iterable<Opportunity> start(Database.BatchableContext bc){
            if(globalOppId != null)
            {
                existingprodids.addall(OLILookupsutility.getProdids(globalOppId));
                try{
            		
                 //Query to get Child Opportunities
                	Opp = [select id,AccountId,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,territory__c,Name,
                    AccountBusinessPlan__r.Year__c,CommercialUnit__c,PriceBook2Id,Sales_Plan_Type__c,CountofOppProducts__c,Product_Type__c,
                    RecordType.DeveloperName, Year__c from Opportunity where RelatedTerritoryPlan__c =:globalOppId AND Product_Type__c=:prodType /* Ticket TKT-068860 IST Start: By Sravani */and RelHeadOfficePlan__c =null /* Stop TKT-068860 */];
                 }
                catch(Exception e)
                {
                    exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','BatchRetailtoTerritory','start','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
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
 * 18/Jan/2018  Srni       Created     
 ********************************************************************************************/
         public void execute(Database.BatchableContext BC, List<Opportunity> oppList){
            RollUpsUtilityClass rollup=new RollUpsUtilityClass(parentopp);
            if(oppList!=null && oppList.size()!=0){
              //Method call to insert OLIs
              try{
                oliListtoInsert.addAll(rollup.insertOLIwithrollup(oppList,existingprodids,category));
              	if(!oliListtoInsert.isEmpty()){
              	insert oliListtoInsert;
                //Lookups Mapping
            	OLILookupsutility.updateOLIwithlookups(oliListtoInsert);
            	update oliListtoInsert;
            	}
              }
            catch(Exception e)
            {
                System.debug('Transaction Failed'+e+' '+e.getLineNumber());
                exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','BatchRetailtoTerritory','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
            }
           // Method call to update existing OLIs 
            try{
                   oliListtoupdate.addall(rollup.updateOLIwithrollup(oppList,existingprodids));
                   if(!oliListtoupdate.isEmpty())
            		{
            		update oliListtoupdate;
            		}
                }
                catch(Exception e)
                {
                System.debug('Update Failed'+e+' '+e.getLineNumber());
                exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','BatchRetailtoTerritory','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
				}
			}
		}
 /********************************************************************************************
 * Method   : finish
 * Description: Insert olis and update with lookups
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 18/Jan/2018  Srni       Created     
 ********************************************************************************************/
     public void finish(Database.BatchableContext BC) {
        Opportunity opportunity;
  		if(globalOppId!=Null){
        try{
     	opportunity=[select id, RelatedTerritoryPlan__c from opportunity where id=:globalOppId];
        }
           catch(Exception e)
           {
               exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','BatchRetailtoTerritory','finish','SOQL exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
           }
        }
        if(opportunity!=null){
        Id districtoppid=opportunity.RelatedTerritoryPlan__c;
            if(districtoppid !=null){
                BatchTerritorytoDistrict batch=new BatchTerritorytoDistrict(districtoppid);
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
                System.debug('Exception Log Insert Failed :'+exceptionList + ' '+e);
            }
        	} 
      }
}