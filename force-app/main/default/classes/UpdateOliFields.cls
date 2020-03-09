/********************************************************************************************
*   Class    : UpdateOliFields
*   Description  : Upadte the OLI previous fields values.
*   ------------------------------------------------------------------------------------------
*   Date          Name                    Modification Description
*   ------------------------------------------------------------------------------------------
*  09-Jan-2018 	  Jyothsna						Created
********************************************************************************************/
public class UpdateOliFields{
	/*****************************************************************************************************
    * Method   : updatePreviousAllocations
    * Description: Updating the previous updated units for seeds allocation OLI from the old map instance.
    * ------------------------------------------------------------------------------------------
    * Date            Name                    		Modification Description
    * ------------------------------------------------------------------------------------------
    * 09-Jan-2018 	  Jyothsna						Created 
    ******************************************************************************************************/
    Public  void updatePreviousAllocations(Map<Id,OpportunityLineItem> oldOlis,List<OpportunityLineItem> newOlis){
 		for (OpportunityLineItem updateOLI : newOlis){
			if(updateOLI.Opportunity.RecordType.DeveloperName == Label.DistrictSeedsAllocation){
                updateOLI.PreviousUpdatedUnits__c = oldOlis.get(updateOLI.Id).CurrentAllocationUnits__c;
			}
        }
          
    }
}