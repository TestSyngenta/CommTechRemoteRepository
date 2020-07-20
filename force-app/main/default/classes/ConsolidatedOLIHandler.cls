/********************************************************************************************
*   Class    : ConsolidatedOLIHandler
*   Description  : US-314301
*   ------------------------------------------------------------------------------------------
*   Date          Name                    Modification Description
*   ------------------------------------------------------------------------------------------
*  28-May-2018 	  Sravani						Created
********************************************************************************************/
public class ConsolidatedOLIHandler {
	Public string BpId {get;set;}
    public string AccName {get;set;}
    public string Year {get;set;}
    public String owner {get;set;}
    public string territory {get;set;}
    public string SalesOrg {get;set;}
    public Boolean errorExists {get;set;}
    public String productType;
    List<opportunity> oppList;
    Exception_Log__c exceptionLogRecord;
	public ConsolidatedOLIHandler(ApexPages.StandardController Controller){
        try{
        errorExists = false;
        BpId = controller.getId();
         productType = ApexPages.currentPage().getParameters().get('ProdType');
       	 if(BpId!=null)
            {
                oppList = [select id,AccountId,Related_Business_Plan_Locked__c,Account.Account_ID__c,Account.Name,AccountBusinessPlan__r.name,AccountBusinessPlan__c,Territory__c,Territory__r.District__r.Name,Territory__r.Name,Territory__r.Sales_Org_Description__c,Name, Owner.Name,Account_Territory__r.Parent_Account__r.Name,
                                     AccountBusinessPlan__r.Year__c,District__r.Name,CommercialUnit__c,PriceBook2Id,Product_Type__c,CountofOppProducts__c,RecordType.DeveloperName, Account_Territory__r.Parent_Account__c, year__c,RelatedDistributor__c, Sales_Plan_Type__c,IsBatchProcessing__c from Opportunity where AccountBusinessPlan__c =: BpId and Product_Type__c=:productType];
            }
        }
        catch(Exception e)
        {
             exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','ConsolidatedOLIHandler','Constructor','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
             insert exceptionLogRecord;
        }
        if(oppList!=null && oppList.size()!=0)
        {
        AccName =oppList[0].Account.Name;
        salesOrg = oppList[0].Territory__r.Sales_Org_Description__c;
		Year=oppList[0].AccountBusinessPlan__r.Year__c;
		owner=oppList[0].Owner.Name;
        territory=oppList[0].Territory__r.Name;
        }
   }
    public PageReference salesPlanError()
    {
        if(oppList!=null && oppList.size()!=0)
        {
         return null;
        }
        else
        {
        PageReference errorPage = new PageReference('/apex/ErrorPageforsalesplan');
        return errorPage;
        }
    }
}