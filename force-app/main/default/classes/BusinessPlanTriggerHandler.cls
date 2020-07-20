/*********************************************************************************************
* Apex Class Name    :     BusinessPlanTriggerHandler
* Version            :     1.0
* Created Date       :     05-March-2018
* Function           :     This is class is used to validate the duplicates on Business Plan.  
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Jyothsna                    05-March-2018            Created
***********************************************************************************************/
public class BusinessPlanTriggerHandler {
    /********************************************************************************************
* Method   : validateBusinessPlanDuplicates
* Description: Generic method for restricting duplicates on Business Plan for the same year 
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 05-March-2018 Jyothsna                          Created  
********************************************************************************************/
    
    Public  void validateBusinessPlanDuplicates(list<Business_Plan__c> keys){
        try{
            List<string> bpKey = new List<string>();
            List<string> bpKey1 = new List<string>();
            List<string> bpKey2 = new List<string>();
            for (Business_Plan__c bp : keys){
                bpKey.add(bp.Account__c +'|' + bp.Year__c  + '|' +bp.RecordTypeId);
            }
            Map<String,Business_Plan__c> bpKeySet = new Map<String,Business_Plan__c>();
            for(Business_Plan__c bpList : [Select id,Unique_key__c,Year__c,RecordTypeId,RecordType.DeveloperName,Account__c from Business_Plan__c where Unique_key__c in :bpKey]){
               bpKeySet.put(bpList.Unique_key__c, bpList);
            }
            
            for (Business_Plan__c bp : keys){
                if(bpKeySet.get(bp.Account__c +'|' + bp.Year__c  + '|' +bp.RecordTypeId)!=null){
                   bp.addError('Duplicate Error: Already Business Plan exists for the same Year');
                }
            }
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Business_Plan__c','NA','BusinessPlanTriggerHandler','validateBusinessPlanDuplicates','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    Public  void validateBusinessPlanDuplicatesOnUpdate(List<Business_Plan__c> newBPList,Map<Id,Business_Plan__c> bpOldMap){
        try{
            List<string> newbpKeys = new List<string>();
            Map<String,Business_Plan__c> uniqueKeyMap = new Map<String,Business_Plan__c>();
            for (Business_Plan__c bp : newBPList){
                newbpKeys.add(bp.Account__c +'|' + bp.Year__c  + '|' +bp.RecordTypeId);               
            }
            for(Business_Plan__c bpList : [Select id,Unique_key__c,Year__c,RecordType.DeveloperName,Account__c from Business_Plan__c where Unique_key__c in :newbpKeys]){
                uniqueKeyMap.put(bpList.Unique_key__c, bpList);
            }
            for (Business_Plan__c bp : newBPList){
                if(uniqueKeyMap.containsKey(bp.Account__c +'|' + bp.Year__c  + '|' +bp.RecordTypeId) && uniqueKeyMap.get(bp.Account__c +'|' + bp.Year__c  + '|' +bp.RecordTypeId).Unique_key__c != bpOldMap.get(bp.Id).Unique_key__c){
                    bp.addError('Duplicate Error: Already Business Plan exists for the same Year');
                }
            }
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Business_Plan__c','NA','BusinessPlanTriggerHandler','validateBusinessPlanDuplicates','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }
     /********************************************************************************************
* Method   : updateCYPlannedSales
* Description: Generic method for dafaulting CY Planned Sales for Distributor when Business Plan is locked 
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 09-Mar-2018   Jyothsna                          Created  
********************************************************************************************/
 /*  Method deprecated due to new way of locking forecasts
 
    Public  void updateCYPlannedSales(list<Business_Plan__c> keys, Map<Id,Business_Plan__c> oldBusinessPlanValues){
        List<string> bpKey = new List<string>();
        List<string> bpKeyList = new List<string>();
        try{

         for (Business_Plan__c bp : keys){
            if(oldBusinessPlanValues.get(bp.id).Lock_Business_Plan__c != bp.Lock_Business_Plan__c &&  bp.Lock_Business_Plan__c == TRUE){
                bpKey.add(bp.Id);
            }   
            else {
                bpKeyList.add(bp.id);
            }
        }
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        String recType = Label.DistributorCPSalesPlan;
        
        for(OpportunityLineItem oli: [select id,OpportunityId, CY_Planned_Sales1__c,Ending_Inventory_CY_1__c, Ending_Inventory_Projection_CY__c ,Opportunity.AccountBusinessPlan__c, Updated_OTG_Forecast_CY__c,OTG_FRCST_CY__c, Related_Business_Plan_Locked__c   from OpportunityLineItem where Opportunity.AccountBusinessPlan__c in : bpKey and Opportunity.RecordType.DeveloperName = :recType]){
                oli.Related_Business_Plan_Locked__c = 'Locked';
                oli.Updated_OTG_Forecast_CY__c = oli.OTG_FRCST_CY__c;
               if( oli.Updated_OTG_Forecast_CY__c !=null && oli.Ending_Inventory_CY_1__c !=null && oli.Ending_Inventory_Projection_CY__c !=null){
               oli.CY_Planned_Sales1__c =  (oli.Updated_OTG_Forecast_CY__c * (oli.Ending_Inventory_Projection_CY__c/100) ) + (oli.Updated_OTG_Forecast_CY__c - oli.Ending_Inventory_CY_1__c);
               if(oli.CY_Planned_Sales1__c < 0){
                   oli.CY_Planned_Sales1__c = 0;
               }
               oliList.add(oli);
          }
       }
        for(OpportunityLineItem oli: [select id,OpportunityId, CY_Planned_Sales1__c,Ending_Inventory_CY_1__c, Ending_Inventory_Projection_CY__c ,Opportunity.AccountBusinessPlan__c, OTG_FRCST_CY__c from OpportunityLineItem where Opportunity.AccountBusinessPlan__c in : bpKeyList and Opportunity.RecordType.DeveloperName = :recType]){
            //system.debug('Testing values' +oli.OTG_FRCST_CY__c +' ' +oli.Ending_Inventory_Projection_CY__c +' ' +oli.Ending_Inventory_CY_1__c);
            if(oli.OTG_FRCST_CY__c !=null && oli.Ending_Inventory_CY_1__c !=null && oli.Ending_Inventory_Projection_CY__c !=null){
                 oli.CY_Planned_Sales1__c =  (oli.OTG_FRCST_CY__c * (oli.Ending_Inventory_Projection_CY__c /100)) + (oli.OTG_FRCST_CY__c - oli.Ending_Inventory_CY_1__c);
                 oliList.add(oli);
            }
            if(oli.CY_Planned_Sales1__c < 0){
                   oli.CY_Planned_Sales1__c = 0;
            }
        }  
       update oliList;
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Business_Plan__c','NA','BusinessPlanTriggerHandler','updateCYPlannedSales','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }
    }*/
/********************************************************************************************
* Method   : updateCYPlannedSales
* Description: Generic method for dafaulting CY Planned Sales for Distributor when Business Plan is locked and 
               every time OLI is edited
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 22-Mar-2018   Jyothsna                          Created  
********************************************************************************************/
    Public static void updateOLICYPlannedSales(list<OpportunityLineItem> keys){
        List<string> oppKey = new List<string>();
        try{
            for (OpportunityLineItem o : keys){
                if(o.RelatedOpportunityRecordType__c == Label.DistributorCPSalesPlan){
                    oppKey.add(o.OpportunityId);
                }
                else break;    
            }
            
            Map<Id,Boolean> oppMap = new Map<Id,Boolean>();
            Map<Id,Boolean> oppMapValues = new Map<Id,Boolean>();
            String recType = Label.DistributorCPSalesPlan;
            
            if(oppKey.size() > 0){
                for(Opportunity opp :[select id,AccountBusinessPlan__r.Lock_Business_Plan__c from Opportunity where Id in :oppKey and RecordType.DeveloperName = :recType]){
                        oppMapValues.put(opp.id, opp.AccountBusinessPlan__r.Lock_Business_Plan__c);
                }
               for(OpportunityLineItem oli: keys){
                    /*if(oppMap.get(oli.OpportunityId)!= null && oli.Updated_OTG_Forecast_CY__c !=null && oli.Ending_Inventory_CY_1__c !=null && oli.Ending_Inventory_Projection_CY__c !=null){
                        oli.CY_Planned_Sales1__c = (oli.Updated_OTG_Forecast_CY__c * (oli.Ending_Inventory_Projection_CY__c/100) ) + (oli.Updated_OTG_Forecast_CY__c - oli.Ending_Inventory_CY_1__c);
                        if(oli.CY_Planned_Sales1__c < 0){
                              oli.CY_Planned_Sales1__c = 0;
                        }
                    }*/
                    if(oppMapValues.get(oli.OpportunityId)!= null && oli.OTG_FRCST_CY__c !=null && oli.Ending_Inventory_CY_1__c !=null && oli.Ending_Inventory_Projection_CY__c !=null){
                        oli.CY_Planned_Sales1__c = (oli.OTG_FRCST_CY__c *(oli.Ending_Inventory_Projection_CY__c/100) ) + (oli.OTG_FRCST_CY__c - oli.Ending_Inventory_CY_1__c);
                        if(oli.CY_Planned_Sales1__c < 0){
                           oli.CY_Planned_Sales1__c = 0;
                        }
                    }
                }
            }     
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','BusinessPlanTriggerHandler','updateOLICYPlannedSales','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionLogRecord;
        }        
    }    
}