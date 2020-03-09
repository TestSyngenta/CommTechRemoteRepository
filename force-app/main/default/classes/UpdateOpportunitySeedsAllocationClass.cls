/**************************************************************************************
* Apex Class Name  :     UpdateOpportunitySeedsAllocationClass
* Version            :     1.0
* Created Date       :     04/Jan/2018
* Function           :     This is Functionality class for OpportunityLineItemTrigger Trigger
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     04/Jan/2018                Created.
*************************************************************************************/

public class UpdateOpportunitySeedsAllocationClass {
    /********************************************************************************************
    * Method   : updateOpportunityLineItem
    * Description: To call inside the Trigger by passing the values Trigger.oldmap and new
    * ------------------------------------------------------------------------------------------
    * Date          Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 04-Jan-2018  Srni       Created     
    ********************************************************************************************/
    public void updateOpportunityLineItem(Map<ID,OpportunityLineItem> oldlist,List<OpportunityLineItem> newlist)
    {
        // Query to fetch opportunity line item which has opportunity record type as 'District Seeds Sales Plan'and get updated. 
        List<OpportunityLineItem> seedsopplist=[select Id,FNS_CY__c,CY_1_Forecast_Sales__c,OliMatchingKey__c,opportunity.RecordType.Name from OpportunityLineItem where (opportunity.RecordType.developername =:Label.District_Seeds_Sales_Plan OR opportunity.RecordType.developername =:Label.Retailer_Seed_Sales_Plan OR opportunity.RecordType.developername =:Label.Territory_Seeds_Sales_Plan) and ID in :newlist];
        // To Map Matchingkey with opportunity line item
        Map<String, OpportunityLineItem> updatemap=new Map<String, OpportunityLineItem>();
        Map<String, OpportunityLineItem> allocatemap=new Map<String, OpportunityLineItem>();
        try
        {
        for(OpportunityLineItem newopplist: seedsopplist)
        {
            // To get old record 
            OpportunityLineItem oldopplist=oldlist.get(newopplist.ID);
            // To check any of these 2 fields are updated and if updated then add to Map for update.
            if(oldopplist.FNS_CY__c != newopplist.FNS_CY__c || oldopplist.CY_1_Forecast_Sales__c != newopplist.CY_1_Forecast_Sales__c)
            {
                updatemap.put(newopplist.OliMatchingKey__c,newopplist);
            } 
           System.debug('Update'+updatemap.keySet()); 
        }
        // Query to fetch opportunity line item which has opportunity record type as 'District Seeds Allocation'and matching key in updatemap.  
        if(updatemap!=null){
            List<OpportunityLineItem> updateopplist=[select Id,CY_Planned_Sales1__c,CY_1_Forecast_Sales__c,OliMatchingKey__c,opportunity.RecordType.Name from OpportunityLineItem where (opportunity.RecordType.developername =:Label.Seeds_Allocation_Dist_RT OR opportunity.RecordType.developername =:Label.Seeds_Allocation_Territory OR opportunity.RecordType.developername =:Label.Account_Seeds_Allocation) and OliMatchingKey__c in :updatemap.keySet()];
            if(!updateopplist.isEmpty()){
            for(OpportunityLineItem toupdate : updateopplist)
            {
                allocatemap.put(toupdate.OliMatchingKey__c, toupdate);
            }
            AggregateResult[] sumofrecord=[select sum(FNS_CY__c)fnssum,sum(CY_1_Forecast_Sales__c)cyfssum,OliMatchingKey__c from OpportunityLineItem where (opportunity.RecordType.developername =:Label.District_Seeds_Sales_Plan OR opportunity.RecordType.developername =:Label.Retailer_Seed_Sales_Plan OR opportunity.RecordType.developername =:Label.Territory_Seeds_Sales_Plan) and OliMatchingKey__c in :updatemap.keySet() group by OliMatchingKey__c];
            for(AggregateResult aggregated : sumofrecord)
            {
                // To get record to update whose matching keys are matched
                OpportunityLineItem newopp=allocatemap.get((String)aggregated.get('OliMatchingKey__c'));
                newopp.CY_Planned_Sales1__c = (Decimal)aggregated.get('fnssum');
                newopp.CY_1_Forecast_Sales__c = (Decimal)aggregated.get('cyfssum');
            }
            System.debug('updateopplist'+updateopplist);
            
                update updateopplist;
            }
        }
        }
        catch(Exception e)
        {
            System.debug('Exception :'+e.getStackTraceString()+ ' '+e.getLineNumber());
            Exception_Log__c exceptionlog=ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','UpdateOpportunitySeedsAllocationClass','updateOpportunityLineItem','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());        
            insert exceptionlog;
        }
        
    }
    
    /********************************************************************************************
    * Method   : seedsupdateOpportunityLineItem
    * Description: To call inside the Trigger by passing the values Trigger.oldmap and new
    * ------------------------------------------------------------------------------------------
    * Date          Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 06-Feb-2018  Srni       Created     
    ********************************************************************************************/  
    public void seedsupdateOpportunityLineItem(Map<ID,OpportunityLineItem> oldlist,List<OpportunityLineItem> newlist)
    {
        try
        {
        List<OpportunityLineItem> newolilist=[select id,opportunityid,opportunity.recordtype.developername,OliMatchingKey__c,
                                              CurrentAllocationUnits__c from OpportunityLineItem where id in :newlist];
        Map<String,Decimal> alctnMap=new Map<String,Decimal>();
        Map<String,Integer> alctncount=new Map<String,Integer>();
        List<OpportunityLineItem> seedsolilist=new List<OpportunityLineItem>();
        String recordtype;
        for(OpportunityLineItem newoli:newolilist){
        recordtype=newoli.opportunity.recordtype.developername;
        System.debug('Record Type'+recordtype);
        if(recordtype==Label.Account_Seeds_Allocation||recordtype==Label.Seeds_Allocation_Dist_RT||recordtype==Label.Seeds_Allocation_Territory)
        {
            OpportunityLineItem oldoli= oldlist.get(newoli.ID);
            if(newoli.CurrentAllocationUnits__c!=oldoli.CurrentAllocationUnits__c)
            {
                alctnMap.put(newoli.OliMatchingKey__c, newoli.CurrentAllocationUnits__c);
            }
        }
        }
        if(alctnMap!=Null)
        {
        seedsolilist=[select id,product2id,opportunity.recordtype.developername,OliMatchingKey__c, FNS_CY_ALCTD__c from OpportunityLineItem 
                                            where 
                                            (opportunity.recordtype.developername = :Label.District_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.Territory_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.RetailSeedsRecordType)
                                            and OliMatchingKey__c in :alctnMap.keyset()];
         AggregateResult[] countofprd=[select OliMatchingKey__c,count(id)tot
                                             from OpportunityLineItem 
                                            where 
                                            (opportunity.recordtype.developername = :Label.District_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.Territory_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.RetailSeedsRecordType)
                                            and OliMatchingKey__c in :alctnMap.keyset() 
                                      		group by OliMatchingKey__c];
        if(countofprd!=null){
        for(AggregateResult ar:countofprd)
        {
            alctncount.put((String)ar.get('OliMatchingKey__c'),(Integer)ar.get('tot'));
        }     
        }
        if(seedsolilist!=null)
        {
        for(OpportunityLineItem seedsoli:seedsolilist)
        {
            seedsoli.FNS_CY_ALCTD__c=alctnMap.get(seedsoli.OliMatchingKey__c)/alctncount.get(seedsoli.OliMatchingKey__c);
        }
        }
           update seedsolilist;
       }  
        
       }
        catch(Exception e)
        {
            System.debug('Exception :'+e.getStackTraceString()+ ' '+e.getLineNumber()+' '+e.getMessage()+' '+e.getCause() );
            Exception_Log__c exceptionlog=ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','UpdateOpportunitySeedsAllocationClass','seedsupdateOpportunityLineItem','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());        
            insert exceptionlog;
        }
	}
  
    /********************************************************************************************
    * Method   : seedsupdatebeforeInsert
    * Description: To call inside the Trigger by passing the values Trigger.oldmap and new
    * ------------------------------------------------------------------------------------------
    * Date          Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 14-Feb-2018  Srni       Created     
    ********************************************************************************************/  
    public void seedsupdatebeforeInsert(List<OpportunityLineItem> newlist)
    {   
        List<OpportunityLineItem> allocationopplist=new List<OpportunityLineItem>();
        Map<OpportunityLineItem,Id> mapwithoppid=new Map<OpportunityLineItem,Id>();
        try
        {
        for(OpportunityLineItem newOli:newlist)
        {
            mapwithoppid.put(newOli,newOli.OpportunityId);
        }
        Map<Id,Opportunity> newopplist=new Map<Id,Opportunity>([select id,recordtype.developername from Opportunity where id in :mapwithoppid.values() and (Recordtype.developername=:Label.Seeds_Allocation_Dist_RT or RecordType.developername =:Label.Seeds_Allocation_Territory or RecordType.developername =:Label.Account_Seeds_Allocation)]);
        for(OpportunityLineItem newopp:newlist)
        {
            if(newopplist.containsKey(newopp.OpportunityId))
            {
                allocationopplist.add(newopp);
            }
        }
        // To Map Matchingkey with opportunity line item
        Map<String, OpportunityLineItem> updatemap=new Map<String, OpportunityLineItem>();
        List<OpportunityLineItem> seedsopplist=new List<OpportunityLineItem>();
        if(allocationopplist!=null && allocationopplist.size()!=0){
        for(OpportunityLineItem newolilist: allocationopplist)
        {
          updatemap.put(newolilist.OliMatchingKey__c,newolilist);
        }
        if(updatemap!=null)
        {
          AggregateResult[] sumofrecord=[select sum(FNS_CY__c)fnssum,sum(CY_1_Forecast_Sales__c)cyfssum,OliMatchingKey__c from OpportunityLineItem where (opportunity.RecordType.developername =:Label.District_Seeds_Sales_Plan OR opportunity.RecordType.developername =:Label.Retailer_Seed_Sales_Plan OR opportunity.RecordType.developername =:Label.Territory_Seeds_Sales_Plan) and OliMatchingKey__c in :updatemap.keySet() group by OliMatchingKey__c];
            for(AggregateResult aggregated : sumofrecord)
            {
                // To get record to update whose matching keys are matched
                OpportunityLineItem newoli=updatemap.get((String)aggregated.get('OliMatchingKey__c'));
                newoli.CY_Planned_Sales1__c = (Decimal)aggregated.get('fnssum');
                newoli.CY_1_Forecast_Sales__c = (Decimal)aggregated.get('cyfssum');
            }
         }
        }
        }
        catch(Exception e)
        {
           System.debug('Exception :'+e.getStackTraceString()+ ' '+e.getLineNumber());
            Exception_Log__c exceptionlog=ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','UpdateOpportunitySeedsAllocationClass','seedsupdatebeforeInsert','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());        
            insert exceptionlog; 
        }
    }
    
    /********************************************************************************************
    * Method   : seedsinsertOpportunityLineItem
    * Description: To call inside the Trigger by passing the values new
    * ------------------------------------------------------------------------------------------
    * Date          Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 15-Feb-2018  Srni       Created     
    ********************************************************************************************/  
    public void seedsinsertOpportunityLineItem(List<OpportunityLineItem> newlist)
    {
        try
        {
        List<OpportunityLineItem> newolilist=[select id,opportunityid,opportunity.recordtype.developername,OliMatchingKey__c,
                                              AllocatedBaselineUnits__c from OpportunityLineItem where id in :newlist];
        Map<String,Decimal> alctnMap=new Map<String,Decimal>();
        Map<String,Integer> alctncount=new Map<String,Integer>();
        List<OpportunityLineItem> seedsolilist=new List<OpportunityLineItem>();
        String recordtype;
        for(OpportunityLineItem newoli:newolilist){
        recordtype=newoli.opportunity.recordtype.developername;
        System.debug('Record Type'+recordtype+'\nMatching Key'+newoli.OliMatchingKey__c+'\nCurrent Allocation Units'+newoli.AllocatedBaselineUnits__c);
        if(recordtype==Label.Account_Seeds_Allocation||recordtype==Label.Seeds_Allocation_Dist_RT||recordtype==Label.Seeds_Allocation_Territory)
        {
            if(newoli.AllocatedBaselineUnits__c!=null)
            {
                alctnMap.put(newoli.OliMatchingKey__c, newoli.AllocatedBaselineUnits__c);
            }
        }
         //System.debug('Allocation Map ------->'+alctnMap);
        }
        if(alctnMap!=Null)
        {
        System.debug('Allocation Map *****'+alctnMap);
        seedsolilist=[select id,product2id,opportunity.recordtype.developername,OliMatchingKey__c, FNS_CY_ALCTD__c from OpportunityLineItem 
                                            where 
                                            (opportunity.recordtype.developername = :Label.District_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.Territory_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.RetailSeedsRecordType)
                                            and OliMatchingKey__c in :alctnMap.keyset()];
         AggregateResult[] countofprd=[select OliMatchingKey__c,count(id)tot
                                             from OpportunityLineItem 
                                            where 
                                            (opportunity.recordtype.developername = :Label.District_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.Territory_Seeds_Sales_Plan or opportunity.recordtype.developername =:Label.RetailSeedsRecordType)
                                            and OliMatchingKey__c in :alctnMap.keyset() 
                                      		group by OliMatchingKey__c];
        if(countofprd!=null){
        for(AggregateResult ar:countofprd)
        {
            alctncount.put((String)ar.get('OliMatchingKey__c'),(Integer)ar.get('tot'));
        }     
        }
        if(seedsolilist!=null)
        {
        for(OpportunityLineItem seedsoli:seedsolilist)
        {
            seedsoli.FNS_CY_ALCTD__c=alctnMap.get(seedsoli.OliMatchingKey__c)/alctncount.get(seedsoli.OliMatchingKey__c);
        }
        }
           update seedsolilist;
       }  
        
       }
        catch(Exception e)
        {
            System.debug('Exception :'+e.getStackTraceString()+ ' '+e.getLineNumber()+' '+e.getMessage()+' '+e.getCause() );
            Exception_Log__c exceptionlog=ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','UpdateOpportunitySeedsAllocationClass','seedsupdateOpportunityLineItem','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());        
            insert exceptionlog;
        }
	}
}