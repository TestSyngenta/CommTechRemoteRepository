/**************************************************************************************
* Apex Class Name  :     RetailertoHeadOffice
* Version            :     1.0
* Created Date       :     09/April/2018
* Function           :     This is class to insert OLIs on HeadOffice, rolledup from Retailers 
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     09/April/2018                Created.
*************************************************************************************/
public class RetailertoHeadOfficeNoBatch {
    // Variable declaration   
    public List<Opportunity> oppList;
    public final Id globalOppId;
    public final Opportunity parentopp;
    public List<OpportunityLineItem> oliListtoInsert;
    public List<OpportunityLineItem> oliListtoUpdate;
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
    public final Set<Id> childprodids;
   
 /********************************************************************************************
 * Method   : Constructor
 * Description: To setup the data based on Parent Opportunity(HeadOffice)
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 09/April/2018  Srni       Created     
 ********************************************************************************************/    
       public RetailertoHeadOfficeNoBatch(Id parentid,Set<Id> childprdids){ 
        exceptionList = new List<Exception_Log__c>();
        if(parentid!=Null){
            globalOppId = parentid;
            try{
            parentopp=[select id,CommercialUnit__c,Year__c,RecordType.DeveloperName,Product_Type__c,Account.Account_ID__c from opportunity where id=:parentid];  
            }
            catch(Exception e)
            {
            System.debug('Exception'+ e+' '+e.getCause()+' '+e.getLineNumber());
            exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoHeadOffice','RetailertoHeadOffice Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
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
        category=Label.Retail_OTG_Sales;
        oppList = new List<Opportunity>();
        childprodids=childprdids;
        oliListtoInsert = new List<OpportunityLineItem>();
        oliListtoUpdate = new List<OpportunityLineItem>();
        }
 /********************************************************************************************
 * Method   : start
 * Description: To filter the child opportunities
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 09/April/2018  Srni       Created     
 ********************************************************************************************/     
        public void start(){
            if(globalOppId != null)
            {
               existingprodids.addall(OLILookupsutility.getProdids(globalOppId,childprodids));
               try{
                //Query to get Child Opportunities
                oppList = [select id,AccountId,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,territory__c,Name,
                    AccountBusinessPlan__r.Year__c,CommercialUnit__c,PriceBook2Id,Sales_Plan_Type__c,CountofOppProducts__c,Product_Type__c,
                    RecordType.DeveloperName, Year__c from Opportunity where RelHeadOfficePlan__c =:globalOppId AND Product_Type__c=:prodType];
                }
                catch(Exception e)
                {
                    oppList=null;
                    exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','RetailertoHeadOffice','start','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));        
                }
            }
        /*Execute */
         RollUpsUtilityClassWithoutBatch rollup=new RollUpsUtilityClassWithoutBatch(parentopp,childprodids);
         if(oppList!=null && oppList.size()!=0){
            try{
             oliListtoUpdate.addAll(rollup.updateOLIlist(oppList,existingprodids));
             if(oliListtoUpdate.size()!=0){
                    update oliListtoUpdate;
                 }   
              }
              catch(Exception e)
              {
                exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoHeadOffice','execute','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));    
              }   
              
        // Method call to get Oli list to insert
        try{
           oliListtoInsert.addall(rollup.insertOLIlist(oppList,existingprodids,category)); 
           if(oliListtoInsert.size()!=0)
            {
             insert oliListtoInsert;
            }
        }
        catch(Exception e)
            {
            exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoHeadOffice','executeretailer','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));    
            }     
        }  
        
        /* Finish */
       Opportunity opportunity;
       if(globalOppId!=Null){
           try{
               opportunity=[select id, RelatedTerritoryPlan__c,RelatedDistributorPlan__c from opportunity where id=:globalOppId];
           }
           catch(Exception e)
           {
               exceptionList.add(ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','RetailertoHeadOffice','finish','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage()));    
           }
       }
        if(opportunity!=null){
        Id distributoroppid=opportunity.RelatedDistributorPlan__c;
            if(distributoroppid!=null){
                RetailertoDistributorNoBatch batch=new RetailertoDistributorNoBatch(distributoroppid,childprodids);
                batch.Start();
                
                /*
                RetailertoDistributor batch=new RetailertoDistributor(distributoroppid,childprodids);
                Database.executeBatch(batch);
                */
            }
        /*Id terroppid=opportunity.RelatedTerritoryPlan__c;
            if(terroppid!=null){
                RetailtoTerritory batch=new RetailtoTerritory(terroppid,childprodids);
                Database.executeBatch(batch);
            }*/
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