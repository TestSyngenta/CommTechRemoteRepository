public with sharing class AccountDetails_Acreage_Controller {
    private ApexPages.StandardController stdController;
    private final Account acct;
    
    public AccountDetails_Acreage_Controller(ApexPages.StandardController controller) {
        this.stdController = controller;
        acct = (Account)controller.getRecord();

        AcreageList = [Select Acres__c, Account__c, Crop_description_formula__c, Year__c, BioPotential__c
                       from Crop_Acreage__c where Account__c=:acct.id and Most_Recent__c=true order by Acres__c DESC];
        totalAcres = 0;
        totalBP = 0.0;
        for (Crop_Acreage__c c: AcreageList){
            totalAcres = totalAcres + Integer.valueOf(c.Acres__c);
            totalBP += c.BioPotential__c;
        }
    }
    
    public Integer totalAcres{
        get;
        private set;
    }
    public Double totalBP{
        get;
        private set;
    }
    public List<Crop_Acreage__c> AcreageList { 
        get;
        private set; 
    }

}