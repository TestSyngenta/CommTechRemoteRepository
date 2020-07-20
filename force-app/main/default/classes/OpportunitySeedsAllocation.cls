/**************************************************************************************
* Apex Class Name    :     OpportunitySeedsAllocation
* Version            :     1.0
* Created Date       :     25/Dec/2017
* Function           :     This is controller for VF_UploadSalesPlan
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* HLT                     25/12/2017                Created.
* Jyothsna                12/03/2018                Modified
* Vijay					  15/03/2018				Modified
*************************************************************************************/

public class OpportunitySeedsAllocation{
    Public Map<String,String> mapL2ToL1;
    Private Id priceBookId;
    Public Map<String,PriceBookEntry> mapVarietyProduct = new Map<String,PriceBookEntry>();
    Public Set<String> setVarietyNames = new Set<String>();
    Public Map<String,Map<String,PriceBookEntry>> districtAndVarPBEMap = new Map<String,Map<String,PriceBookEntry>>();
    Public Map<String,String> disVarMap = new Map<String,String>();
    
    /*******************************************************************************************
* Method   : mapRecordsToBeUpdatedInserted
* Description: Process the records and create opportuities and its line items
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 25-Dec-2017  HLT       Created     
********************************************************************************************/    
    public void mapRecordsToBeInserted(List<SeedsAllocation__c> listOfAllocations){
        
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Id OPP_RT = oppRecordtypes.get(label.CUSeedsAllocationRecordType); 
        Id Dist_RT = oppRecordtypes.get(label.DistrictSeedsAllocation); 
        //Id OPP_RT = '0124F000000079y';
        //Id Dist_RT = '0124F00000007IH';
        Map<String,Opportunity> mapDistOppId = new Map<String,Opportunity>();
        User u = [Select Id, User_Country__c from User where ID=:UserInfo.getUserId() LIMIT 1];
        Map<String,String> mapL2ToL1 = new Map<String,String>(); 
        System.debug('----listOfAllocations------'+ listOfAllocations) ;
        try{
            if(listOfAllocations!=null && listOfAllocations.size()>0){
                string year = listOfAllocations[0].year__c;
                string CU = listOfAllocations[0].CommercialUnit1__c;
                List<Opportunity> listOpptys = new List<Opportunity>();
                Territory__c CUid = [select id, name from territory__c where name =:CU limit 1];
                listOpptys = [Select Id,Territory__r.name,Account.Account_Id__c from Opportunity where Territory__r.name =:CU AND Year__c =:year  and Recordtype.developername = 'CU_Seeds_Allocation']; 
                if(listOpptys.isEmpty()){
                    Account_Territory__c dummyAccId = [Select Account__r.Id,Account__r.Account_Id__c from Account_Territory__c where Territory__r.name =: CU and account__r.recordtype.developerName =:label.Planning_Account LIMIT 1]; 
                    Opportunity Opp = new Opportunity();
                    Opp.AccountId = dummyAccId.Account__r.Id;
                    if(CU=='WCU'){
                        Opp.Name = year + ' ' + label.SeedsAllocation_WCU;
                    }
                    else if(CU=='ECU'){
                        Opp.Name = year + ' ' + label.SeedsAllocation_ECU;
                    }
                    else{
                        Opp.Name = year + ' ' + label.SeedsAllocation_Value + '-' + CU;
                    }
                    Opp.CloseDate = System.today() + 90;
                    Opp.OwnerId = u.Id;
                    Opp.StageName = label.Opportunity_Stage;
                    Opp.RecordTypeId = OPP_RT;
                    Opp.Territory__c = CUid.id;
                    Opp.year__c = year;
                    insert Opp;
                }
                
                if(listOfAllocations!=null && listOfAllocations.size()>0){
                    for(SeedsAllocation__c sa: listOfAllocations){
                        mapL2ToL1.put(sa.District__c,sa.CommercialUnit1__c);
                       	setVarietyNames.add(String.valueOf(sa.SeedsVariety__c));
                    }
                }
                
                List<Opportunity> oppsList = new List<Opportunity>();     
                oppsList = [ select id,AccountId,Account.Account_Id__c,year__c,Name,Territory__c from Opportunity where Territory__c in:mapL2ToL1.keySet() and year__c =: year and Recordtype.developername =: Label.Seeds_Allocation_Dist_RT];     
                Map<String,Opportunity> Dist = new Map<String,Opportunity>();
                if(!oppsList.isEmpty()){
                    for(Opportunity OL:oppsList){
                        Dist.put(OL.Territory__c,OL);
                    }
                }
                set<string> opp = mapL2ToL1.keyset();
                opp.removeall(Dist.keySet());
                List<Account_Territory__c> Acc = [ select id,Name,Account__c,Account__r.Account_Id__c,Territory__c,Territory__r.Name,Territory__r.Assigned_Rep__c from Account_Territory__c where Territory__c in:opp and account__r.recordtype.developerName =:label.Planning_Account]; 
                List<Opportunity>  Optylist =  new List<Opportunity>(); 
                for(Account_Territory__c Ac : Acc){
                    Opportunity newOpp = new Opportunity();
                    //newOpp.AccountId = Ac.id;
                    newOpp.AccountId = Ac.Account__c;
                   // newOpp.Name = year + ' ' + Ac.Territory__r.Name + ' Allocations';
                    newOpp.Name = year + ' ' + 'Seed Allocation' + '-' + Ac.Territory__r.Name;
                    newOpp.CloseDate = System.today() + 90;
                    //newOpp.OwnerId = Ac.Id;
                    newOpp.OwnerId = Ac.Territory__r.Assigned_Rep__c;
                    newOpp.StageName = label.Opportunity_Stage;
                    //newOpp.RecordTypeId = OPP_RT;
                    newOpp.RecordTypeId = Dist_RT;
                    newOpp.Territory__c = Ac.Territory__c;
                    //Added the below line.
                    newOpp.year__c = year;
                    Optylist.add(newOpp);
                }
                
                if(!Optylist.isEmpty()){
                    insert Optylist;
                    for(Opportunity ol:[Select ID,Name,AccountId,Account.Account_Id__c,Territory__c,RecordType.DeveloperName,RecordType.Name,StageName,OwnerId,CloseDate,Year__c From Opportunity Where ID IN: Optylist]){
                        mapDistOppId.put(ol.Territory__c,ol);
                    }
                }
                mapDistOppId.putAll(Dist);
                varietyPriceBookEntryMap();
                System.debug('::::mapVarietyProduct::::'+mapVarietyProduct);
                districtToVarietyProductMaping(listOfAllocations,mapVarietyProduct);
                districtVarietyMapping(listOfAllocations);
                oliCreation(mapDistOppId);
                
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','OpportunitySeedsAllocation','mapRecordsToBeInserted','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    /*******************************************************************************************
* Method   : updateOli
* Description: To update the OLI when allocations is updated on Seeds Allocation
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 29-Dec-2017   Ravikant                Created     
********************************************************************************************/
    public void updateOli(List<SeedsAllocation__c> saList){
        Map<String,Double> allocationWithMatchingKey = new Map<String,Double>();
        List<OpportunityLineItem> oliToBeUpdated = new List<OpportunityLineItem>();
        try{
            for(SeedsAllocation__c sa:saList){
                System.debug('UniqueKey__c::::'+sa.UniqueKey__c);
                allocationWithMatchingKey.put(sa.UniqueKey__c,sa.SeedAllocation__c);
            }
            for(OpportunityLineItem oli:[Select Id,AllocatedBaselineUnits__c,AllocationMatchingKey__c From OpportunityLineItem Where AllocationMatchingKey__c IN : allocationWithMatchingKey.keySet()]){
                if(allocationWithMatchingKey.get(oli.AllocationMatchingKey__c) != null){
                    oli.AllocatedBaselineUnits__c = allocationWithMatchingKey.get(oli.AllocationMatchingKey__c);
                    oliToBeUpdated.add(oli);
                }
            }
            update oliToBeUpdated;
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportunityLineItem','NA','OpportunitySeedsAllocation','updateOli','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    /********************************************************************************************
* Method   : varietyPriceBookEntryMap
* Description: To populate the map of "Seeds Variety" and "PriceBookEntry"
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 28-Dec-2017   Ravikant                Created     
*********************************************************************************************/
    public void varietyPriceBookEntryMap(){
        SeedsAllocationValidation sa = new SeedsAllocationValidation();
        try{
            priceBookId = sa.getPriceBookId();
            for(PriceBookEntry pbe:[SELECT Id,Product2.Id,Product2.Name,Product2.Species__c,Product2.StockKeepingUnit,Product2.variety__c,Product2.Product_ID__c,unitprice FROM PriceBookEntry WHERE PriceBook2Id=: priceBookId AND IsActive = true AND Product2.Variety__c IN : setVarietyNames AND Product2.IsActive = True AND Product2.AvailableforPlanning__c = True AND (Product2.Product_ID__c != null OR Product2.Product_ID__c != '') AND Product2.RecordType.DeveloperName =: Label.SeedsProductsRecordType]){
                if(mapVarietyProduct.get(String.valueOf(pbe.Product2.variety__c))== null){
                    mapVarietyProduct.put(String.valueOf(pbe.Product2.variety__c),pbe);
                }
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('PriceBookEntry','NA','OpportunitySeedsAllocation','varietyPriceBookEntryMap','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    /********************************************************************************************
* Method   : districtToVarietyProductMaping
* Description: To map the "District" with the "Seeds Variety" and "PriceBookEntry" 
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 28-Dec-2017   Ravikant                Created     
*********************************************************************************************/
    public void districtToVarietyProductMaping(List<SeedsAllocation__c> saList,map<String,PriceBookEntry> varietyProduct){
        try{
            Map<String,List<String>> districtVarietyList = new Map<String,List<String>>();
            for(SeedsAllocation__c sa:saList){
                List<String> seedsVarietiesForDistrict = new List<String>();
                if(districtVarietyList.get(sa.District__c)!=null){
                    seedsVarietiesForDistrict.addAll(districtVarietyList.get(sa.District__c));
                }
               	seedsVarietiesForDistrict.add(String.valueOf(sa.SeedsVariety__c));
                if(!seedsVarietiesForDistrict.isEmpty()){
                    districtVarietyList.put(sa.District__c, seedsVarietiesForDistrict);
                }   
            }
            
            for(String dist:districtVarietyList.keySet()){
                Map<String,PriceBookEntry> varPBEList = new Map<String,PriceBookEntry>();
                for(String var:districtVarietyList.get(dist)){
                    if(varietyProduct.get(var) != null){
                        varPBEList.put(var,varietyProduct.get(var));
                    }
                }
                districtAndVarPBEMap.put(dist,varPBEList);
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('SeedsAllocation__c','NA','OpportunitySeedsAllocation','districtToVarietyProductMaping','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }  
    }
    
    /********************************************************************************************
* Method   : districtVarietyMapping
* Description: To map the "Allocation" for every "District" and "Seeds Variety" combination
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 28-Dec-2017   Ravikant                Created     
*********************************************************************************************/
    public void districtVarietyMapping(List<SeedsAllocation__c> saList){
        try{
            for(SeedsAllocation__c s:saList){
             	disVarMap.put(s.District__c+s.SeedsVariety__c,String.valueOf(s.SeedAllocation__c));
                System.debug('disVarMap::::'+disVarMap);
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('SeedsAllocation__c','NA','OpportunitySeedsAllocation','districtVarietyMapping','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    /********************************************************************************************
* Method   : oliCreation
* Description: Creation of OLI for the Seeds Allocation Sales Plan
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 02-Jan-2018   Ravikant                Created     
*********************************************************************************************/
    Public void oliCreation(Map<String,Opportunity> distOppIdMap){
        List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        String Category = label.SeedsAllocation_Category;
        String Record_type = label.Seeds_Sales;
        System.debug(':::districtAndVarPBEMap:::'+districtAndVarPBEMap);
        try{
            for(String dist: districtAndVarPBEMap.keySet()){
                 for(String var:districtAndVarPBEMap.get(dist).keySet()){
                    OpportunityLineItem oli = new OpportunityLineItem();
                    System.debug('disVarMap.get(dist+var)::::'+disVarMap.get(dist+var));
                    oli.AllocatedBaselineUnits__c = Decimal.valueOf(disVarMap.get(dist+var));
                    oli.OpportunityId = distOppIdMap.get(dist).Id;
                    oli.OliMatchingKey__c = distOppIdMap.get(dist).AccountID+'|'+distOppIdMap.get(dist).Year__c+'|'+var;
                    oli.SP_Matching_Key__c = distOppIdMap.get(dist).Account.Account_Id__c+'|'+districtAndVarPBEMap.get(dist).get(var).product2.Product_ID__c+'|'+distOppIdMap.get(dist).Year__c+'|'+Category+'|'+Record_type;
                    oli.SP_Matching_Key_1__c = distOppIdMap.get(dist).Account.Account_Id__c+'|'+districtAndVarPBEMap.get(dist).get(var).product2.Product_ID__c+'|'+(Integer.valueOf(distOppIdMap.get(dist).Year__c)-1)+'|'+Category+'|'+Record_type;
                    oli.SP_Matching_Key_2__c = distOppIdMap.get(dist).Account.Account_Id__c+'|'+districtAndVarPBEMap.get(dist).get(var).product2.Product_ID__c+'|'+(Integer.valueOf(distOppIdMap.get(dist).Year__c)-2)+'|'+Category+'|'+Record_type;
                    oli.SKUName__c = districtAndVarPBEMap.get(dist).get(var).Product2.Name;
                    oli.PricebookEntryId = districtAndVarPBEMap.get(dist).get(var).Id;
                    oli.product2ID = districtAndVarPBEMap.get(dist).get(var).Product2ID;
                    oli.Quantity = Decimal.valueOf(1);
                    oli.TotalPrice = Decimal.valueOf(1);
                    oli.District__c = dist;
                    oli.Species__c = districtAndVarPBEMap.get(dist).get(var).Product2.Species__c;
                    oli.variety__c = var;
                    oliList.add(oli);
                }
            }
            System.debug('::::District oliList::::'+oliList);
            if(!oliList.isEmpty()){
                insert oliList;	
            }
            updateOLICYPS(oliList);
            updateOLICYactualsales(oliList);
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportuntiyLineItem','NA','OpportunitySeedsAllocation','oliCreation','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
        
    }
    
    /********************************************************************************************
* Method   : updateOLICYPS
* Description: Updating the CY Planned and Forcast values of OLIs
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 03-Jan-2018   HMT                     Created     
*********************************************************************************************/
    public void updateOLICYPS(List<OpportunityLineItem> opportunityOLIList)
    {
        try{
            Map<String, OpportunityLineItem> OLIMatchingKey = new Map<String, OpportunityLineItem>();
            If(!opportunityOLIList.isEmpty()){
                for(OpportunityLineItem oli : opportunityOLIList){
                    OLIMatchingKey.put(oli.OliMatchingKey__c,oli);
                }
            }
            //Get the related OpportunityLineItems of the District seeds sales plan
            List<OpportunityLineItem> relatedDistSPOLI = [Select Id,UnitPrice,OliMatchingKey__c,CY_Planned_Sales1__c,CY_1_Forecast_Sales__c from OpportunityLineItem where OliMatchingKey__c in: OLIMatchingKey.keyset() and (opportunity.Recordtype.developername=: label.RetailSeedsRecordType OR opportunity.Recordtype.developername=: label.District_Seeds_Sales_Plan) ];
            Map<String, OpportunityLineItem> matchingKeyWithOLI = new Map<String, OpportunityLineItem>();
            if(!relatedDistSPOLI.isEmpty())
            {
                List<OpportunityLineItem> OppsList = new List<OpportunityLineItem>();
                for(OpportunityLineItem oliMK : relatedDistSPOLI ){                               
                    OpportunityLineItem oppsOli = OLIMatchingKey.get(oliMK.OliMatchingKey__c);
                    System.debug('### oppsOli123 : '+oppsOli );
                    oppsOli.CY_Planned_Sales1__c = oliMK.CY_Planned_Sales1__c;
                    oppsOli.CY_1_Forecast_Sales__c = oliMK.CY_1_Forecast_Sales__c;
                    OppsList.add(oppsOli);
                }                       
                if(!OppsList.isEmpty()){
                    update OppsList;	
                }
                
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportuntiyLineItem','NA','OpportunitySeedsAllocation','updateOLICYPS','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    /********************************************************************************************
* Method   : updateOLICYactualsales
* Description: Updating the Sales plan Actual values for Allocation OLIs.
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 03-Jan-2018   HMT                     Created     
*********************************************************************************************/
    public void updateOLICYactualsales(List<OpportunityLineItem> opportunityOLIList)
    {
        //Get the related OpportunityLineItems of the District seeds sales plan
        List <String> OLIspKey = new List<String>();
        //Map<String, OpportunityLineItem> OLISPmatchingkey = new Map<String, OpportunityLineItem>();
        try{
            If(!opportunityOLIList.isEmpty())
            {
                for(OpportunityLineItem oli : opportunityOLIList)
                {
                    OLIspKey.add(oli.SP_Matching_Key__c);
                    OLIspKey.add(oli.SP_Matching_Key_1__c);
                    OLIspKey.add(oli.SP_Matching_Key_2__c);  
                }
            }    
            //List<Sales_Plan_Actual__c> relatedSPAOLI = [Select Id,Units__c,UniqueKey__c from Sales_Plan_Actual__c where UniqueKey__c in ('0014F0000032oSoQAI|539362|2017|Retail OTG Sales|Seeds_Sales','0014F0000032oSoQAI|539362|2016|Retail OTG Sales|Seeds_Sales','0014F0000032oSoQAI|539362|2015|Retail OTG Sales|Seeds_Sales') ];
            
            List<Sales_Plan_Actual__c> relatedSPAOLI = [Select Id,Units__c,UniqueKey__c from Sales_Plan_Actual__c where UniqueKey__c in : OLIspKey ];
            
            Map<String, Sales_Plan_Actual__c> matchingKeyWithSPAOLI = new Map<String, Sales_Plan_Actual__c>();
            if(!relatedSPAOLI.isEmpty())
            {
                List<OpportunityLineItem> OppsList = new List<OpportunityLineItem>();
                for(Sales_Plan_Actual__c spkey : relatedSPAOLI )
                {  
                    matchingKeyWithSPAOLI.put(spkey.UniqueKey__c,spkey);             
                }                             
                system.debug('matchingKeyWithSPAOLI@@@@'+matchingKeyWithSPAOLI);
                for(OpportunityLineItem olis : opportunityOLIList ){
                    if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key__c)!=null)
                    {
                        olis.SalesPlanActual__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key__c).id;
                    }
                    if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_1__c)!=null){
                        olis.Sales_Plan_Actual_1__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_1__c).id;
                    }
                    if(matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_2__c)!=null)
                    {
                        olis.Sales_Plan_Actual_2__c = matchingKeyWithSPAOLI.get(olis.SP_Matching_Key_2__c).id;
                    }
                    
                    OppsList.add(olis);
                }                       
                
                if(!OppsList.isEmpty()){
                    update OppsList;	
                }
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('OpportuntiyLineItem','NA','OpportunitySeedsAllocation','updateOLICYactualsales','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
    }
    
    /*****************************************************************************************************
* Method   : updatePreviousAllocations
* Description: Updating the previous updated units for seeds allocation OLI from the old map instance.
* ------------------------------------------------------------------------------------------
* Date            Name                    		Modification Description
* ------------------------------------------------------------------------------------------
* 09-Jan-2018 	  Jyothsna						Created 
* 10-Feb-2018     Ravikant                      Modified
* 15-Mar-2018	  Vijay							Modified
******************************************************************************************************/
    Public  void updatePreviousAllocations(Map<Id,OpportunityLineItem> oldOlis,Map<Id,OpportunityLineItem> newOlis){
        
        Map<Id,OpportunityLineItem> oliMapWithRecordTypes= new Map<Id,OpportunityLineItem>([Select Id,Opportunity.RecordType.DeveloperName,PreviousUpdatedUnits__c From OpportunityLineItem Where ID IN: oldOlis.keyset()]);
        
            for (Id oli : newOlis.Keyset()){
                if((oliMapWithRecordTypes.get(oli).Opportunity.RecordType.DeveloperName == Label.DistrictSeedsAllocation || oliMapWithRecordTypes.get(oli).Opportunity.RecordType.DeveloperName ==Label.SeedsAllocation_Terr_RT || oliMapWithRecordTypes.get(oli).Opportunity.RecordType.DeveloperName == Label.SeedsAllocation_Account_RT)&&
                  	oldOlis.get(oli).CurrentAllocationUnits__c != newOlis.get(oli).CurrentAllocationUnits__c && oldOlis.get(oli).CurrentAllocationUnits__c != null) 
               	 	newOlis.get(oli).PreviousUpdatedUnits__c = oldOlis.get(oli).CurrentAllocationUnits__c;
            }            
         
    }
    
}