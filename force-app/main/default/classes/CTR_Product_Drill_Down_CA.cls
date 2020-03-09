/***********************************************************************************************
* Class:      CTR_Product_Drill_Down_CA
* Description:  Controller for VF page Vf_Product_Drill_Down_CA
* ----------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ----------------------------------------------------------------------------------------------     
* 20-Feb-2018    Sravani                Created  US-278514
************************************************************************************************/
public class CTR_Product_Drill_Down_CA 
{
   public static string oliId;
   public static string recordtype {get;set;}
   public static string accountname {get;set;}
   public static string oppname {get;set;}
   public static string terrname {get;set;}
   public static string communit {get;set;}
   public static OpportunityLineItem Header{get;set;}
   public static List<OpportunityLineItem> childoliList{get;set;}
   public static string ParentOppId {get;set;}
   public Exception_Log__c exceptionlog;
       
    //Controller 
    public CTR_Product_Drill_Down_CA (ApexPages.StandardController Controller)
    {
        try{
        //Initialize wrapper Lists
        OliId =  ApexPages.currentPage().getParameters().get('oliId');
        if(OliId != null && OliId != ''){
        OpportunityLineItem opp = [select Id,opportunity.name,opportunity.CommercialUnit__c,opportunityid,opportunity.Account.name,opportunity.Territory__r.name,opportunity.recordtype.developername from OpportunityLineItem where Id = :OliId];
        accountname = opp.opportunity.Account.name;
        oppname=opp.opportunity.name;
        terrname=opp.opportunity.Territory__r.name;
        communit=opp.opportunity.CommercialUnit__c;
        recordtype=opp.opportunity.recordtype.developername;
        ParentOppId=opp.opportunityid;
        loadSpaList();
        }
        }
        catch(Exception e)
        {
            exceptionlog=ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','CTR_Product_Drill_Down_CA','Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            if(exceptionlog!=null)
            {
                insert exceptionlog;
            }
        }
     }
/********************************************************************************************
* Method        loadSpaList
* Description:  
* ------------------------------------------------------------------------------------------
* Date          Name               Modification Description
* ------------------------------------------------------------------------------------------*
20-Feb-2018    Sravani              Used to Load Wrapper List which is displayed in Drill Down
********************************************************************************************/
   public void loadSpaList()
   {
       OpportunityLineItem oli;
       try
       {
       if(OliId!=Null){
       oli = [select id,product2.name,product2id,OTG_CY_1__c,Rolled_Up_Ending_Inventory_CY_1__c,
                                 RolledUpEndingInventoryProjection_CY__c,RolledUpCYProjectedEndingInventory__c,
                                 RolledUpCY1InventoryOTG__c,OTG_CY__c,FNS_CY_2__c,FNS_CY_1__c,
                                 Rolled_up_CY_Planned_Sales__c,Rolled_up_CY_1_Forecast_Sales__c,
                                 Rtlr_Plnd_CY_Q4_Ship__c,FNS_CY_Actual__c,Rolled_Up_CY_2_OTG_Sales_c__c,
                                 Rolled_Up_CY_1_OTG_Sales_c__c,OTG_Growth_PER__c,RolledupCYOTGForecast__c,Rtlr_CY_Alctd__c,
                                 CY_1_Whole_Sale_OTG_Units__c,CY_1_OTG_Units__c,CY_1_Wholesale_Inventory_Units__c,
                                 Updated_OTG_Forecast_CY__c,CY_Planned_Sales1__c,CY_1_Planned_Sales__c,OTG_FRCST_CY__c,FNS_CY__c,
                                 CY_Stock_Odr__c,FNS_CY_ALCTD__c,CY_1_Forecast_Sales__c,plnd_CY_stock_odr__c,
                                 Ending_Inventory_CY_1__c,Rolled_Up_MY_FY_Planned_Ship_Bulk__c, Rolled_Up_MY_FY_Planned_Ship_Totes__c,
                                 Rolled_Up_MY_Q4_Planned_Ship_Totes__c, Rolled_Up_MY_Q1_Q2_Planned_Ship__c, Rolled_Up_MY_Q1_Q2_Planned_Ship_Totes__c,
                                 Rolled_Up_MY_Planned_FNS__c, Rolled_Up_CY_2_OTG_Units_Field_UOM__c, Rolled_Up_CY_1_OTG_Units_Field_UOM__c,
                                 Rolled_Up_CY_1_OTG_Value_SDP__c, Rolled_Up_CY_OTG_Forecast_Field_UOM__c, Rolled_Up_CY_OTG_Forecast_SDP_Field_UOM__c,
                                 Field_UOM__c, Min_Saleable_UOM__c
                                 from opportunityLineItem where id =:OliId];
       }
      if(oli!=null)
      {
      Header=oli;
      if(recordtype==Label.Territory_Sales_Plan || recordtype==Label.Territory_Seeds_Sales_Plan ||recordtype==Label.District_Sales_Plan ||recordtype==Label.District_Seeds_Sales_Plan)
      {
          List<OpportunityLineItem> childoli =[select id,opportunityid,product2.name,opportunity.Account.name,opportunity.Account.billingcity,opportunity.Account.billingstate,product2id,OTG_CY_1__c,Ending_Inventory_CY_1__c,
                                 Ending_Inventory_Projection_CY__c,ProjectedEndingInventoryCY__c,
                                 CY_1_Inventory_OTG__c,OTG_FRCST_CY__c,OTG_CY__c,FNS_CY_2__c,FNS_CY_1__c,
                                 FNS_CY__c,CY_1_Forecast_Sales__c,Q4_Planned_Ship_CY__c,FNS_CY_Actual__c,
                                 Rtlr_Plnd_CY_Q4_Ship__c,RolledUpCY1InventoryOTG__c
                                 from opportunityLineItem where Opportunity.RelatedTerritoryPlan__c =:ParentOppId and product2id=:oli.Product2Id order by opportunity.Account.name];
          if(childoli!=null)
          {
              childoliList=childoli;
          }
      }
       
      if(recordtype==Label.CP_Distributor_Sales_Plan || recordtype==Label.Seeds_Distributor_Sales_Plan)
      {
          List<OpportunityLineItem> childoli =[select id,opportunityid,product2.name,opportunity.Account.name,opportunity.Account.billingcity,opportunity.Account.billingstate,
                                               product2id,OTG_CY_1__c,OTG_CY_2__c,Ending_Inventory_CY_1__c,CY_1_Forecast_Sales__c,
                                               OTG_Growth_PER__c,OTG_FRCST_CY__c,FNS_CY__c,Q4_Planned_Ship_CY__c,FNS_CY_ALCTD__c, plnd_CY_stock_odr__c,
                                                MY_FY_Planned_Ship_Totes__c, MY_Q4_Planned_Ship_Totes__c,MY_Q1_Q2_Planned_Ship__c, MY_Q1_Q2_Planned_Ship_Totes__c,
                                                CY_2_OTG_Units_Field_UOM__c, CY_1_OTG_Units_Field_UOM__c, OTG_SDP_CY_1__c, OTG_CY_Forecast_SDP__c,
                                                CY_OTG_Forecast_Field_UOM__c,Rolled_Up_CY_1_OTG_Units_Field_UOM__c
                                 from opportunityLineItem where Opportunity.RelatedDistributorPlan__c =:ParentOppId and product2id=:oli.Product2Id order by opportunity.Account.name];
          if(childoli!=null)
          {
              childoliList=childoli;
          }
      }
       
      if(recordtype==Label.CP_CU_Sales_Plan_Record_Type_Name || recordtype==Label.Seeds_CU_Sales_Plan_Record_Type_Name)
      {
          List<OpportunityLineItem> childoli =[select id,opportunityid,product2.name,opportunity.Account.name,opportunity.Account.billingcity,
                                               opportunity.Account.billingstate,product2id,CY_1_Whole_Sale_OTG_Units__c,CY_1_OTG_Units__c,
                                               CY_1_Wholesale_Inventory_Units__c,Ending_Inventory_CY_1__c,OTG_Growth_PER__c,
                                               OTG_FRCST_CY__c,Updated_OTG_Forecast_CY__c,CY_Planned_Sales1__c,
                                               CY_1_Planned_Sales__c,ProjectedEndingInventoryCY__c,FNS_CY_2__c,FNS_CY_1__c,FNS_CY__c,
                                               FNS_CY_Actual__c,CY_Stock_Odr__c,plnd_CY_stock_odr__c,FNS_CY_ALCTD__c,CY_1_Forecast_Sales__c,Q4_Planned_Ship_CY__c,
                                               CY_Baseline_Sell_In_Plan__c, CY_Current_Sell_In_Plan__c,CY_Distributor_Plan_to_Roll_Up__c,
                                               Rolled_Up_CY_1_OTG_Units_Field_UOM__c
                                 from opportunityLineItem where Opportunity.RelatedCUPlan__c =:ParentOppId and product2id=:oli.Product2Id order by opportunity.Account.name];
          if(childoli!=null)
          {
              childoliList=childoli;
          }
        }
      if(recordtype==Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || recordtype==Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name)
      {
          List<OpportunityLineItem> childoli =[select id,opportunityid,product2.name,opportunity.Account.name,opportunity.Account.billingcity,opportunity.Account.billingstate,product2id,
                                 ProjectedEndingInventoryCY__c,OTG_CY_1__c,
                                 OTG_FRCST_CY__c,Ending_Inventory_CY_1__c,
                                 FNS_CY__c,CY_1_Forecast_Sales__c,Q4_Planned_Ship_CY__c,FNS_CY_ALCTD__c,
                                 plnd_CY_stock_odr__c, MY_FY_Planned_Ship_Totes__c, MY_Q4_Planned_Ship_Totes__c,
                                 MY_Q1_Q2_Planned_Ship__c, MY_Q1_Q2_Planned_Ship_Totes__c
                                 from opportunityLineItem where Opportunity.RelHeadOfficePlan__c =:ParentOppId and product2id=:oli.Product2Id order by opportunity.Account.name];
          if(childoli!=null)
          {
              childoliList=childoli;
          }
      }
       }
       }
       catch(Exception e)
       {
           exceptionlog=ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','CTR_Product_Drill_Down_CA','LoadSpaList','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            if(exceptionlog!=null)
            {
                insert exceptionlog;
            }
       }
   }
}