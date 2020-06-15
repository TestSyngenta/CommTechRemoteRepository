/**************************************************************************************
* Apex Class Name  :     RollUpsUtilityClass
* Version            :     1.0
* Created Date       :     21/Jan/2018
* Function           :     Utility Class to use in Roll up Batch Classes 
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     21/Jan/2018                Created.
* Trevor                   03/Apr/2019                Updated re: splitting bulk vs totes
*************************************************************************************/
public class RollUpsUtilityClass {
    
    Id globalOppId;
    String currentYear;
    String previousYear;
    String P_previousYear;
    String recordType;
    String country;
    String commercialunit;
    Opportunity parntopp;
    String accid;
 /********************************************************************************************
 * Method   : Constructor
 * Description: To setup the data based on Opportunity
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 21/Jan/2018  Srni       Created     
 ********************************************************************************************/ 
    public RollUpsUtilityClass(Opportunity parentopp)
    {
        parntopp=parentopp;
        globalOppId = parentopp.id;
        country='CA';
        commercialunit=parentopp.CommercialUnit__c;
        currentYear = parentopp.Year__c;
        previousYear = String.Valueof(Integer.valueof(currentYear) -1);
        P_previousYear = String.Valueof(Integer.valueof(currentYear) -2);
        accid=parentopp.Account.Account_ID__c;
        if(parentopp.Product_Type__c == 'CP'){
            recordType = Label.CP_Sales;
        }
        else{
            recordType = Label.Seeds_Sales;
         }        
    }
 /********************************************************************************************
 * Method   : updateOLIwithrollup
 * Description: Update Existings OLIs with Roll-up values and return List and handle Exception
 *              in Calling class
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 21/Jan/2018  Srni       Created     
 ********************************************************************************************/
    public List<OpportunityLineItem> updateOLIwithrollup(List<Opportunity> opp,Set<Id> prodids){
      Map<Id,OpportunityLineItem> existingprods=new Map<Id,OpportunityLineItem>();
      List<OpportunityLineItem> oliListtoupdate=new List<OpportunityLineItem>();
      //Fetching Child Opportunity's Olis
         AggregateResult[] childolis=[select count(Id)tot,Product2Id,
                                              sum(Actual_QTY__c)aqsum,
                                              sum(AllocatedBaselineUnits__c)abusum,
                                              sum(Ending_Inventory_CY__c)eisum,
                                              sum(CY_Distributor_Plan_to_Roll_Up__c)cpssum,
                                              sum(CY_Baseline_Sell_In_Plan__c)cbsip,
                                              sum(CY_Current_Sell_In_Plan__c)ccsip,
                                              sum(CY_1_Forecast_Sales__c)cfssum,
                                              sum(Ending_Inventory_CY_1__c)eicsum,
                                              sum(FNS_CY_ALCTD__c)fcasum,
                                              sum(FNS_CY__c)fcsum,
                                              sum(OTGForecastLitresCY__c)ofclsum,
                                              sum(PreviousUpdatedUnits__c)puusum,
                                              sum(Q4_Planned_Ship_CY__c)qscsum,
                                              sum(Updated_OTG_Forecast_CY__c)uofsum,
                                              sum(Volume_Estimate_CY_1__c)vecsum,
                                              sum(Ending_Inventory_Projection_CY__c)eip,
                                              sum(OTG_Growth_PER__c)ogp,
                                              sum(CY_1_Planned_Sales__c)cps,
                                              sum(CY_1_Whole_Sale_OTG_Units__c)cwsou,
                                              sum(CY_1_Wholesale_Inventory_Units__c)cwiu,
                                              sum(plnd_CY_stock_odr__c)pcso,
                                              sum(MY_FY_Planned_Ship_Totes__c)fpst,
                                              sum(MY_Q4_Planned_Ship_Totes__c)qpst,
                                              sum(CY_Stock_Odr__c)cso,
                                              sum(Rolled_up_CY_Planned_Sales__c)rucyps, 
                                              sum(Rolled_up_CY_1_Forecast_Sales__c)rucfs, 
                                              sum(Rolled_Up_Ending_Inventory_CY_1__c)rueic, 
                                              sum(Rtlr_CY_Alctd__c)rucad,
                                              sum(Rtlr_Plnd_CY_Q4_Ship__c)rupcqs,
                                              sum(OTG_CY_2__c)otg2,sum(OTG_CY_1__c)otg1,
                                              sum(ProjectedEndingInventoryCY__c)peic,
                                              sum(CY_1_Inventory_OTG__c)cyio,
                                              sum(OTG_FRCST_CY__c)ofcy,
                                              sum(OTGForecastLitresCY__c)ofl,
                                              sum(Rolled_Up_CY_1_OTG_Sales_c__c)rucos,
                                              sum(Rolled_Up_CY_2_OTG_Sales_c__c)ruc2os,
                                              sum(RolledUpCY1InventoryOTG__c)rucyiotg,
                                              sum(CY_Order_Quantity__c)cycporder,
                                              sum(CY_Shipped_Quantity__c)cycpshipped,
                                              sum(RolledupCYOTGForecast__c)rucof
                                              from OpportunityLineItem where OpportunityId in :opp and Product2Id in :prodids group by Product2Id,product2.Product_ID__c];
          //Fetching Parent Opportunity Olis
          for(OpportunityLineItem oli: [select Id,Product2Id,Actual_QTY__c,AllocatedBaselineUnits__c, 
                                        Ending_Inventory_CY__c,Rolled_up_CY_1_Forecast_Sales__c,Rolled_Up_Ending_Inventory_CY_1__c, 
                                        Rtlr_CY_Alctd__c,FNS_CY__c,OTG_FRCST_CY__c,
                                        PreviousUpdatedUnits__c,Rtlr_Plnd_CY_Q4_Ship__c,Updated_OTG_Forecast_CY__c,
                                        Volume_Estimate_CY_1__c,Ending_Inventory_Projection_CY__c,OTG_Growth_PER__c,
                                        CY_1_Planned_Sales__c,CY_1_Whole_Sale_OTG_Units__c,CY_1_Wholesale_Inventory_Units__c,
                                        plnd_CY_stock_odr__c,CY_Stock_Odr__c,Rolled_up_CY_Planned_Sales__c,
                                        Rolled_Up_CY_1_OTG_Sales_c__c,RolledUpCYProjectedEndingInventory__c,
                                        RolledUpCY1InventoryOTG__c,RolledupCYOTGForecast__c,
                                        Rolled_Up_CY_2_OTG_Sales_c__c,FNS_CY_ALCTD__c,
                                        Rolled_Up_MY_FY_Planned_Ship_Bulk__c,Rolled_Up_MY_FY_Planned_Ship_Totes__c,
                                        Rolled_Up_MY_Q4_Planned_Ship_Totes__c, Rolled_Up_MY_Planned_FNS__c,
                                        Rolled_Up_CY_Order_Quantity__c, Rolled_Up_CY_Shipped_Quantity__c,
                                        CY_Baseline_Sell_In_Plan__c, CY_Current_Sell_In_Plan__c
                                        from OpportunityLineItem where opportunityid=:globalOppId])
         {
          existingprods.put(oli.Product2Id,oli);
         }
         if(childolis!=Null && childolis.size()!=0){
                for (AggregateResult ar : childolis)  {
                OpportunityLineItem opplnitm =existingprods.get((Id)ar.get('Product2Id'));
                opplnitm.Actual_QTY__c  =(Decimal)ar.get('aqsum');
                opplnitm.AllocatedBaselineUnits__c = (Decimal)ar.get('abusum');
                opplnitm.Ending_Inventory_CY__c = (Decimal)ar.get('eisum');
                opplnitm.PreviousUpdatedUnits__c = (Decimal)ar.get('puusum');
                opplnitm.Updated_OTG_Forecast_CY__c = (Decimal)ar.get('uofsum');
                opplnitm.Volume_Estimate_CY_1__c = (Decimal)ar.get('vecsum');
               // opplnitm.OTG_Growth_PER__c=((Decimal)ar.get('ogp')/(Decimal)ar.get('tot'));
                opplnitm.CY_1_Planned_Sales__c = (Decimal)ar.get('cps');
                opplnitm.CY_1_Whole_Sale_OTG_Units__c = (Decimal)ar.get('cwsou');
                opplnitm.CY_1_Wholesale_Inventory_Units__c = (Decimal)ar.get('cwiu');
                opplnitm.CY_Stock_Odr__c = (Decimal)ar.get('cso');
                    if((Decimal)ar.get('eip')!=Null){
                        opplnitm.RolledUpEndingInventoryProjection_CY__c=((Decimal)ar.get('eip')/(Decimal)ar.get('tot'));
                    }
                opplnitm.Rtlr_CY_Alctd__c = (Decimal)ar.get('fcasum');
                opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = (Decimal)ar.get('qscsum');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Bulk__c = (Decimal)ar.get('pcso');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Totes__c = (Decimal)ar.get('fpst');
                opplnitm.Rolled_Up_MY_Q4_Planned_Ship_Totes__c = (Decimal)ar.get('qpst');
                opplnitm.Rolled_up_CY_1_Forecast_Sales__c = (Decimal)ar.get('cfssum');
                opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = (Decimal)ar.get('eicsum');
                opplnitm.Rolled_up_CY_Planned_Sales__c = (Decimal)ar.get('fcsum');
                if((Decimal)ar.get('rucos') > 0){
                    opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('rucos');
                }
                else opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('otg1'); 
                opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=(Decimal)ar.get('otg2');
                opplnitm.RolledUpCYProjectedEndingInventory__c=(Decimal)ar.get('peic');
                opplnitm.RolledUpCY1InventoryOTG__c=(Decimal)ar.get('cyio');
                opplnitm.RolledupCYOTGForecast__c=(Decimal)ar.get('ofcy');
                /*opplnitm.RolledupCYOTGForecastLitres__c=(Decimal)ar.get('ofl');*/
                opplnitm.Rolled_Up_MY_Planned_FNS__c = (Decimal)ar.get('fcsum');
                opplnitm.Rolled_Up_CY_Order_Quantity__c = (Decimal)ar.get('cycporder');
                opplnitm.Rolled_Up_CY_Shipped_Quantity__c = (Decimal)ar.get('cycpshipped');                
                if(parntopp.RecordType.Developername==Label.CP_CU_Sales_Plan_Record_Type_Name || parntopp.RecordType.developername == Label.Seeds_CU_Sales_Plan_Record_Type_Name)
                {
                   opplnitm.Rolled_up_CY_1_Forecast_Sales__c = (Decimal)ar.get('rucfs');
                   opplnitm.CY_1_Forecast_Sales__c=(Decimal)ar.get('cfssum');
                   opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=(Decimal)ar.get('ruc2os'); 
                   opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('rucos');
                   opplnitm.Rolled_up_CY_Planned_Sales__c = (Decimal)ar.get('rucyps');
                   opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = (Decimal)ar.get('rueic');
                   opplnitm.Ending_Inventory_CY_1__c=(Decimal)ar.get('eicsum');
                   opplnitm.CY_Planned_Sales1__c=(Decimal)ar.get('cpssum');
                   opplnitm.CY_Current_Sell_In_Plan__c = (Decimal)ar.get('ccsip');
                   opplnitm.CY_Baseline_Sell_In_Plan__c = (Decimal)ar.get('cbsip');
                   opplnitm.Rtlr_CY_Alctd__c = (Decimal)ar.get('rucad');
                   opplnitm.FNS_CY_ALCTD__c= (Decimal)ar.get('fcasum');
                   opplnitm.OTG_FRCST_CY__c = (Decimal)ar.get('rucof');
                }
                if(parntopp.RecordType.Developername==Label.District_Sales_Plan || parntopp.RecordType.developername == Label.District_Seeds_Sales_Plan)
                {
                   opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = (Decimal)ar.get('rupcqs');
                   opplnitm.RolledUpCY1InventoryOTG__c=(Decimal)ar.get('rucyiotg');
                }
                oliListtoupdate.add(opplnitm);
                // Ticket TKT-068916 IST Start: By Sravani
                existingprods.remove((Id)ar.get('Product2Id'));
                // Stop TKT-068916
                }
               }
            // Ticket TKT-068916 IST Start: By Sravani
            if(parntopp.RecordType.Developername==Label.Territory_Sales_Plan || parntopp.RecordType.developername == Label.Territory_Seeds_Sales_Plan)
            {
             if(existingprods!=Null && existingprods.size()!=0)
             {
                for(OpportunityLineItem opplnitm: existingprods.values())
                {
                        opplnitm.Actual_QTY__c  =0;
                        opplnitm.AllocatedBaselineUnits__c = 0;
                        opplnitm.Ending_Inventory_CY__c = 0;
                        opplnitm.PreviousUpdatedUnits__c = 0;
                        opplnitm.Updated_OTG_Forecast_CY__c = 0;
                        opplnitm.Volume_Estimate_CY_1__c = 0;
                        opplnitm.CY_1_Planned_Sales__c = 0;
                        opplnitm.CY_1_Whole_Sale_OTG_Units__c = 0;
                        opplnitm.CY_1_Wholesale_Inventory_Units__c = 0;
                        opplnitm.plnd_CY_stock_odr__c = 0;
                        opplnitm.CY_Stock_Odr__c = 0;
                        opplnitm.RolledUpEndingInventoryProjection_CY__c=0;
                        opplnitm.Rtlr_CY_Alctd__c = 0;
                        opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = 0;
                        opplnitm.Rolled_Up_MY_FY_Planned_Ship_Bulk__c = 0;
                        opplnitm.Rolled_Up_MY_FY_Planned_Ship_Totes__c = 0;
                        opplnitm.Rolled_Up_MY_Q4_Planned_Ship_Totes__c = 0;
                        opplnitm.Rolled_up_CY_1_Forecast_Sales__c = 0;
                        opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = 0;
                        opplnitm.Rolled_up_CY_Planned_Sales__c = 0;
                        opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=0;
                        opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=0;
                        opplnitm.RolledUpCYProjectedEndingInventory__c=0;
                        opplnitm.RolledUpCY1InventoryOTG__c=0;
                        opplnitm.RolledupCYOTGForecast__c=0;
                        opplnitm.Rolled_Up_MY_Planned_FNS__c=0;
                        opplnitm.Rolled_Up_CY_Order_Quantity__c=0;
                        opplnitm.Rolled_Up_CY_Shipped_Quantity__c=0;
                        /*opplnitm.RolledupCYOTGForecastLitres__c=0;*/
                        oliListtoupdate.add(opplnitm);
                    }
                }
             }
            // Stop TKT-068916
        return oliListtoupdate;
    }

 /********************************************************************************************
 * Method   : insertOLIwithrollup
 * Description: create Olis to insert and return and handle Exception in Calling class
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 21/Jan/2018  Srni       Created     
 ********************************************************************************************/
 public List<OpportunityLineItem> insertOLIwithrollup(List<Opportunity> opp,Set<Id> prodids,String category){
     List<OpportunityLineItem> oliListtoinsert=new List<OpportunityLineItem>();
     Map<Id,String> prodcodemap = new Map<Id,String>();
       // Query to get rollups from Child Opportunities
        AggregateResult[] groupedResults=[select count(Id)tot,Product2Id,
                                              sum(Actual_QTY__c)aqsum,
                                              sum(AllocatedBaselineUnits__c)abusum,
                                              sum(Ending_Inventory_CY__c)eisum,
                                              sum(CY_Distributor_Plan_to_Roll_Up__c)cpssum,
                                              sum(CY_Baseline_Sell_In_Plan__c)cbsip,
                                              sum(CY_Current_Sell_In_Plan__c)ccsip,                                              
                                              sum(CY_1_Forecast_Sales__c)cfssum,
                                              sum(Ending_Inventory_CY_1__c)eicsum,
                                              sum(FNS_CY_ALCTD__c)fcasum,
                                              sum(FNS_CY__c)fcsum,
                                              sum(OTGForecastLitresCY__c)ofclsum,
                                              sum(PreviousUpdatedUnits__c)puusum,
                                              sum(Q4_Planned_Ship_CY__c)qscsum,
                                              sum(Updated_OTG_Forecast_CY__c)uofsum,
                                              sum(Volume_Estimate_CY_1__c)vecsum,
                                              sum(Ending_Inventory_Projection_CY__c)eip,
                                              sum(OTG_Growth_PER__c)ogp,
                                              sum(CY_1_Planned_Sales__c)cps,
                                              sum(CY_1_Whole_Sale_OTG_Units__c)cwsou,
                                              sum(CY_1_Wholesale_Inventory_Units__c)cwiu,
                                              sum(plnd_CY_stock_odr__c)pcso,
                                              sum(MY_FY_Planned_Ship_Totes__c)fpst,
                                              sum(MY_Q4_Planned_Ship_Totes__c)qpst,
                                              sum(CY_Stock_Odr__c)cso,
                                              sum(Rolled_up_CY_Planned_Sales__c)rucyps, 
                                              sum(Rolled_up_CY_1_Forecast_Sales__c)rucfs, 
                                              sum(Rolled_Up_Ending_Inventory_CY_1__c)rueic, 
                                              sum(Rtlr_CY_Alctd__c)rucad,
                                              sum(Rtlr_Plnd_CY_Q4_Ship__c)rupcqs,
                                              sum(OTG_CY_2__c)otg2,sum(OTG_CY_1__c)otg1,
                                              sum(ProjectedEndingInventoryCY__c)peic,
                                              sum(CY_1_Inventory_OTG__c)cyio,
                                              sum(OTG_FRCST_CY__c)ofcy,
                                              sum(OTGForecastLitresCY__c)ofl,
                                              sum(Rolled_Up_CY_1_OTG_Sales_c__c)rucos,
                                              sum(Rolled_Up_CY_2_OTG_Sales_c__c)ruc2os,
                                              sum(RolledUpCY1InventoryOTG__c)rucyiotg,
                                              sum(CY_Order_Quantity__c)cycporder,
                                              sum(CY_Shipped_Quantity__c)cycpshipped,
                                              sum(RolledupCYOTGForecast__c)rucof
                                              from OpportunityLineItem where OpportunityId in :opp and Product2Id NOT in :prodids group by Product2Id];
            List<OpportunityLineItem> opplineitem=[select Product2Id,product2.Product_ID__c
                                              from OpportunityLineItem where OpportunityId in :opp and Product2Id NOT in :prodids];
            if(opplineitem!=Null)
            {
                for(OpportunityLineItem Oppline : opplineitem)
                {
                    prodcodemap.put(Oppline.Product2Id, Oppline.product2.Product_ID__c);
                }
            }
            if(groupedResults!=Null && groupedResults.size()!=0){
                for (AggregateResult ar : groupedResults)  {
                OpportunityLineItem opplnitm = new OpportunityLineItem();
                opplnitm.Product2Id     =(Id)ar.get('Product2Id');
                opplnitm.Actual_QTY__c  =(Decimal)ar.get('aqsum');
                opplnitm.AllocatedBaselineUnits__c = (Decimal)ar.get('abusum');
                opplnitm.Ending_Inventory_CY__c = (Decimal)ar.get('eisum');
                opplnitm.PreviousUpdatedUnits__c = (Decimal)ar.get('puusum');
                opplnitm.Updated_OTG_Forecast_CY__c = (Decimal)ar.get('uofsum');
                opplnitm.Volume_Estimate_CY_1__c = (Decimal)ar.get('vecsum');
                    if((Decimal)ar.get('eip')!=Null){
                        opplnitm.RolledUpEndingInventoryProjection_CY__c=((Decimal)ar.get('eip')/(Decimal)ar.get('tot'));
                    }
                    if((Decimal)ar.get('ogp')!=Null){
                        opplnitm.OTG_Growth_PER__c=((Decimal)ar.get('ogp')/(Decimal)ar.get('tot'));
                    }
                opplnitm.CY_1_Planned_Sales__c = (Decimal)ar.get('cps');
                opplnitm.CY_1_Whole_Sale_OTG_Units__c = (Decimal)ar.get('cwsou');
                opplnitm.CY_1_Wholesale_Inventory_Units__c = (Decimal)ar.get('cwiu');
                opplnitm.CY_Stock_Odr__c = (Decimal)ar.get('cso');
                opplnitm.CY_1_Forecast_Sales__c=(Decimal)ar.get('cfssum');
                if((Decimal)ar.get('rucos') > 0){
                    opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('rucos');
                }
                else opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('otg1'); 
                opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=(Decimal)ar.get('otg2');
                opplnitm.RolledUpCYProjectedEndingInventory__c=(Decimal)ar.get('peic');
                opplnitm.RolledUpCY1InventoryOTG__c=(Decimal)ar.get('cyio');
                opplnitm.RolledupCYOTGForecast__c=(Decimal)ar.get('ofcy');
                /*opplnitm.RolledupCYOTGForecastLitres__c=(Decimal)ar.get('ofl');*/
                opplnitm.Rolled_up_CY_Planned_Sales__c = (Decimal)ar.get('fcsum');
                opplnitm.Rolled_up_CY_1_Forecast_Sales__c = (Decimal)ar.get('cfssum');
                opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = (Decimal)ar.get('eicsum');
                opplnitm.Rtlr_CY_Alctd__c = (Decimal)ar.get('fcasum');
                opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = (Decimal)ar.get('qscsum');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Bulk__c = (Decimal)ar.get('pcso');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Totes__c = (Decimal)ar.get('fpst');
                opplnitm.Rolled_Up_MY_Q4_Planned_Ship_Totes__c = (Decimal)ar.get('qpst');
                opplnitm.Rolled_Up_MY_Planned_FNS__c = (Decimal)ar.get('fcsum');                
                opplnitm.Rolled_Up_CY_Order_Quantity__c = (Decimal)ar.get('cycporder');
                opplnitm.Rolled_Up_CY_Shipped_Quantity__c = (Decimal)ar.get('cycpshipped');     
                if(parntopp.RecordType.Developername==Label.CP_CU_Sales_Plan_Record_Type_Name || parntopp.RecordType.developername == Label.Seeds_CU_Sales_Plan_Record_Type_Name)
                {
                   opplnitm.Rolled_up_CY_1_Forecast_Sales__c = (Decimal)ar.get('rucfs');
                   opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=(Decimal)ar.get('ruc2os'); 
                   opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('rucos');
                   opplnitm.Rolled_up_CY_Planned_Sales__c = (Decimal)ar.get('rucyps');
                   opplnitm.CY_Current_Sell_In_Plan__c = (Decimal)ar.get('ccsip');
                   opplnitm.CY_Baseline_Sell_In_Plan__c = (Decimal)ar.get('cbsip');
                   opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = (Decimal)ar.get('rueic');
                   opplnitm.Ending_Inventory_CY_1__c=(Decimal)ar.get('eicsum');
                   opplnitm.CY_Planned_Sales1__c=(Decimal)ar.get('cpssum');
                   opplnitm.OTG_FRCST_CY__c = (Decimal)ar.get('rucof');
                }
                if(parntopp.RecordType.Developername==Label.District_Sales_Plan || parntopp.RecordType.developername == Label.District_Seeds_Sales_Plan)
                {
                   opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = (Decimal)ar.get('rupcqs');
                   opplnitm.RolledUpCY1InventoryOTG__c=(Decimal)ar.get('rucyiotg');
                }
                opplnitm.opportunityid=globalOppId;
                opplnitm.SP_Matching_Key__c=accid+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+currentYear+'|'+category+'|'+recordType;
                opplnitm.SP_Matching_Key_1__c=accid+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+previousYear+'|'+category+'|'+recordType;
                opplnitm.SP_Matching_Key_2__c=accid+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+P_previousYear+'|'+category+'|'+recordType;
                opplnitm.PL_MatchingKey__c=country+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+'SDP'+'|'+commercialunit+'|'+currentYear;
                opplnitm.PL_NSP_Matching_Key__c=country+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+'Net Sales'+'|'+commercialunit+'|'+currentYear;
                oliListtoInsert.add(opplnitm);       
                }
               }
     return oliListtoInsert;
    }
 /********************************************************************************************
 * Method   : insertOLIlist
 * Description: create olis to insert on parent(Distributor/HeadOfficeRetailer) and handle Exception
 *              in Calling class
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 21/Jan/2018  Srni       Created     
 ********************************************************************************************/
    public List<OpportunityLineItem> insertOLIlist(List<Opportunity> opplist,Set<Id> prodids,String category)
    {
           List<OpportunityLineItem> oliListtoInsert=new List<OpportunityLineItem>();
           Map<Id,String> prodcodemap = new Map<Id,String>();
        // Query to get rollups from Child Opportunities
           AggregateResult[] groupedResults=[select Product2Id,product2.Product_ID__c,count(Id)tot,sum(FNS_CY__c)cpssum,
                                              sum(CY_1_Forecast_Sales__c)cfssum,
                                              sum(Ending_Inventory_CY_1__c)eicsum,
                                              sum(FNS_CY_ALCTD__c)fcasum,
                                              sum(Q4_Planned_Ship_CY__c)qscsum,
                                              sum(OTG_CY_2__c)otg2,
                                              sum(OTG_CY_1__c)otg1,
                                              sum(Rolled_Up_CY_1_OTG_Sales_c__c)rucos,
                                              sum(ProjectedEndingInventoryCY__c)peic,
                                              sum(CY_1_Inventory_OTG__c)cyio,
                                              sum(OTG_FRCST_CY__c)ofcy,
                                              sum(OTGForecastLitresCY__c)ofl,
                                              sum(plnd_CY_stock_odr__c)pcso,
                                              sum(MY_FY_Planned_Ship_Totes__c)fpst,
                                              sum(MY_Q4_Planned_Ship_Totes__c)qpst
                                              from OpportunityLineItem where OpportunityId in :oppList and Product2Id NOT in :prodids group by Product2Id,product2.Product_ID__c];
          List<OpportunityLineItem> opplineitem=[select Product2Id,product2.Product_ID__c
                                              from OpportunityLineItem where OpportunityId in :oppList and Product2Id NOT in :prodids];
            if(opplineitem!=Null)
            {
                for(OpportunityLineItem Oppline : opplineitem)
                {
                    prodcodemap.put(Oppline.Product2Id, Oppline.product2.Product_ID__c);
                }
            }
            
            if(groupedResults!=Null && groupedResults.size()!=0){
                for(AggregateResult ar : groupedResults)  {
                OpportunityLineItem opplnitm = new OpportunityLineItem(); 
                opplnitm.Product2Id     =(Id)ar.get('Product2Id');
                opplnitm.Rolled_up_CY_1_Forecast_Sales__c = (Decimal)ar.get('cfssum');
                opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = (Decimal)ar.get('eicsum');
                opplnitm.Rtlr_CY_Alctd__c = (Decimal)ar.get('fcasum');
                opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = (Decimal)ar.get('qscsum');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Bulk__c = (Decimal)ar.get('pcso');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Totes__c = (Decimal)ar.get('fpst');
                opplnitm.Rolled_Up_MY_Q4_Planned_Ship_Totes__c = (Decimal)ar.get('qpst');
                opplnitm.Rolled_up_CY_Planned_Sales__c = (Decimal)ar.get('cpssum');
                if((Decimal)ar.get('rucos') > 0){
                    opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('rucos');
                }
                else opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('otg1'); 
                opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=(Decimal)ar.get('otg2');
                opplnitm.RolledUpCYProjectedEndingInventory__c=(Decimal)ar.get('peic');
                opplnitm.RolledUpCY1InventoryOTG__c=(Decimal)ar.get('cyio');
                opplnitm.RolledupCYOTGForecast__c=(Decimal)ar.get('ofcy');
                /*opplnitm.RolledupCYOTGForecastLitres__c=(Decimal)ar.get('ofl');*/
                opplnitm.opportunityid=globalOppId;
                opplnitm.SP_Matching_Key__c=accid+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+currentYear+'|'+Category+'|'+recordType;
                opplnitm.SP_Matching_Key_1__c=accid+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+previousYear+'|'+Category+'|'+recordType;
                opplnitm.SP_Matching_Key_2__c=accid+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+P_previousYear+'|'+Category+'|'+recordType;
                opplnitm.PL_MatchingKey__c=country+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+'SDP'+'|'+commercialunit+'|'+currentYear;
                opplnitm.PL_NSP_Matching_Key__c=country+'|'+prodcodemap.get((Id)ar.get('Product2Id'))+'|'+'Net Sales'+'|'+commercialunit+'|'+currentYear;
                oliListtoInsert.add(opplnitm);       
                }
              }
            return oliListtoInsert;
              }
 /********************************************************************************************
 * Method   : updateOLIlist
 * Description: Update Existings OLIs with Roll-up values and return List(Distributor/HeadOfficeRetailer)
 *              and handle Exception in Calling class
 * ------------------------------------------------------------------------------------------
 * Date          Name                    Modification Description
 * ------------------------------------------------------------------------------------------
 * 21/Jan/2018  Srni       Created     
 ********************************************************************************************/
    public List<OpportunityLineItem> updateOLIlist(List<Opportunity> opplist,Set<Id> prodids)
    {
        List<OpportunityLineItem> oliListtoupdate=new List<OpportunityLineItem>();
        AggregateResult[] groupedResults=[select count(Id)tot,Product2Id,
                                              sum(FNS_CY__c)fcsum,
                                              sum(CY_1_Forecast_Sales__c)cfssum,
                                              sum(Ending_Inventory_CY_1__c)eicsum,
                                              sum(FNS_CY_ALCTD__c)fcasum,
                                              sum(Q4_Planned_Ship_CY__c)qscsum,
                                              sum(OTG_CY_2__c)otg2,
                                              sum(OTG_CY_1__c)otg1,
                                              sum(ProjectedEndingInventoryCY__c)peic,
                                              sum(CY_1_Inventory_OTG__c)cyio,
                                              sum(OTG_FRCST_CY__c)ofcy,
                                              sum(OTGForecastLitresCY__c)ofl,
                                              sum(plnd_CY_stock_odr__c)pcso,
                                              sum(MY_FY_Planned_Ship_Totes__c)fpst,
                                              sum(MY_Q4_Planned_Ship_Totes__c)qpst
                                              from OpportunityLineItem where OpportunityId in :oppList and Product2Id in :prodids group by Product2Id];
        Map<Id,OpportunityLineItem> mapwitholi=OLILookupsutility.createMapwithOLI(globalOppId);
        
            if(groupedResults!=Null && groupedResults.size()!=0){
                for (AggregateResult ar : groupedResults)  {
                OpportunityLineItem opplnitm =mapwitholi.get((Id)ar.get('Product2Id'));
                opplnitm.Rolled_up_CY_1_Forecast_Sales__c = (Decimal)ar.get('cfssum');
                opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = (Decimal)ar.get('eicsum');
                opplnitm.Rtlr_CY_Alctd__c = (Decimal)ar.get('fcasum');
                opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = (Decimal)ar.get('qscsum');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Bulk__c = (Decimal)ar.get('pcso');
                opplnitm.Rolled_Up_MY_FY_Planned_Ship_Totes__c = (Decimal)ar.get('fpst');
                opplnitm.Rolled_Up_MY_Q4_Planned_Ship_Totes__c = (Decimal)ar.get('qpst');
                opplnitm.Rolled_Up_MY_Planned_FNS__c = (Decimal)ar.get('fcsum');
                opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=(Decimal)ar.get('otg1');
                opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=(Decimal)ar.get('otg2');
                opplnitm.RolledUpCYProjectedEndingInventory__c=(Decimal)ar.get('peic');
                opplnitm.RolledUpCY1InventoryOTG__c=(Decimal)ar.get('cyio');
                opplnitm.RolledupCYOTGForecast__c=(Decimal)ar.get('ofcy');
                /*opplnitm.RolledupCYOTGForecastLitres__c=(Decimal)ar.get('ofl');*/
                oliListtoUpdate.add(opplnitm);
                // Ticket TKT-068916 IST Start: By Sravani
                mapwitholi.remove((Id)ar.get('Product2Id'));
                // Stop TKT-068916
            }
       }
        // Ticket TKT-068916 IST Start: By Sravani
            if(parntopp.RecordType.Developername==Label.CP_Distributor_Sales_Plan || parntopp.RecordType.developername == Label.Seeds_Distributor_Sales_Plan)
            {
             if(mapwitholi!=Null && mapwitholi.size()!=0)
             {
                for(OpportunityLineItem opplnitm: mapwitholi.values())
                {
                        opplnitm.Rolled_up_CY_1_Forecast_Sales__c = 0;
                        opplnitm.Rolled_Up_Ending_Inventory_CY_1__c = 0;
                        opplnitm.Rtlr_CY_Alctd__c = 0;
                        opplnitm.Rtlr_Plnd_CY_Q4_Ship__c = 0;
                        opplnitm.Rolled_Up_MY_FY_Planned_Ship_Bulk__c = 0;
                        opplnitm.Rolled_Up_MY_FY_Planned_Ship_Totes__c = 0;
                        opplnitm.Rolled_Up_MY_Q4_Planned_Ship_Totes__c = 0;
                        opplnitm.Rolled_up_CY_Planned_Sales__c = 0;
                        opplnitm.Rolled_up_MY_Planned_FNS__c = 0;                        
                        opplnitm.Rolled_Up_CY_1_OTG_Sales_c__c=0;
                        opplnitm.Rolled_Up_CY_2_OTG_Sales_c__c=0;
                        opplnitm.RolledUpCYProjectedEndingInventory__c=0;
                        opplnitm.RolledUpCY1InventoryOTG__c=0;
                        opplnitm.RolledupCYOTGForecast__c=0;
                        /*opplnitm.RolledupCYOTGForecastLitres__c=0;*/
                        oliListtoupdate.add(opplnitm);
                    }
                }
             }
            // Stop TKT-068916
        return oliListtoupdate;
    }
}