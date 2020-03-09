public class Settlement_Send_ERelease_Controller {

    ApexPages.StandardController stdController;
    
    public User currentUser { get; set; }
    public Settlement__c currentSettlement{ get; set; } 
    
    public Settlement_Send_ERelease_Controller(ApexPages.StandardController controller) {
        stdController = controller;
    }
    
    public PageReference SendRelease(){
        PageReference release;
        Id settlementId = stdController.getId();
        currentSettlement = [select Id, Settlement_Amount__c from Settlement__c where Id = :settlementId];
        /*if(currentSettlement.Settlement_Amount__c < 5000)
        {
                release = new PageReference('/apex/echosign_dev1__AgreementTemplateProcess?masterid=' + settlementId + '&templateId=a1Co0000002lGrL');
        }
        else
        {*/
            release = new PageReference('/' + settlementId);      
        /*}*/
        
        return release;
    }
}