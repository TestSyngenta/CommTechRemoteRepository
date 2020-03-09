/**************************************************************************************
* Apex Class Name  :     DistributortoCUPlan
* Version            :     1.0
* Created Date       :     09/April/2018
* Function           :     This is class to insert OLIs on CUPlan, rolledup from Distributors 
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     09/April/2018                Created.
*************************************************************************************/
public class DistributortoCUPlan implements Database.Batchable<Opportunity>,database.stateful{
    // Variable declaration   
    public List<Opportunity> Opp;
    public final Id globalOppId;
    public final Opportunity parentopp;
    public List<Exception_Log__c> exceptionList;
    public List<OpportunityLineItem> oliListtoInsert;
    public List<OpportunityLineItem> oliListtoupdate;
    public Set<Id> existingprodids;
    public final String currentYear;
    public final String previousYear;
    public final String P_previousYear;
    public final String category;
    public final String recordType;
    public final String opprecordType;
    public final String prodType;
    public final String country;
    public final String commercialunit;
    public final String accid;
    public final Set<Id> childprodids;
    
 /********************************************************************************************
 * Method   : Constructor
 * Description: To setup the data based on Parent Opportunity(CUPlan)
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 06/April/2018  Srni       Created     
 ********************************************************************************************/    
        public DistributortoCUPlan(Id parentid,Set<Id> childprdids){
        exceptionList = new List<Exception_Log__c>();
        if(parentid!=Null){
            globalOppId = parentid;
            try{
              parentopp=[select id,RecordType.DeveloperName,CommercialUnit__c,Year__c,Product_Type__c,Account.Account_ID__c from opportunity where id=:parentid];  
            }
            catch(Exception e)
            {
                System.debug('Exception'+ e+' '+e.getCause()+' '+e.getLineNumber());
                exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','DistributortoCUPlan','DistributortoCUPlan Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
            }
        commercialunit=parentopp.CommercialUnit__c;
        currentYear = parentopp.Year__c;
        previousYear = String.Valueof(Integer.valueof(currentYear) -1);
        P_previousYear = String.Valueof(Integer.valueof(currentYear) -2);
        prodType=parentopp.Product_Type__c; 
        accid=parentopp.Account.Account_ID__c;
        if(parentopp.Product_Type__c == 'CP'){
            recordType = Label.CP_Sales;
            opprecordType=Label.CP_Distributor_Sales_Plan;
        }
        else{
            recordType = Label.Seeds_Sales;
            opprecordType=Label.Seeds_Distributor_Sales_Plan;
        }
        }
        existingprodids=new Set<Id>();
        country='CA';
        category=Label.Sales_Plan_Actual_Area_Category;
        opp = new List<Opportunity>();
        childprodids=childprdids;
        oliListtoInsert = new List<OpportunityLineItem>();
        oliListtoupdate = new List<OpportunityLineItem>();
        }
 /********************************************************************************************
 * Method   : start
 * Description: To filter the Child Opportunities
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 09/April/2018  Srni       Created     
 ********************************************************************************************/     
         public Iterable<Opportunity> start(Database.BatchableContext bc){
            if(globalOppId != null)
            {
                existingprodids.addall(OLILookupsutility.getProdids(globalOppId,childprodids));
                try{
                   //Query to get Child Opportunities
                Opp = [select id,AccountId,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,territory__c,Name,
                    AccountBusinessPlan__r.Year__c,CommercialUnit__c,PriceBook2Id,Sales_Plan_Type__c,CountofOppProducts__c,Product_Type__c,
                    RecordType.DeveloperName, Year__c from Opportunity where RecordType.DeveloperName =:opprecordType AND RelatedCUPlan__c =:globalOppId AND Product_Type__c=:prodType];
                 }
                catch(Exception e)
                {
                    Opp=null;
                    exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','DistributortoCUPlan','start','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
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
 * 09/April/2018  Srni       Created     
 ********************************************************************************************/
         public void execute(Database.BatchableContext BC,List<Opportunity> oppList){
           RollUpsUtilityClassWithoutBatch rollup=new RollUpsUtilityClassWithoutBatch(parentopp,childprodids);
            if(oppList!=null && oppList.size()!=0){
              //Method call to insert OLIs
              try{
                oliListtoInsert.addAll(rollup.insertOLIwithrollup(oppList,existingprodids,category));
                if(!oliListtoInsert.isEmpty()){
             	 insert oliListtoInsert;
             	}
              }
              catch(Exception e)
              {
                exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','DistributortoCUPlan','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
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
                    exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','DistributortoCUPlan','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
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
        if(exceptionList!=null)
        {
            try{
            insert exceptionList;
        	}
        	catch(Exception e)
            {
                System.debug('Exception Log Insert Failed :'+exceptionList);
            }
        } 
	}
      
}