public with sharing class ChequeRun_ControllerExt {
    
    class SettlementWrapper{
        public Settlement__c settlement{ get; set; }
        public boolean selected{ get; set; }
                
        public SettlementWrapper(Settlement__c newSettlement){
            settlement = newSettlement;
            selected = true;
        }
    }
   
    public List<SelectOption> typeFilterOptions {
        get{
            if (typeFilterOptions == null){
                ChequeRunSettings__c CustomSetting = ChequeRunSettings__c.getValues('ChequeRunSettlementTypes');
                typeFilterOptions = new List<SelectOption>();
                for (String name : SettingsMap.keySet()){
                    typeFilterOptions.add(new SelectOption(name,name));
                }
            }
            return typeFilterOptions ;
        }
        set;
    }    
    public List<Settlement__c> settlements{ get; set;}
    public List<Settlement__c> settlements_selected{ get; set;}
    public List<Settlement_Payment__c> settlementPayments{ get; set;}
    public Map<Id,Settlement_Payment__c> settlementPaymentMap{ get; set; }
    public Map <String,ChequeRunSettings__c> SettingsMap {get; set; }
                
    
    public String typeFilterSelection { get; set; }
    public String settlementTypeFilter { get; set; }
    public String allSettlements {
        get{
            if (allSettlements==null){
                allSettlements = '';
                for (RecordType r : [Select Name from RecordType where SObjectType in ('Settlement__c')]){
                    allSettlements += r.Name + ';';
                }
            }
            return allSettlements;
        }
        set;
    }
    public String caseTypeFilter {get; set;}
    public String allCases {
        get{
            if (allCases==null){
                allCases = '';
                for (RecordType r : [Select Name from RecordType where SObjectType in ('Case')]){
                    allCases += r.Name + ';';
                }
            }
            return allCases;
        }
        set;
    }
    public Cheque_Run__c newChequeRun{ get; set; }
    public Integer settlementListSize { get{ if (settlements== null) return 0; else return settlements.size(); } }
    public Integer paymentsListSize { get{ if (settlementPayments == null) return 0; else return settlementPayments.size(); } }
    public Double totalAmount { get; set;}
    public Date today { get{ if (today == null) today = Date.today(); return today; } set; }
  
    ApexPages.StandardController stdController;
    public List<SettlementWrapper> settlementWrapperList{ get; set; }

    public ChequeRun_ControllerExt(ApexPages.StandardController controller) {
        stdController = controller;
        SettingsMap = ChequeRunSettings__c.getAll();
        typeFilterSelection = typeFilterOptions.get(0).getLabel(); // initialize first selection
        RefreshSettlementWrapperList();
    } // Constructor for controller
    
    public void RefreshSettlementWrapperList(){
        // refresh the record type filters
        settlementTypeFilter = null;
        caseTypeFilter = null;
        if (SettingsMap.get(typeFilterSelection) != null){
            settlementTypeFilter = SettingsMap.get(typeFilterSelection).Settlement_Types__c;
            caseTypeFilter = SettingsMap.get(typeFilterSelection).Case_Types__c;
        }
        if (settlementTypeFilter == null){
            settlementTypeFilter = allSettlements;
        }
        if (caseTypeFilter == null){
            caseTypeFilter = allCases;
        }
        System.debug('Case Types: '+caseTypeFilter);
        System.debug('Settlement Types: '+settlementTypeFilter);
        settlements = [Select Name, Status__c, Settlement_Amount__c, CreatedDate, RecordType.Name,
                              Payable_To_Picklist__c, Pay_To_Name__c, Pay_To_Street__c, Pay_To_City__c, Pay_To_Province__c, Pay_To_Postal_Code__c,
                              Send_To__c, Send_To_Name__c, Send_To_Street__c, Send_To_City__c, Send_To_Province__c, Send_To_Postal_Code__c,
                              Case__c, Case__r.AccountID, Case__r.Purchased_From__c, Case__r.RecordType.Name, 
                              Case__r.Program_Name__c, Case__r.Contact.Language__c, Case__r.Account.District__c,
                              Case__r.Account.Owner.Employee_ID__c, Case__r.Account.Owner.FirstName, Case__r.Account.Owner.LastName, Case__r.Account.Owner.Name,
                              Case__r.Account.Owner.Email, Case__r.Account.Owner.MobilePhone,  Case__r.Account.Owner.Title
                              
                       from Settlement__c 
                       where Status__c = 'Submitted for Payment' // and Settlement_Payment__c = null
                             and RecordType.Name in :settlementTypeFilter.split(';')
                             and Case__r.RecordType.Name in :caseTypeFilter.split(';')
                       //order by Case__r.AccountID nulls last, Case__c, Name, CreatedDate DESC];
						 order by Case__r.RecordType.Name nulls last, Case__c, Name, CreatedDate DESC];
        System.debug('Rows Returned: '+settlements.size());
        
        settlementWrapperList = new List<SettlementWrapper>();
        totalAmount = 0;

        
        for (Settlement__c s : settlements){
            System.debug(s);
            if (s.Settlement_Amount__c != null){
                totalAmount = totalAmount + s.Settlement_Amount__c;
            }
            settlementWrapperList.add(new SettlementWrapper(s));
        }
        system.debug(settlementWrapperList);
    }
    
    public PageReference CancelAndRollback(){
        return stdController.Cancel();
        
    }
    
    public PageReference addSelected(){
        settlements_selected = new List<Settlement__c>();
        system.debug(settlementWrapperList);
        for (SettlementWrapper sw: settlementWrapperList){
            if(sw.selected){
                settlements_selected.add(sw.settlement);
            }
        }
        //Create settlement Payments for all the settlement records selected
        generatePayments();
        
        PageReference confirmPage = new PageReference('/apex/ChequeRun_Confirm_Page');
        confirmPage.setRedirect(false);
        return confirmPage;
    }
    
    public void generatePayments(){
        Settlement_Payment__c newPayment;
        ID AccountID;
        Map<Id,Settlement_Payment__c> voucherPaymentMap = new Map<Id,Settlement_Payment__c>();

        //Create a new cheque run to add the payments to
        newChequeRun = new Cheque_Run__c();
        
        settlementPayments = new List<Settlement_Payment__c>();
        settlementPaymentMap = new Map<Id,Settlement_Payment__c>();
        totalAmount = 0;
        
        for(Settlement__c s: settlements_selected){
            
            if (s.Payable_To_Picklist__c == 'Retailer'){
                AccountID = s.Case__r.Purchased_From__c;
            }else if (s.Payable_To_Picklist__c == 'Distributor'){
                AccountID = s.Distributor__c;
            }else{ // use the regular Account by default
                AccountID = s.Case__r.AccountID;
            }
            
            if (s.RecordTypeID == CLS_StaticUtils.getRecordTypeId('Settlement__c','Voucher')){
                if (voucherPaymentMap.get(AccountID) == null){
                    // when the first voucher is encountered for an account
                    newPayment = new Settlement_Payment__c(Account__c=AccountID,Amount__c=s.Settlement_Amount__c,Case__c=s.Case__c,
                                                           Pay_to__c=s.Payable_To_Picklist__c, Pay_to_Name__c=s.Pay_To_Name__c,
                                                           Pay_To_Street__c=s.Pay_To_Street__c, Pay_To_City__c=s.Pay_To_City__c,
                                                           Pay_To_Province__c=s.Pay_To_Province__c, Pay_To_Postal_Code__c=s.Pay_To_Postal_Code__c,
                                                           Purchased_From_Account__c=s.Case__r.Purchased_From__c,
                                                           Send_To__c=s.Send_To__c, Send_to_Name__c=s.Send_To_Name__c,
                                                           Send_to_Street__c=s.Send_To_Street__c, Send_to_City__c=s.Send_To_City__c,
                                                           Send_to_Province__c=s.Send_To_Province__c, Send_to_Postal_Code__c=s.Send_To_Postal_Code__c,
                                                           District__c=s.Case__r.Account.District__c, Language__c=s.Case__r.Contact.Language__c, 
                                                           Rep_Number__c=s.Case__r.Account.Owner.Employee_ID__c, Rep_Name__c=s.Case__r.Account.Owner.Name,
                                                           Rep_Email__c=s.Case__r.Account.Owner.Email, Rep_Phone_No__c=s.Case__r.Account.Owner.MobilePhone,
                                                           Rep_Title__c=s.Case__r.Account.Owner.Title, Program_Name__c=s.Case__r.Program_Name__c,
                                                           Type__c='Voucher',Status__c='New');
                    voucherPaymentMap.put(AccountID, newPayment);
                    settlementPayments.add(newPayment);
                }else{
                    newPayment = voucherPaymentMap.get(AccountID);
                    newPayment.Amount__c += s.Settlement_Amount__c;
                }
            } else {
                newPayment = new Settlement_Payment__c(Account__c=AccountID,Amount__c=s.Settlement_Amount__c,Case__c=s.Case__c,
                                                           Pay_to__c=s.Payable_To_Picklist__c, Pay_to_Name__c=s.Pay_To_Name__c,
                                                           Pay_To_Street__c=s.Pay_To_Street__c, Pay_To_City__c=s.Pay_To_City__c,
                                                           Pay_To_Province__c=s.Pay_To_Province__c, Pay_To_Postal_Code__c=s.Pay_To_Postal_Code__c,
                                                           Purchased_From_Account__c=s.Case__r.Purchased_From__c, 
                                                           Send_To__c=s.Send_To__c, Send_to_Name__c=s.Send_To_Name__c,
                                                           Send_to_Street__c=s.Send_To_Street__c, Send_to_City__c=s.Send_To_City__c,
                                                           Send_to_Province__c=s.Send_To_Province__c, Send_to_Postal_Code__c=s.Send_To_Postal_Code__c,
                                                           District__c=s.Case__r.Account.District__c, Language__c=s.Case__r.Contact.Language__c, 
                                                           Rep_Number__c=s.Case__r.Account.Owner.Employee_ID__c, Rep_Name__c=s.Case__r.Account.Owner.Name,
                                                           Rep_Email__c=s.Case__r.Account.Owner.Email, Rep_Phone_No__c=s.Case__r.Account.Owner.MobilePhone,
                                                           Rep_Title__c=s.Case__r.Account.Owner.Title, Program_Name__c=s.Case__r.Program_Name__c,
                                                           Type__c=CLS_StaticUtils.RecordTypeMap.get(s.RecordTypeID).Name,Status__c='New');
                settlementPayments.add(newPayment);
            }
            
            totalAmount = totalAmount + s.Settlement_Amount__c;
            System.debug('***ChequeRunController.generatePayments(): New Payment Generated: ('+newPayment.Name+') '+newPayment);
            settlementPaymentMap.put(s.id,newPayment);
        }
    }
    
    public PageReference SaveChequeRun(){
        Savepoint rollbackPoint= Database.setSavepoint();
        try{
            insert newChequeRun;
            for (Settlement_Payment__c sp: settlementPayments){
                sp.Cheque_Run__c = newChequeRun.id;
            }
            insert settlementPayments;
            for (Settlement__c s: settlements_selected){
                s.Settlement_Payment__c = settlementPaymentMap.get(s.id).id;
                //s.Status__c = 'Sent to Printer';
            }
            update settlements_selected;
            
            newChequeRun.Settlements_Status__c = 'Sent to Printer';
            update newChequeRun;
        }catch(DMLException e){
            System.debug(e);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Payments could not be created.  Please contact your Salesforce Administrator.'));
            //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getTypeName()+': '+e));
            Database.rollback(rollbackPoint);
            return null;
        }
        
        PageReference recordPage = new PageReference('/'+newChequeRun.id);
        recordPage.setRedirect(true);
        return recordPage ;
    }
}