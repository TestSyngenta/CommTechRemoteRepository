/**************************************************************************************
* Apex Class Name  :     OLILookupsutility
* Version            :     1.0
* Created Date       :     19/Jan/2018
* Function           :     This is Utility class 
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     19/Jan/2018                Created.
*************************************************************************************/
public class OLILookupsutility {

 /********************************************************************************************
 * Method   : updateOLIwithlookups
 * Description: To map olis with related SPAs and PriceLists
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 19/Jan/2018  Srni       Created     
 ********************************************************************************************/
    public static void updateOLIwithlookups(List<OpportunityLineItem> OLIList){
    	//Variables
    	List<Price_List__c> relatedPLOLI=new List<Price_List__c>();
    	List<Sales_Plan_Actual__c> relatedSPAOLI=new List<Sales_Plan_Actual__c>();
        List <String> OLIplKey = new List<String>();
        List <String> OLIspKey = new List<String>();
            If(!OLIList.isEmpty()){
           		for(OpportunityLineItem oli:OLIList)
                {
                    OLIplKey.add(oli.PL_MatchingKey__c);
                    OLIplKey.add(oli.PL_NSP_Matching_Key__c);
                    OLIspKey.add(oli.SP_Matching_Key__c);
            		OLIspKey.add(oli.SP_Matching_Key_1__c);
            		OLIspKey.add(oli.SP_Matching_Key_2__c);
                }
         	}
        
        if(!OLIspKey.isEmpty()){
            relatedSPAOLI = [Select Id,Units__c,UniqueKey__c,Product__c,Product_ID__c from Sales_Plan_Actual__c where UniqueKey__c in :OLIspKey]; 
          	}
            Map<String, Sales_Plan_Actual__c> matchingKeyWithSPAOLI = new Map<String, Sales_Plan_Actual__c>();
        if(!OLIplKey.isEmpty()){
           relatedPLOLI = [Select Id,UniqueKey__c from Price_List__c where UniqueKey__c in :OLIplKey]; 
        }
       	Map<String, Price_List__c> matchingKeyWithPLOLI = new Map<String, Price_List__c>();
        
       if(!relatedSPAOLI.isEmpty()){
            for(Sales_Plan_Actual__c spkey : relatedSPAOLI ){  
               matchingKeyWithSPAOLI.put(spkey.UniqueKey__c,spkey);             
            } 
           for(OpportunityLineItem olis : OLIList ){ 
               if((matchingKeyWithSPAOLI.get(olis.SP_Matching_Key__c) != null)){
                   olis.SalesPlanActual__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key__c).id;
                }
                    
                if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_1__c) != null){
                    olis.Sales_Plan_Actual_1__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_1__c).id; 
                }   
                if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_2__c) != null){
                    olis.Sales_Plan_Actual_2__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_2__c).id;    
                }
                    
             } 
 		}
       if(!relatedPLOLI.isEmpty()){
            for(Price_List__c plkey : relatedPLOLI ){  
               matchingKeyWithPLOLI.put(plkey.UniqueKey__c,plkey);             
            }                             
            for(OpportunityLineItem olis : OLIList ){ 
                if((matchingKeyWithPLOLI.get(olis.PL_MatchingKey__c) != null)){
                  olis.PriceList_Lookup__c = matchingKeyWithPLOLI.get(olis.PL_MatchingKey__c).id;
                }
                    
                if(matchingKeyWithPLOLI.get(olis.PL_NSP_Matching_Key__c) != null){
                    olis.Price_List_NSP__c = matchingKeyWithPLOLI.get(olis.PL_NSP_Matching_Key__c).id; 
                }   
           	} 
            }
    	}

 /********************************************************************************************
 * Method   : getProdids
 * Description: To get Unique Products from current Opportunity
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 20/Jan/2018  Srni       Created     
 ********************************************************************************************/
    public static Set<Id> getProdids(Id Oppid){
        Set<Id> existingprodids=new Set<Id>();
        AggregateResult[] existingolis=new List<AggregateResult>();
         //Query to get the Unique Product
        if(Oppid!=Null){
        existingolis=[select count(id),Product2Id from OpportunityLineItem where opportunityid=:Oppid group by Product2Id];
        }
         if(existingolis.size()!=0){
            // Adding Product ids in Set
			for (AggregateResult ar : existingolis)  {
                existingprodids.add((Id)ar.get('Product2Id'));
                }
          }

        return existingprodids;
    }
 /********************************************************************************************
 * Method   : createMapwithOLI
 * Description: To create Map with productid and OLI
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 20/Jan/2018  Srni       Created     
 ********************************************************************************************/
  public static Map<Id,OpportunityLineItem> createMapwithOLI(Id Oppid){
      Map<Id,OpportunityLineItem> existingprods=new Map<Id,OpportunityLineItem>();
      if(Oppid!=Null){
         for(OpportunityLineItem oli: [select Id,Rolled_up_CY_1_Forecast_Sales__c ,
                                       Rolled_Up_Ending_Inventory_CY_1__c ,
                                       Rtlr_CY_Alctd__c ,Rtlr_Plnd_CY_Q4_Ship__c ,
                                       Rolled_up_CY_Planned_Sales__c,Rolled_Up_CY_1_OTG_Sales_c__c,
                                       Rolled_Up_CY_2_OTG_Sales_c__c,RolledUpCYProjectedEndingInventory__c,
                                       RolledUpCY1InventoryOTG__c,RolledupCYOTGForecast__c,
                                       RolledupCYOTGForecastLitres__c,Product2Id 
                                       from OpportunityLineItem where opportunityid=:Oppid])
      	 {
          existingprods.put(oli.Product2Id,oli);
      	 } 
      }
      return existingprods;
  }

 /********************************************************************************************
 * Method   : getProdids
 * Description: To get Unique Products from current Opportunity which are from child prods
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 06/April/2018  Srni       Created     
 ********************************************************************************************/
    public static Set<Id> getProdids(Id Oppid,Set<Id> childprdids){
        Set<Id> existingprodids=new Set<Id>();
        AggregateResult[] existingolis=new List<AggregateResult>();
         //Query to get the Unique Product
        if(Oppid!=Null){
        existingolis=[select count(id),Product2Id from OpportunityLineItem where opportunityid=:Oppid and Product2Id in :childprdids group by Product2Id];
        }
         if(existingolis.size()!=0){
            // Adding Product ids in Set
			for (AggregateResult ar : existingolis)  {
                existingprodids.add((Id)ar.get('Product2Id'));
                }
          }

        return existingprodids;
    }
 /********************************************************************************************
 * Method   : createMapwithOLI
 * Description: To create Map with productid and OLI which are from child prods
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 06/April/2018  Srni       Created     
 ********************************************************************************************/
  public static Map<Id,OpportunityLineItem> createMapwithOLI(Id Oppid,Set<Id> childprdids){
      Map<Id,OpportunityLineItem> existingprods=new Map<Id,OpportunityLineItem>();
      if(Oppid!=Null){
         for(OpportunityLineItem oli: [select Id,Rolled_up_CY_1_Forecast_Sales__c ,
                                       Rolled_Up_Ending_Inventory_CY_1__c ,
                                       Rtlr_CY_Alctd__c ,Rtlr_Plnd_CY_Q4_Ship__c ,
                                       Rolled_up_CY_Planned_Sales__c,Rolled_Up_CY_1_OTG_Sales_c__c,
                                       Rolled_Up_CY_2_OTG_Sales_c__c,RolledUpCYProjectedEndingInventory__c,
                                       RolledUpCY1InventoryOTG__c,RolledupCYOTGForecast__c,
                                       RolledupCYOTGForecastLitres__c,Product2Id 
                                       from OpportunityLineItem where opportunityid=:Oppid and Product2Id in :childprdids])
      	 {
          existingprods.put(oli.Product2Id,oli);
      	 } 
      }
      return existingprods;
  }
}