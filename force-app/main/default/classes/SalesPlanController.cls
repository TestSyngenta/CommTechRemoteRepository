/********************************************************************************************
*   Class    : SalesPlanController
*   Description  : US-231913
*   ------------------------------------------------------------------------------------------
*   Date          Name                    Modification Description
*   ------------------------------------------------------------------------------------------
*  15-Dec-2017     Pooja            Created
*  19-Dec-2017    Sruthi          Modified
*  21-Dec-2017    Sruthi             Modified for US-228386
********************************************************************************************/
public class SalesPlanController {
    private final ApexPages.StandardController controller;
    public Id recordTypeId {get;private set;}  
    public static String OpprecordType;
    public RecordType oppRecId;
    public String navigationURL {get;private set;}
    public Boolean newSalesPlanning {get;private set;}
    public Id userId = UserInfo.getUserId();
    
    public SalesPlanController(ApexPages.StandardController opportunityController){
        this.controller = opportunityController;
        navigationURL = '';
        newSalesPlanning = false;
    }
    
    Public pagereference redirectURL(){
        
        String prodType;
        try{
            Id BPID = ApexPages.currentPage().getParameters().get('BPId');
            Business_Plan__c BusinessPlan = [select id,name,Year__c,Account__c,Recordtype.DeveloperName from Business_Plan__c where id = :BPID];
            User loggedinUser = [select id,FirstName,LastName, User_Country__c, Territory_Code__c, Profile.Name from User where id = :userInfo.getUserId() Limit 1];
            prodType = ApexPages.currentPage().getParameters().get('ProdType');
            String oppRecType = ApexPages.currentPage().getParameters().get('OppRecType');
            //to check for Retail HeadOffice SalesPlan Creation Access
            if(oppRecType == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || oppRecType == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name){
                if(checkForCreateAccess(loggedinUser,oppRecType)== False){
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'You do not have permission to create a Retailer Head Office Forecast on this account.');
                    ApexPages.addMessage(myMsg);
                    return null;
                }
            }
            if(prodType != null && prodType != ''){
                newSalesPlanning = true;
                navigationURL =  SalesPlanCreationHandler.createSPHeader();
            }
            else{
                recordTypeId = ApexPages.currentPage().getParameters().get('RecordType');
                String recordTypeDeveloperName = ApexPages.currentPage().getParameters().get('RecTypeDeveloperName');
                if(recordTypeDeveloperName != null){
                    oppRecId = [Select Id,Name, developerName from Recordtype where developerName =:recordTypeDeveloperName];
                }
                
                newSalesPlanning = true;
                
                //Call code to create New Opportunity and Return OppId
                navigationURL =  SalesPlanCreationHandler.createSPHeader();
                
            }    
        }
        catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','SalesPlanController','redirectURL','Technical exception',userId,e.getStackTraceString(),'TC0001/0002',e.getMessage());
            insert exceptionLogRecord; 
        }
        return null;
    }
    
    public pageReference redirect(){
        if(navigationURL !=null && navigationURL != ''){
            PageReference newPage = new PageReference(navigationURL);
            return newPage.setRedirect(true);
        }
        
        return null; 
    }
    
    /********************************************************************************************
    * Method:     checkForCreateAccess
    * Description: To check whether the user has access to create Retail Head Sales Plan or not.
    * ------------------------------------------------------------------------------------------
    * Date          Name                    Modification Description
    * ------------------------------------------------------------------------------------------
    * 22-Jan-2018   Ravikant                Created
    ********************************************************************************************/
    public boolean checkForCreateAccess(User loggedinUser, String oppRecType){
        String userTerritory = loggedinUser.Territory_Code__c;
        String assignedRep = (loggedinUser.FirstName != null && loggedinUser.FirstName !='' ? loggedinUser.FirstName : '')+' '+(loggedinUser.LastName != null && loggedinUser.LastName !='' ? loggedinUser.LastName : '')+ ' '+'('+loggedinUser.Territory_Code__c+')';
        String accId = ApexPages.currentPage().getParameters().get('AccId');
        Territory__c territory = new Territory__c();
        Set<String> UserRelatedTerr = new Set<String>();
        Set <Id> territories = new Set<Id>();
        try{
            territory = [Select id,TerritoryLevel__c,District__c,commercialUnit__c From Territory__c
                            WHERE Name =: userTerritory];
            if(oppRecType == Label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name || oppRecType == Label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name){
                /* 2018-09-25 TC: Modifying accTerr query to include any users whose territory is like the Account Territory 
                Old Code: List<Account_Territory__c> accTerr = [Select Id From Account_Territory__c Where Account__c =:accId And Territory__r.Name =: userTerritory Limit 1];*/
                List<Account_Territory__c> accTerr = [Select Id From Account_Territory__c Where Account__c =:accId And Territory__r.Name like :userTerritory + '%' Limit 1];
                
                /* 2018-09-25 TC: Modifying to allow a Head Office plan to be created if the account is a Head Office or it is a Parent Account
                Old Code: List<Account_Territory__c> headAccTerr = [Select Id From Account_Territory__c Where Head_Office_Account__c =:accId Limit 1];*/
                List<Account_Territory__c> headAccTerr = [Select Id From Account_Territory__c Where Head_Office_Account__c =:accId or Parent_Account__c =:accId Limit 1];
                if(accTerr.size()==1 && headAccTerr.size()==1){
                    return true;
                }        
            } 
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('Account_Territory__c','NA','SalesPlanController','checkForCreateAccess','Technical exception',userId,e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }
        return false;
    }
    
}