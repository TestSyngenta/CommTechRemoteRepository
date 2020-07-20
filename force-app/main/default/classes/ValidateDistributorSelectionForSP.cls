/*********************************************************************************************
* Apex Class Name    :     ValidateDistributorSelectionForSP
* Version            :     1.0
* Created Date       :     04-Jan-2018
* Function           :     This is class used to validate and update Opportunity.  
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Ravikant                    04-Jan-2018            Created.
* Jyothsna                    05-Mar-2018            Modified
***********************************************************************************************/
public class ValidateDistributorSelectionForSP {
    
    /********************************************************************************************
* Method   : validateDistributorSelection
* Description: Generic method for validating the selection of "Related Distributor" on SP
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 04-Jan-2018  Ravikant           Created     
********************************************************************************************/
    public static void validateDistributorSelection(List<Opportunity> newOpp,Map<Id,Opportunity> oldOppMap){
        /* map of "AccountID+Year+RelatedDistributor" as key and instances of Opp as value to check the 
*  selection of Related Distributor. */
        Map<String,Opportunity> distributorOppNewMap = new Map<String,Opportunity>();
        Map<String,Opportunity> retailerOppNewMap = new Map<String,Opportunity>();
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Set<Id> accId  = new Set<Id>();
        Map<String,Opportunity> distAccOppMap = new Map<String,Opportunity>();
        try{
            if(newOpp.size() > 0){
                for(Opportunity o:newOpp){
                    if(o.RelatedDistributor__c != oldOppmap.get(o.Id).RelatedDistributor__c && o.RecordTypeId==oldOppmap.get(o.Id).RecordTypeId ){
                        distributorOppNewMap.put(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.RelatedDistributor__c), o);
                        accId.add(o.AccountId);
                    }
                    if(o.RecordTypeid==oppRecordtypes.get(Label.GrowerCPSalesPlanRecordType) || o.RecordTypeid==oppRecordtypes.get(Label.GrowerSeedsSalesPlanRecordType))
                    {
                        
                        if(o.Related_Retailer__c != oldOppmap.get(o.Id).Related_Retailer__c)
                        {
                            retailerOppNewMap.put(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c), o);
                            accId.add(o.AccountId);
                        }
                    }
                }
            }
            
            for(Opportunity o:[Select Id,RecordType.Name,RelatedDistributor__c,Related_Retailer__c,AccountID,Year__c FROM OPPORTUNITY WHERE AccountID IN: accId]){
                if(distributorOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.RelatedDistributor__c)) != null){
                    distributorOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.RelatedDistributor__c)).addError('This distributor is already related with some other Sales Plan');
                }
                
                if(retailerOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c)) != null){
                    retailerOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c)).addError('This retailer is already related with some other Sales Plan');
                }
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','ValidateDistributorSelectionForSP','validateDistributorSelection','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
/********************************************************************************************
* Method   : validateRelatedDistributor
* Description: Generic method for allowing single SP without related Distributor
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 03-April-2018  Sravani           Created     
********************************************************************************************/
    public static void validateRelatedDistributor(List<Opportunity> newOpp){
        Map<String,Opportunity> distributorOppNewMap = new Map<String,Opportunity>();
        Map<String,Opportunity> retailerOppNewMap = new Map<String,Opportunity>();
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Set<Id> accId  = new Set<Id>();
        Map<String,Opportunity> distAccOppMap = new Map<String,Opportunity>();
        try{
            if(newOpp.size() > 0){
                for(Opportunity o:newOpp){
                    if(o.RecordTypeid==oppRecordtypes.get(Label.RetailerSalesPlanRecordType) || o.RecordTypeid==oppRecordtypes.get(Label.RetailSeedsRecordType) || o.RecordTypeid==oppRecordtypes.get(Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name) || o.RecordTypeid==oppRecordtypes.get(Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name))
                    {
                        distributorOppNewMap.put(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.RelatedDistributor__c), o);
                        accId.add(o.AccountId);
                    }
                    if(o.RecordTypeid==oppRecordtypes.get(Label.GrowerCPSalesPlanRecordType) || o.RecordTypeid==oppRecordtypes.get(Label.GrowerSeedsSalesPlanRecordType))
                    {
                      retailerOppNewMap.put(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c), o);
                      accId.add(o.AccountId);
                        
                    }
                }
            }
            
            for(Opportunity o:[Select Id,RecordType.Name,RelatedDistributor__c,Related_Retailer__c,AccountID,Year__c FROM OPPORTUNITY WHERE AccountID IN: accId]){
                if(distributorOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.RelatedDistributor__c)) != null){
                    distributorOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.RelatedDistributor__c)).addError('One of the existing Retailer Plan on this account does not have a Related Distributor noted. Please add the required information.');
                }
                
                system.debug('Test class Testing' +retailerOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c)) );
                if(retailerOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c)) != null){
                    retailerOppNewMap.get(String.valueOf(o.AccountId)+String.valueOf(o.RecordTypeid)+String.valueOf(o.Year__c)+String.valueOf(o.Related_Retailer__c)).addError('One of the existing Grower Plan on this account does not have a Related Retailer noted. Please add the required information.');
                }
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','ValidateDistributorSelectionForSP','validateRelatedDistributor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
/********************************************************************************************
* Method   : updateAccountTerritory
* Description: Generic method for updating Account Territory on Opportunity when Territory field changes
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 06-Mar-2018  Jyothsna           Created     
********************************************************************************************/
    Public void updateAccountTerritory(List<Opportunity> newOpp,Map<Id,Opportunity> oldOppMap){
        List<Opportunity> oppList = new List<Opportunity>();
        set <String> acc = new set<String>();
        set <String> territory = new set<String>();
        List<Account_Territory__c> accT =new List<Account_Territory__c>();
        List<Opportunity> opps = new List<Opportunity>();
        Map<String,String> atMap = new Map<String,String>();
        try{
            for(Opportunity opp : newOpp){
                if(opp.Territory__c!= oldOppMap.get(opp.Id).Territory__c){
                    acc.add(opp.AccountId);
                    territory.add(opp.Territory__c);
                    opp.Account_Territory__c = null;
                    opps.add(opp);
                }
                
            }
            for(Account_Territory__c accterritory : [select id,Account__c,Territory__c from Account_Territory__c where Territory__c in :territory and Account__c in : acc]){
                atMap.put(String.valueOf(accterritory.Account__c)+accterritory.Territory__c, accterritory.Id);
            }
            for(Opportunity o:opps){
                if(atMap.get(String.valueOf(o.AccountId)+o.Territory__c) != null){
                    o.Account_Territory__c = atMap.get(String.valueOf(o.AccountId)+o.Territory__c);
                }
            }
            
        }
        
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','ValidateDistributorSelectionForSP','updateAccountTerritory','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
/********************************************************************************************
* Method   : updateOLI
* Description: To update OLI with related Distributor or related Retailer
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 01-June-2018  Sravani           Created     
********************************************************************************************/
    public static void updateOLI(List<Opportunity> oldOpp, List<Opportunity> newOpp){
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityLineItem> OLIList=new List<OpportunityLineItem>();
        Map<Id,String> reldistMap=new Map<Id,String>();
        Map<Id,String> relretMap=new Map<Id,String>();
        Map<Id,Opportunity> oldOppMap = new Map<Id,Opportunity>();
        
        for(Opportunity o: oldOpp){
            if(oldOppMap.get(o.Id) <> null){
                oldOppMap.put(o.Id, o);
            }
        }
        
        try
        {
            oppList=[select id,RelatedDistributor__r.name,Related_Retailer__r.name,RecordType.Developername from Opportunity where id in :newOpp];
            for(Opportunity opp:oppList)
            {
                if((opp.RecordType.Developername ==Label.RetailerSalesPlanRecordType ||opp.RecordType.Developername ==Label.RetailSeedsRecordType) && opp.RelatedDistributor__c!=null && opp.RelatedDistributor__c != oldOppMap.get(opp.Id).RelatedDistributor__c)
                {
                    reldistMap.put(opp.id, opp.RelatedDistributor__r.name);
                }
                else if((opp.RecordType.Developername ==Label.GrowerCPSalesPlanRecordType ||opp.RecordType.Developername ==Label.GrowerSeedsSalesPlanRecordType) && opp.Related_Retailer__c!=null && opp.Related_Retailer__c != oldOppMap.get(opp.Id).Related_Retailer__c)
                {
                    relretMap.put(opp.id, opp.Related_Retailer__r.name);
                }
            }
            OLIList=[select id,RelatedParentAccount__c,Opportunityid from OpportunityLineItem where (Opportunityid in :reldistMap.keySet() OR Opportunityid in :relretMap.keySet())];
            for(OpportunityLineItem oli:OLIList)
            {
                if(reldistMap.get(oli.Opportunityid)!=null)
                {
                  oli.RelatedParentAccount__c= reldistMap.get(oli.Opportunityid);  
                }
                else if(relretMap.get(oli.Opportunityid) !=null)
                {
                  oli.RelatedParentAccount__c= relretMap.get(oli.Opportunityid); 
                }
            }
            update OLIList;
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','ValidateDistributorSelectionForSP','updateOLI','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
}