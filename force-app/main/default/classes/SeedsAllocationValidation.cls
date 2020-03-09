/*********************************************************************************************
* Apex Class Name    :     SeedsAllocationValidation
* Version            :     1.0
* Created Date       :     18-Dec-2017
* Function           :     This class used to validate the "Seeds variety" and "District"   
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Ravikant                    18-Dec-2017            Created.
***********************************************************************************************/
public class SeedsAllocationValidation {
    
    Public static set<String> seedsVarietySet;
    Public static set<String> districtSet;
    //map to store L2 district and L1 commercial units.
    Public Map<String,String> mapL2toL1Territory;
    Private Id priceBookId;
    public static Id userId = UserInfo.getUserId();
    
    /********************************************************************************************
    * Method   : validateVariety
    * Description: Method for validating the "Seeds Variety" on Seeds Allocation
    * ------------------------------------------------------------------------------------------
    * Date          	Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 18-Dec-2017  	    Ravikant            	Created     
    ********************************************************************************************/
    Public void validateVariety(List<SeedsAllocation__c> saList){
        set<String> seedsVarietyFromSystem = new set<String>();
        seedsVarietySet = new set<String>();
        try{
			priceBookId = getPriceBookId();
			System.debug('::::PricebookId::::'+priceBookId);
			for(SeedsAllocation__c sa:saList){
				seedsVarietySet.add(sa.SeedsVariety__c);
			}
			seedsVarietySet.remove(null);
			System.debug('::::seedsVarietySet::::'+seedsVarietySet);
			for(PriceBookEntry pbe:[SELECT Id,product2.Id,Product2.variety__c FROM PriceBookEntry WHERE PriceBook2Id=: priceBookId AND IsActive = true AND Product2.Variety__c IN : seedsVarietySet AND Product2.IsActive = True AND Product2.AvailableforPlanning__c = True AND (Product2.Product_ID__c != null OR Product2.Product_ID__c != '') AND Product2.RecordType.DeveloperName =: Label.SeedsProductsRecordType]){
				seedsVarietyFromSystem.add(String.valueOf(pbe.Product2.variety__c));
			}
			seedsVarietyFromSystem.remove(null);
			System.debug('::::seedsVarietyFromSystem::::'+seedsVarietyFromSystem);
			for(SeedsAllocation__c sa:saList){
				if(String.valueOf(sa.SeedsVariety__c) == NULL || !seedsVarietyFromSystem.contains(String.valueOf(sa.SeedsVariety__c)))
				{
					sa.addError('Variety does not exist in the system.');
				}
			}
		}catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('SeedsAllocation__c','NA','SeedsAllocationValidation','validateVariety','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
        
    }
    
     /********************************************************************************************
    * Method   : validateDistrictCU
    * Description: Method for validating the "Districts" and "CU" on Seeds Allocation
    * ------------------------------------------------------------------------------------------
    * Date          	Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 19-Dec-2017  	    Ravikant            	Created     
    ********************************************************************************************/
    public void validateDistrictCU(List<SeedsAllocation__c> saList){
        districtSet = new Set<String>();
        Set<String> cuSet = new Set<String>();
        Set<String> districtsFromSystem = new Set<String>();
        try{
			populateDistrictCUMap(saList);
			cuSet.addAll(mapL2toL1Territory.values());
			System.debug('::::cuSet::::'+cuSet);
			if(cuSet.size()>1 || cuSet.size()<=0){
				for(SeedsAllocation__c sa:saList){
					sa.addError('Commercial Units are different for the Selected districts');
				}
				return;
			}
			
			for(String s:mapL2toL1Territory.keySet()){
				districtSet.add(s.removeEnd(mapL2toL1Territory.get(s)));
			}
			System.debug('::::districtSet::::'+districtSet);
			
			for(Territory__c terr:[SELECT ID FROM Territory__c WHERE ID IN : districtSet AND Commercialunit__r.Name IN : cuSet]){
				districtsFromSystem.add(terr.Id);
			}
			
			for(SeedsAllocation__c sa:saList){
				if(!districtsFromSystem.contains(sa.District__c)){
					sa.addError('Districts selected are not from the selected Commercial Units.');
				}
			}
		}catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('SeedsAllocation__c','NA','SeedsAllocationValidation','validateDistrictCU','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
            
               
    }
    
    /********************************************************************************************
    * Method   : populateDistrictCUMap
    * Description: Generic method for getting the map of "District" and "Commercial Units"
    * ------------------------------------------------------------------------------------------
    * Date          	Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 19-Dec-2017  	    Ravikant            	Created     
    ********************************************************************************************/
    public void populateDistrictCUMap(List<SeedsAllocation__c> sa){
        mapL2toL1Territory = new Map<String,String>();
        for(SeedsAllocation__c s:sa){
            mapL2toL1Territory.put(s.District__c+s.CommercialUnit1__c, s.CommercialUnit1__c);
        }
    }
    
    /********************************************************************************************
    * Method   : getPriceBookId
    * Description: Generic method for getting the pricebook Id for Seeds Allocation.
    * ------------------------------------------------------------------------------------------
    * Date          	Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 18-Dec-2017  	    Ravikant            	Created     
    ********************************************************************************************/
    public Id getPriceBookId(){
        //Get the pricebookid from the custom meta data
        PriceBook_for_SalesPlan__mdt pbId = [Select Seeds_Price_BookID__c from PriceBook_for_SalesPlan__mdt LIMIT 1];
        if(pbId.Seeds_Price_BookID__c!=null){
            return pbId.Seeds_Price_BookID__c;
        }
        return null;
    }
	
    /***********************************************************************************************
    * Method   : getCommercialUnit
    * Description: Generic method for auto populating the CU based on User's CU for Seeds Allocation
    * ------------------------------------------------------------------------------------------
    * Date          	Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 28-Dec-2017  	    Jyothsna Rasineni       Created     
    ************************************************************************************************/
    Public void getCommercialUnit(List<SeedsAllocation__c> saList){
        User loggedinUser = [select id, user_country__c, Territory_Code__c from User where id = :userInfo.getUserId()];
      	Territory__c userCU = [select Name from Territory__c where Name = :loggedinUser.Territory_Code__c];
        for(SeedsAllocation__c sa:saList){
            if(userCU!=null) {
            	sa.CommercialUnit1__c=userCU.name;
            }
        }
    }

}