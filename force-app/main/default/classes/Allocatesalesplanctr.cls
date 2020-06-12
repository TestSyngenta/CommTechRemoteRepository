/****************************************
* class name  : Allocatesalesplanctr
* Description : Controller for Edit Sales Plan at CU level.
* Developer   : Hema Latha
* Date        : 8th January, 2018
* modified    :
****************************************/
public  class  Allocatesalesplanctr{
    
    public Boolean errorExists {get;set;}
    public string OpportunityId {get;set;} 
    public Opportunity Oppty;
    public string ChildOpportunityIds {get;set;}
    public string TerOpportunityIds {get;set;}
    public String AccOpportunityIds {get;set;} // retail account oppys
    public string oppName {get;set;}
    //public string oppYear {get;set;}
    //public string AreaLevelName {get;set;}
    public string AssignedRep {get;set;}
    public ID AssignedRepId {get;set;}
    //public string territotyAccountSales {get;set;}
    //public string profileNameToValidate {get;set;}
    public string rtName {get;set;}
    public string CUName {get;set;}
    public string AccName {get;set;}
    Public string Year {get;set;}
    public String dist {get;set;}
    public String territory {get;set;}
    List<Opportunity> opptysList = new list<Opportunity>();
    static Exception_Log__c exceptionList;
    /****************************************
* Method name : Allocatesalesplanctr
* Description : Controller to get opportunity details
* Developer   : Hema Latha
* Date        : 8th January 2018
****************************************/    
    public Allocatesalesplanctr(ApexPages.StandardController controller)
    {   
        if(!test.isRunningTest()){
            controller.addFields(new List<String>{'Name','RecordType.DeveloperName','territory__r.name',
                'territory__r.Assigned_Rep__r.Name','territory__r.Assigned_Rep__r.Name','territory__r.Assigned_Rep__c',
                'account.Name','Year__c','territory__c'});
        }
        
        errorExists = false;          
        OpportunityId = controller.getId(); 
        Oppty = (Opportunity)controller.getRecord();
        oppName = Oppty.Name;
        dist = Oppty.Territory__c;
        territory = Oppty.Territory__c;
        rtName = Oppty.RecordType.DeveloperName;
        CUName = Oppty.territory__r.name;
        AssignedRep  = Oppty.territory__r.Assigned_Rep__r.Name;
        AssignedRepId = Oppty.territory__r.Assigned_Rep__c;
        AccName = Oppty.account.Name;
        Year = Oppty.Year__c;
        ChildOpportunityIds='';
        ChildOpportunityIds = getChildOpportunityIds();
        System.debug('ChildOpportunityIds+++'+ChildOpportunityIds);
        TerOpportunityIds ='';
        TerOpportunityIds = getDistChildOpportunityIds();
        System.debug('TerOpportunityIds+++'+TerOpportunityIds);
        AccOpportunityIds ='';
        AccOpportunityIds = getRetailAccountOpportunityIds();
        system.debug('TerOpportunityIds@@@'+TerOpportunityIds);
    }
    
    public Boolean getShowAllocateToTerritories()
    {
        Boolean showButton = true;
        return showButton;
    }
/****************************************
* Method name : AllocateToTerritories
* Description : Method to get Allocate to territories and send notification district managers about the allocation
* Developer   : Hema Latha
* Date        : 8th January 2018
****************************************/
    public void AllocateToTerritories()
    {
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Id Terr_rt= oppRecordtypes.get(Label.SeedsAllocation_Terr_RT);
        String Dist_rt= Label.Seeds_Allocation_Dist_RT;
        List<Territory__c> Dist;
        try
        {
            if(CUName!=Null)
            {
                System.debug('CUName'+CUName);
                Dist = [select id,Assigned_Rep__r.name,Assigned_Rep__r.email,Name from Territory__c where TerritoryLevel__c = 'L2:District' AND CommercialUnit__r.Name =:CUName and Assigned_Rep__r.isActive = true];
            }
            List<Opportunity> distOpptys = new List<Opportunity>();
            Map<id,Opportunity> DMemail = new Map<id,Opportunity>();
            if(Dist!=Null)
            {
                distOpptys = [Select Id,Recordtype.developername,Territory__r.name,Territory__r.Assigned_Rep__r.name,Territory__r.Assigned_Rep__r.email,(select id,district__C,Territory__r.Assigned_Rep__r.name from Opportunitylineitems)from Opportunity where Territory__c  In :Dist AND 
                              Id!=:OpportunityId AND Year__c =: Year and Recordtype.developername =: Dist_rt];
            }
            System.debug('distOpptys:::::'+distOpptys);
            if(!distOpptys.isEmpty()){
                for(Opportunity opp : distOpptys){
                    if(opp.Opportunitylineitems.size()>0){
                        DMemail.put(opp.id, opp);
                    }
                }
            }
            system.debug('DMemail:'+DMemail);
            sendEmail(DMemail);
            AllocateOppyToTerritories(CUName,OpportunityId,Year);
           // AllocateOppyToRetailAccounts(OpportunityId,Year,territory);
        }
        catch(Exception e)
        {
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','AllocateToTerritories','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
        }
        
    }  
/****************************************
* Method name : AllocateToAccounts
* Description : Method to get Allocate to Accounts and send notification district managers about the allocation
* Developer   : Hema Latha
* Date        : 15th March 2018
****************************************/
    public void AllocateToAccounts()
    {
        //Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        //Id Terr_rt= oppRecordtypes.get(Label.SeedsAllocation_Terr_RT);
        //String Dist_rt= Label.Seeds_Allocation_Dist_RT;
        Map<id,Opportunity> DMemail = new Map<id,Opportunity>();
        //List<Territory__c> Dist;
        try
        {
            Map<id,Territory__c> ChildDistrictMap = new Map<id,territory__c>([select id,Assigned_Rep__c,Name,TerritoryLevel__c,CommercialUnit__c from territory__c where TerritoryLevel__c = 'L3:Territory' AND district__C=:dist and Assigned_Rep__r.isActive = true]);//and CommercialUnit__r.Name = : CUName  district__C=:dist 
            system.debug('@@@ChildDistrictMap'+ChildDistrictMap);
            List<Opportunity> listChildOpptys = new List<Opportunity>();
            listChildOpptys = [Select Id,Territory__c,Territory__r.name,Territory__r.Assigned_Rep__r.name,Territory__r.Assigned_Rep__r.email,(select id,district__C,Territory__r.Assigned_Rep__r.name from Opportunitylineitems), Recordtype.developername from Opportunity where Territory__c  In : ChildDistrictMap.keySet() AND 
                               Id!=:OpportunityId AND Year__c =: Year and Recordtype.developername = 'Territory_Seeds_Allocation'];
            System.debug('listChildOpptys:::::'+listChildOpptys);
            if(!listChildOpptys.isEmpty()){        
                for(Opportunity opp : listChildOpptys){
                    if(opp.Opportunitylineitems.size()>0){
                        DMemail.put(opp.id, opp);
                    }
                }
            }
            system.debug('DMemail:'+DMemail);
            sendEmail(DMemail);
            //AllocateOppyToTerritories(CUName,OpportunityId,Year);
            AllocateOppyToRetailAccounts(OpportunityId,Year,territory);
        }
        catch(Exception e)
        {
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','AllocateToTerritories','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
        }
        
    }      
/****************************************
* Method name : getChildOpportunityIds
* Description : Method to get district details for the CU
* Developer   : Ravikanth
* Date        : 8th January 2018
****************************************/  
    public String getChildOpportunityIds(){
        String childOppts;
        Set<Id> setHelper;
        try
        {
            Map<id,Territory__c> ChildDistrictMap = new Map<id,territory__c>([select id,Assigned_Rep__c,Name,TerritoryLevel__c,CommercialUnit__c from territory__c where TerritoryLevel__c = 'L2:District' AND CommercialUnit__r.Name = : CUName and Assigned_Rep__r.isActive = true]);
            List<Opportunity> listChildOpptys = new List<Opportunity>();
            listChildOpptys = [Select Id,Territory__c from Opportunity where Territory__c  In : ChildDistrictMap.keySet() AND 
                               Id!=:OpportunityId AND Year__c =: Year and Recordtype.developername = 'District_Seeds_Allocation'];
            System.debug('listChildOpptys:::::'+listChildOpptys);
            if(!listChildOpptys.isEmpty()){
                
                for(Opportunity opp: listChildOpptys){
                    if(childOppts!=null && childOppts!=''){
                        childOppts = childOppts+ ',' + opp.Id;
                    }
                    else{
                        childOppts = opp.Id;
                    }
                }
                
            }
            System.Debug('--check opptys in main method -- '+childOppts);
            childOppts = childOppts==null?'':childOppts.removeEnd(',');
        }
        catch(Exception e)
        {
            childOppts='';
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','getChildOpportunityIds','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
            
        }
        return childOppts;
    }
/****************************************
* Method name : getDistChildOpportunityIds
* Description : Method to get district details for the CU
* Developer   : Ravikanth
* Date        : 8th January 2018
****************************************/  
    public String getDistChildOpportunityIds(){
        String distChildOppts;
        Set<Id> setHelper;
        system.debug(' Oppy district: L2Territory'+dist);
        try
        {
            Map<id,Territory__c> ChildDistrictMap = new Map<id,territory__c>([select id,Assigned_Rep__c,Name,TerritoryLevel__c,CommercialUnit__c from territory__c where TerritoryLevel__c = 'L3:Territory' AND district__C=:dist and Assigned_Rep__r.isActive = true]);//and CommercialUnit__r.Name = : CUName  district__C=:dist 
            system.debug('@@@ChildDistrictMap'+ChildDistrictMap);
            List<Opportunity> listChildOpptys = new List<Opportunity>();
            listChildOpptys = [Select Id,Territory__c from Opportunity where Territory__c  In : ChildDistrictMap.keySet() AND 
                               Id!=:OpportunityId AND Year__c =: Year and Recordtype.developername = 'Territory_Seeds_Allocation'];
            System.debug('listChildOpptys:::::'+listChildOpptys);
            if(!listChildOpptys.isEmpty()){
                
                for(Opportunity opp: listChildOpptys){
                    if(distChildOppts!=null && distChildOppts!=''){
                        distChildOppts = distChildOppts+ ',' + opp.Id;
                    }
                    else{
                        distChildOppts = opp.Id;
                    }
                }
                
            }
            System.Debug('--check opptys in main method -- '+distChildOppts);
            distChildOppts = distChildOppts==null?'':distChildOppts.removeEnd(',');
        }
        catch(Exception e)
        {
            distChildOppts=null;
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','getDistChildOpportunityIds','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
        }
        return distChildOppts;
    }
    
    
    public String getRetailAccountOpportunityIds(){
        String terChildOppts;
        Set<Id> setHelper;
        system.debug(' Oppy Territory: L3Territory'+territory);
        try
        {
            Map<id,Territory__c> ChildTerritoryMap = new Map<id,territory__c>([select id,Assigned_Rep__c,Name,TerritoryLevel__c,CommercialUnit__c from territory__c where TerritoryLevel__c = 'L3:Territory' AND id=:territory and Assigned_Rep__r.isActive = true ]);//district__C=:territory and  and CommercialUnit__r.Name = : CUName  district__C=:dist 
            //Account__r.recordtype.developerName = 'CA_Retailer' and Account__r.AllowSeedsplanning__c=true and Sales_Org_Description__c='Seedcare'
            system.debug('@@@ChildTerritoryMap'+ChildTerritoryMap);
            List<Opportunity> listChildOpptys = new List<Opportunity>();
            listChildOpptys = [Select Id,Territory__c from Opportunity where Territory__c  In : ChildTerritoryMap.keySet() AND 
                               Id!=:OpportunityId AND Year__c =: Year and Account.recordtype.developerName = 'CA_Retailer' and 
                               Account.AllowSeedsplanning__c=true and Recordtype.developername = 'Account_Seeds_Allocations'];
            System.debug('list Retail account Opptys:::::'+listChildOpptys);
            if(!listChildOpptys.isEmpty()){
                
                for(Opportunity opp: listChildOpptys){
                    if(terChildOppts!=null && terChildOppts!=''){
                        terChildOppts = terChildOppts+ ',' + opp.Id;
                    }
                    else{
                        terChildOppts = opp.Id;
                    }
                }
                
            }
            System.Debug('--check territory opptys  in main method -- '+terChildOppts);
            terChildOppts = terChildOppts==null?'':terChildOppts.removeEnd(',');
        }
        catch(Exception e)
            
        {
            terChildOppts=null;
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','getTerChildOpportunityIds','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
        }
        return terChildOppts;
    }
    /****************************************
* Method name : sendEmail
* Description : Method to notify district managers 
* Developer   : Hema
* Date        : 10th January 2018
****************************************/
    public void sendEmail(Map<id,Opportunity> DMemail)
    {
        try
        {
            Messaging.SingleEmailMessage [] emailslist = new List<Messaging.SingleEmailMessage>();
			Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            for(opportunity opp : DMemail.values()){
                if(opp.Recordtype.developername == Label.Seeds_Allocation_Dist_RT){
                String subject =Label.DistSeedsAllocation;
                String[] toEmail = new String[] {opp.Territory__r.Assigned_Rep__r.email};
                if(toEmail!=Null)
                {
                    email.setSubject(subject);
                    email.setToAddresses(toEmail);
                    email.setHtmlBody( Label.DistSeedsAllocationEmailBody +' '+'"'+opp.Territory__r.name+'".' +' '+'To view your Sales Plan <a href=https://syngentacanada--apdev--c.cs93.visual.force.com/'+opp.Id+'>click here.</a>');
                    emailslist.add(email);
                }
                }
                else if(opp.Recordtype.developername == Label.SeedsAllocation_Terr_RT){
                    String subject =Label.TerrSeedsAllocation;
                String[] toEmail = new String[] {opp.Territory__r.Assigned_Rep__r.email};
                if(toEmail!=Null)
                {
                    email.setSubject(subject);
                    email.setToAddresses(toEmail);
                    email.setHtmlBody( Label.TerrSeedsAllocationEmailBody +' '+'"'+opp.Territory__r.name+'".' +' '+'To view your Sales Plan <a href=https://syngentacanada--apdev--c.cs93.visual.force.com/'+opp.Id+'>click here.</a>');
                    emailslist.add(email);  
                }
                }
            }
			Messaging.Email[] allMails = new List<Messaging.Email>();
			for( Messaging.SingleEmailMessage singleemail:emailslist ){
			allMails.add(singleemail);
			}
			Messaging.SendEmailResult[] r = Messaging.sendEmail( allMails );
        }
        catch(Exception e)
        {
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','sendEmail','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
        }
        
    }
    
    /****************************************
* Method name : AllocateOppyToTerritories
* Description : Method to create Oppy, Oppylineitems on territory
* Developer   : Hema
* Date        : 10th January 2018
****************************************/
    public static  void AllocateOppyToTerritories(String CUName, String OpportunityId,String Year)
    {
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Id Terr_rt= oppRecordtypes.get(Label.SeedsAllocation_Terr_RT);
        String Dist_rt= Label.Seeds_Allocation_Dist_RT;
        String Category = Label.SeedsAllocation_Category;
        String Record_type = Label.Seeds_Sales;
        List<Territory__c> Dist;
        try{
            if(CUName!=null)
            {
                Dist = [select id,Assigned_Rep__r.name,Assigned_Rep__r.email,Name from Territory__c where TerritoryLevel__c = 'L2:District' AND  CommercialUnit__r.Name =:CUName and Assigned_Rep__r.isActive = true];  
            }
            system.debug('Districts@@@'+Dist);
            List<Opportunity> distOpptys = new List<Opportunity>();
            
            //Level2: District with Opportunities
            Map<id,List<Opportunity>> distwithoppys = new Map<id,List<Opportunity>>();
            Map<Id,List<Opportunitylineitem>> oppywithOppline = new Map<Id,List<Opportunitylineitem>>();
            
            distOpptys = [Select Id,Territory__r.name,RelatedDistributor__c,AccountBusinessPlan__r.Year__c,Territory__c,Territory__r.District__C,Territory__r.id,Territory__r.Assigned_Rep__r.name,Territory__r.Assigned_Rep__r.email,NextStep,Pricebook2Id,Year__c,(select id,OpportunityId,PricebookEntryId,UnitPrice,Quantity,PricebookEntry.product2Id,product2Id,Year__c,Product2.Name,Territory__c,Territory__r.Assigned_Rep__c,CurrentAllocationUnits__c,product2.Product_ID__c,PricebookEntry.product2.Product_ID__c ,Territory__r.Assigned_Rep__r.name,Variety__c from Opportunitylineitems)from Opportunity where Territory__c  In :Dist AND 
                          Year__c =: Year and Recordtype.developername =: Dist_rt]; // Id!=:OpportunityId AND
            System.debug('distOpptys:::::'+distOpptys);
            List<String> lstDistrict = new List<String>();    
            
            if(!distOpptys.isEmpty())
            {
                for(Opportunity opp : distOpptys){
                    lstDistrict.add(opp.Territory__c);
                    
                    if(distwithoppys.containsKey(opp.Territory__r.id)){
                        distwithoppys.get(opp.Territory__r.id).add(opp);
                    }
                    else
                    {
                        distwithoppys.put(opp.Territory__r.id,new List<Opportunity>{opp})	;	
                    }
                    if(!opp.Opportunitylineitems.isEmpty())
                    {
                        if(oppywithOppline.containskey(opp.id))
                        {
                            oppywithOppline.get(opp.id).addAll(opp.Opportunitylineitems);
                        }
                        else{
                            system.debug('opp.Opportunitylineitems'+opp.Opportunitylineitems);
                            
                            
                            List<Opportunitylineitem> obTemoLT= new List<Opportunitylineitem>();
                            
                            obTemoLT.addAll(opp.Opportunitylineitems);
                            oppywithOppline.put(opp.id,obTemoLT);  //  opportunities  with OL
                        }
                        
                       
                    } 
                    
                    
                }
                system.debug('@@@ map oppywithOppline'+oppywithOppline);
                system.debug('distwithoppys'+distwithoppys);
            }				
            
            //Level3:  Territory and its District Oppys
            
            List<Territory__c> Ter = [select id, District__c,District__r.id,Assigned_Rep__r.name,Name, (select id,name from Opportunities__r where Year__c =: Year) from Territory__c where TerritoryLevel__c = 'L3:Territory' AND District__c in:lstDistrict and Assigned_Rep__r.isActive = true];
            Map<Id,list<Territory__c>> territorywithDistrict = new Map<Id,list<Territory__c>>();
            //Map<Id,List<opportunity>> terrwithOpp = new Map<Id,List<opportunity>>();
            Set<id> setTerr = new Set<id>();
            map<Id, Integer> mapIDterrisize = new map<Id, Integer>();
            Integer noofTerri;
            system.debug('Ter@@@@'+Ter);
            
            if(!Ter.isEmpty())
            {
                for(Territory__c t:Ter)
                {	
                    
                    if(!(mapIDterrisize.containskey(t.District__c)))
                    {
                        mapIDterrisize.put(t.District__c,1);
                    }
                    else
                    {
                        mapIDterrisize.put(t.District__c, mapIDterrisize.get(t.District__c)+1); // territory with opportunities
                    }
                    system.debug('mapIDterrisize@@@@'+mapIDterrisize);
                    setTerr.add(t.id); // all territories ids  
                    system.debug('territories --Level3 @@@'+setTerr);
                    
                }
            }
            
            if(setTerr.size()>0)  
            {
                List<Account_Territory__c> Acc = [ select id,Name,Territory__c,Account__c,Account__r.id,Territory__r.Name,Territory__r.District__r.id,Territory__r.District__c,Territory__r.Assigned_Rep__c,Territory__r.Assigned_Rep__r.name from Account_Territory__c where Territory__c in:setTerr and  account__r.recordtype.developerName=:label.Planning_Account]; 
                system.debug('----Acc ------'+ Acc ) ;
                if(!Acc.isEmpty())
                {
                    system.debug('----Acc ------'+ Acc ) ;
                    List<Opportunity> oppyToinsert = new LIst<Opportunity>();
                    List<Opportunity> lstoppys = new List<Opportunity>();
                    Map<integer,Id> mapIntwithOldoppy = new  Map<integer,Id> ();
                    Map<String,Id> mapStringwithOldoppy = new  Map<String,Id> ();
                    
                    for(Account_Territory__c Ac : Acc){
                        
                        system.debug('distwithoppys KeySet@@'+distwithoppys.keySet());
                        system.debug('Territory__r.District__c@@@'+Ac.Territory__r.District__c);
                        system.debug('Ac.Territory__r.District__r.id@@'+Ac.Territory__r.District__r.id);
                        if(distwithoppys.containsKey(Ac.Territory__r.District__r.id))
                        {
                            lstoppys = distwithoppys.get(Ac.Territory__r.District__r.id); // parent oppys 1 
                            system.debug('lstoppys'+lstoppys);
                        }
                        integer i=1;     
                        system.debug('lstoppys size'+lstoppys.size());
                        for(Opportunity opp:lstoppys)
                        {
                            system.debug('oppy'+opp);
                            Opportunity newOpp= new Opportunity();
                            newOpp.AccountId = Ac.Account__r.id;
                           // newOpp.Name = year + '_' + Ac.Territory__c + '_Allocations';
                            newOpp.Name = year + ' '+ 'Seed Allocation' +'-'+ Ac.Territory__r.Name ;
                            newOpp.CloseDate = System.today() + 90;
                            newOpp.OwnerId = Ac.Territory__r.Assigned_Rep__c!=null?Ac.Territory__r.Assigned_Rep__c:UserInfo.getUserId();
                            newOpp.SalesRep__c = ac.Territory__r.Assigned_Rep__r.name!=null?ac.Territory__r.Assigned_Rep__r.name:UserInfo.getName();
                            newOpp.StageName = 'New';
                            newOpp.RecordTypeId = Terr_rt;
                            newOpp.Territory__c = Ac.Territory__c;
                            
                            newOpp.Year__c = year;
                            newOpp.NextStep = opp.NextStep;
                            newOpp.Pricebook2Id = opp.Pricebook2Id;
                            newOpp.Dist_Oppy_Id__c = ''+opp.Id+Ac.Account__r.id+opp.year__c; //external id : year +oppy id +account territory (acc id)
                            
                            newOpp.RelatedDistributor__c = opp.RelatedDistributor__c;
                            oppyToinsert.add(newOpp);
                            
                            mapIntwithOldoppy.put(i,opp.Id);
                            mapStringwithOldoppy.put(newopp.Dist_Oppy_Id__c,opp.Id);
                            i++;
                            // break;
                        }
                        
                    }
                    system.debug('mapIntwithOldoppy@@@'+mapIntwithOldoppy);
                    system.debug('oppyToinsert @@@'+oppyToinsert +'listsize' +oppyToinsert.size());
                    Schema.SObjectField oppyExtfield = Opportunity.Dist_Oppy_Id__c;
                    system.debug('externalid@@@' +oppyExtfield);
                    Database.UpsertResult[] oppyUpsert = Database.upsert(oppyToinsert, oppyExtfield, false);
                    system.debug('oppyUpsert Results'+oppyUpsert);
                    //  insert oppyToinsert;
                    
                    List<ID> upsertedOppyList = new List<ID>();
                    List<Opportunitylineitem> existingOppLineItems = new List<Opportunitylineitem>();
                    Map<String,Opportunitylineitem> existingOliMap = new Map<String,Opportunitylineitem>();
                    for(Database.UpsertResult res:oppyUpsert)
                    {
                        if(res.isSuccess())
                        {
                            upsertedOppyList.add(res.getId());
                        }
                    }
                    if(!upsertedOppyList.isEmpty())
                    {
                       existingOppLineItems = [select id,Dist_oppyline_Id__c from Opportunitylineitem where OpportunityId IN:upsertedOppyList];
                       if(existingOppLineItems.size()>0)
                       {
                   	   for(Opportunitylineitem oli:existingOppLineItems)
                       {
                           existingOliMap.put(oli.Dist_oppyline_Id__c, oli);
                       }
                       }
                    }
                   
                    system.debug('upserted result@@@'+upsertedOppyList);
                    Integer j=1;
                    Map<Id, Integer> mapIntwithNewoppy = new Map<Id, Integer>();
                    Map<Id, String> mapStringwithNewoppy = new Map<Id, String>();
                    for(opportunity o:oppyToinsert)
                    {
                        mapIntwithNewoppy.put(o.id,j);
                        mapStringwithNewoppy.put(o.id,o.Dist_Oppy_Id__c);
                        j++;
                    }
                    system.debug('mapIntwithNewoppy!@@@'+mapIntwithNewoppy);
                    list<Opportunitylineitem> oppyLineItems = new list<Opportunitylineitem>();
                    list<Opportunitylineitem> oppyLineItemsToinsert = new list<Opportunitylineitem>();
                    
                    system.debug('oppyToinsert'+oppyToinsert);
                    
                    for(opportunity o:[select id,Name,AccountId,Account.Account_Id__c,SalesRep__c,CloseDate,OwnerId,StageName,RecordTypeId,recordtype.developerName,Territory__c,Territory__r.district__C,Year__c,NextStep,Pricebook2Id,Dist_Oppy_Id__c,RelatedDistributor__c From Opportunity where id in :oppyToinsert])
                    {
                         
                        oppyLineItems = oppywithOppline.get(mapStringwithOldoppy.get(mapStringwithNewoppy.get(o.Id)));
                        system.debug('oppyLineItems@@@'+oppyLineItems);
                        system.debug('mapIDterrisize'+mapIDterrisize);
                        system.debug('Oppy Territory'+o.Territory__c +'opp district' +o.Territory__r.District__c); // getting null here.
                        
                        noofTerri= mapIDterrisize.get(o.Territory__r.District__c);
                        
                        for(Opportunitylineitem ol:oppyLineItems)
                        {
                            Opportunitylineitem newOppylineitem = new Opportunitylineitem();
                            newOppylineitem.OpportunityId = o.id; //Opportunity Id has to be assigned
                            
                            newOppylineitem.Quantity = ol.Quantity;
                            newOppylineitem.UnitPrice = ol.UnitPrice;
                           
                            newOppylineitem.OliMatchingKey__c = o.AccountId+'|'+o.Year__c+'|'+ ol.Variety__c ;// ol.PricebookEntry.product2Id '0014F0000032oSoQAI|2017|539362';  o.product2.Product_ID__c;
                            
                            newOppylineitem.SP_Matching_Key__c = o.Account.Account_Id__c +'|'+ol.PricebookEntry.product2.Product_ID__c+'|'+o.Year__c+'|'+Category+'|'+Record_type; //ol.PricebookEntry.product2Id
                            newOppylineitem.SP_Matching_Key_1__c = o.Account.Account_Id__c +'|'+ol.PricebookEntry.product2.Product_ID__c+'|'+(Integer.valueOf(o.Year__c)-1)+'|'+Category+'|'+Record_type; //ol.PricebookEntry.product2Id
                            newOppylineitem.SP_Matching_Key_2__c = o.Account.Account_Id__c+'|'+ol.PricebookEntry.product2.Product_ID__c+'|'+(Integer.valueOf(o.Year__c)-2)+'|'+Category+'|'+Record_type; //ol.PricebookEntry.product2Id
                            newOppylineitem.SKUName__c = ol.Product2.Name;  
                            newOppylineitem.Territory__c = o.Territory__c;
                            newOppylineitem.Sales_Rep__c =o.SalesRep__c;//Territory__r.Assigned_Rep__r.name;
                            newOppylineitem.Variety__c = ol.Variety__c;
                            system.debug('newOppylineitem.Variety__c..:'+newOppylineitem.Variety__c+'.ol.Variety__c.'+ol.Variety__c);
                            
                            newOppylineitem.Dist_oppyline_Id__c = ''+ol.Id+''+ o.Dist_Oppy_Id__c;
                            if(!existingOliMap.containsKey(newOppylineitem.Dist_oppyline_Id__c))
                            {
                                newOppylineitem.PricebookEntryId = ol.PricebookEntryId;
                            }
                            if(noofTerri>0)
                            {
                                newOppylineitem.AllocatedBaselineUnits__c = Math.floor((ol.CurrentAllocationUnits__c/noofTerri).setscale(2)); 
                                
                            }
                            oppyLineItemsToinsert.add(newOppylineitem) ;    
                        }
                    }
                    system.debug('oppyLineItemsToinsert@@@@'+oppyLineItemsToinsert);
                    
                    Schema.SObjectField oliExtfield = Opportunitylineitem.Dist_oppyline_Id__c;
                    system.debug('externalid@@@' +oliExtfield);
                    Database.UpsertResult[] oliUpsert = Database.upsert(oppyLineItemsToinsert, oliExtfield, false);
                    system.debug('OliUpsert result'+oliUpsert);
                    
                    List<ID> upsertedOppyLineItems = new List<ID>();
                    for(Database.UpsertResult res:oliUpsert)
                    {
                        if(res.isSuccess())
                        {
                            upsertedOppyLineItems.add(res.getId());
                        }
                    }
                    
                    system.debug('upsertedOppyLineItems@@@'+upsertedOppyLineItems);
                    //   insert oppyLineItemsToinsert;
                    
                    List<OpportunityLineItem> newOppylineItems = [select id, name,OpportunityId,Quantity,UnitPrice,OliMatchingKey__c,SP_Matching_Key__c, SP_Matching_Key_1__c, SP_Matching_Key_2__c,SKUName__c,Territory__c, Territory__r.Assigned_Rep__c,Dist_oppyline_Id__c,AllocatedBaselineUnits__c from OpportunityLineItem where id in:upsertedOppyLineItems] ;
                    OpportunitySeedsAllocation oppySeedsAlloc = new OpportunitySeedsAllocation();
                    system.debug('newOppylineItems'+newOppylineItems);
                    oppySeedsAlloc.updateOLICYactualsales(newOppylineItems);
                    oppySeedsAlloc.updateOLICYPS(newOppylineItems);
                    
                }
            }
        }
        catch(Exception e)
        {
            exceptionList=ExceptionLogHelperClass.createExceptionLogRecord('Opportunity','NA','Allocatesalesplanctr','AllocateOppyToTerritories','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),'',e.getMessage());
            insert exceptionList;
        }
    }
    
    // Allocate oppy & line items to Retail Accounts Territories 
    
    public void AllocateOppyToRetailAccounts(String OpportunityId,String Year,String District)
    { 
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Id Terr_rt= oppRecordtypes.get(Label.SeedsAllocation_Account_RT);
        System.debug('Opportunity recordtype@@'+Terr_rt);
        
        String Category = Label.Retail_OTG_Sales;
        String Record_type = Label.Seeds_Sales;
        List<Opportunity> terOpptys = new List<Opportunity>();
        Map<id,List<Opportunity>> terwithOppys = new Map<id,List<Opportunity>>();
        Map<Id,List<Opportunitylineitem>> oppywithOppline = new Map<Id,List<Opportunitylineitem>>();
        Set<Territory__C> allTerr = new Set<Territory__C>();
        
        system.debug('Opportunity@@@'+OpportunityId +'DIstrict@@@@'+District+'@@@@Year'+Year);
        
        Map<Id,Territory__c> distWithTer = new Map<Id,Territory__c>([select id, District__c,District__r.id,Assigned_Rep__r.name,Name from Territory__c where TerritoryLevel__c = 'L3:Territory' AND District__c=:District and Assigned_Rep__r.isActive = true]);
        system.debug('Dist and its Territories'+distWithTer);
        
        if(!distWithTer.isEmpty())
        {
            for(Territory__c t:distWithTer.values())
            {
                allTerr.add(t);
                
            }     
        }
        system.debug('all Territories@@@'+allTerr+'Size@@@'+allTerr.size());
        terOpptys = [Select Id,Territory__r.name,RelatedDistributor__c,AccountBusinessPlan__r.Year__c,Territory__c,Territory__r.District__C,
                     Territory__r.id,Territory__r.Assigned_Rep__r.name,Territory__r.Assigned_Rep__r.email,NextStep,Pricebook2Id,Year__c,
                     (select id,OpportunityId,PricebookEntryId,UnitPrice,Quantity,PricebookEntry.product2Id,product2Id,Year__c,Product2.Name,
                      Territory__c,Territory__r.Assigned_Rep__c,CurrentAllocationUnits__c,product2.Product_ID__c,PricebookEntry.product2.Product_ID__c,
                      Territory__r.Assigned_Rep__r.name,Variety__c from Opportunitylineitems)from Opportunity where Territory__c  In :allTerr AND 
                     Year__c =: Year and Recordtype.developername = 'Territory_Seeds_Allocation'];
        
        system.debug('Territory Oppys'+terOpptys);
        
        if(!terOpptys.isEmpty())
        {
            for(Opportunity op:terOpptys)
            {
                if(terwithOppys.containsKey(op.Territory__c)){
                    terwithOppys.get(op.Territory__c).add(op);
                }
                else
                {
                    terwithOppys.put(op.Territory__c,new List<Opportunity>{op});
                }
                
                system.debug('terwithOppys@@@'+terwithOppys);
                if(!op.Opportunitylineitems.isEmpty())
                {
                    if(oppywithOppline.containsKey(op.id)) 
                    {
                        oppywithOppline.get(op.id).addAll(op.Opportunitylineitems);
                    }
                    else
                    {
                        List<Opportunitylineitem> olis= new List<Opportunitylineitem>();
                        
                        olis.addAll(op.Opportunitylineitems);
                        oppywithOppline.put(op.id,olis);
                    }
                }
                system.debug('oppywithOppline@@@'+oppywithOppline);
            }
            system.debug('Territory with opporutnities@@@@'+terwithOppys);
            system.debug('Opportunity with opportunities@@@@'+oppywithOppline);
        }
        
        if(allTerr.size()>0)
        {
            List<Account_Territory__c> retailAccounts = [select id,Name,Territory__c,Account__c,Account__r.id,Territory__r.District__r.id,Territory__r.District__c,Territory__r.Assigned_Rep__c,Territory__r.Assigned_Rep__r.name 
                                                         from Account_Territory__c where Account__r.recordtype.developerName = 'CA_Retailer' and Account__r.AllowSeedsplanning__c=true and Sales_Org_Description__c='Crop Protection and Seed' and Territory__C in :allTerr];        
            system.debug('Reatil Accounts@@@@'+retailAccounts);
            Map<Id,Integer> mapIDaccountsize = new Map<ID,Integer>();
            Integer noofAccounts;
            
            if(!retailAccounts.isEmpty())
            {
                for(Account_Territory__c acTer:retailAccounts)
                {
                    if(!(mapIDaccountsize.containskey(acTer.Territory__c)))
                    {
                        mapIDaccountsize.put(acTer.Territory__c,1);
                    }
                    else
                    {
                        mapIDaccountsize.put(acTer.Territory__c, mapIDaccountsize.get(acTer.Territory__c)+1); // territory with opportunities
                    }
                }
                system.debug('mapIDaccountsize'+mapIDaccountsize);
                
                List<Opportunity> oppyToInsert = new List<Opportunity>();
                List<Opportunity> lstOppy = new List<Opportunity>();
                Map<String,Id> mapStringwithOldoppy = new  Map<String,Id> ();
                
                for(Account_Territory__c acTer:retailAccounts)
                {
                    
                    if(terwithOppys.containsKey(acTer.Territory__c))
                    {
                        lstOppy =  terwithOppys.get(acTer.Territory__c);
                        system.debug('territory opportunities from account territory loop@@@'+lstOppy +' @@Size@@'+lstOppy.size());
                    }
                    
                    for(Opportunity opp:lstOppy)
                    {
                        Opportunity newOpp= new Opportunity();
                        newOpp.AccountId = acTer.Account__r.id;
                       // newOpp.Name = Year + '_' + acTer.Territory__c + '_Allocations'; // year + 
                        newOpp.Name = Year + ' ' + 'Seed Allocation' + '-' + acTer.Territory__c ;
                        newOpp.CloseDate = System.today() + 90;
                        newOpp.OwnerId = acTer.Territory__r.Assigned_Rep__c!=null?acTer.Territory__r.Assigned_Rep__c:UserInfo.getUserId();
                        newOpp.SalesRep__c = acTer.Territory__r.Assigned_Rep__r.name!=null?acTer.Territory__r.Assigned_Rep__r.name:UserInfo.getName();
                        newOpp.StageName = 'New';
                        newOpp.RecordTypeId = Terr_rt;  // record type  //Account_Seeds_Allocations
                        newOpp.Territory__c = acTer.Territory__c;
                        
                        newOpp.Year__c = Year;
                        newOpp.NextStep = opp.NextStep;
                        newOpp.Pricebook2Id = opp.Pricebook2Id;
                        newOpp.Dist_Oppy_Id__c = ''+opp.Id+acTer.Account__r.id+opp.year__c; //external id : year +oppy id +account territory (acc id)
                        
                        newOpp.RelatedDistributor__c = opp.RelatedDistributor__c;
                        oppyToinsert.add(newOpp);
                        
                        // mapIntwithOldoppy.put(i,opp.Id);
                        mapStringwithOldoppy.put(newopp.Dist_Oppy_Id__c,opp.Id);
                    }
                    
                }
                
                system.debug('oppyToinsert for Retail Accounts @@@'+oppyToinsert +'listsize' +oppyToinsert.size());
                Schema.SObjectField oppyExtfield = Opportunity.Dist_Oppy_Id__c;
                system.debug('externalid retail account oppy@@@' +oppyExtfield);
                Database.UpsertResult[] oppyUpsert = Database.upsert(oppyToinsert, oppyExtfield, false);
                
                List<ID> upsertedOppyList = new List<ID>();
                List<Opportunitylineitem> existingOppLineItems = new List<Opportunitylineitem>();
                Map<String,Opportunitylineitem> existingOliMap = new Map<String,Opportunitylineitem>();
                for(Database.UpsertResult res:oppyUpsert)
                {
                    if(res.isSuccess())
                    {
                        upsertedOppyList.add(res.getId());
                    }
                }
                if(!upsertedOppyList.isEmpty())
                    {
                       existingOppLineItems = [select id,Dist_oppyline_Id__c from Opportunitylineitem where OpportunityId IN:upsertedOppyList];
                       if(existingOppLineItems.size()>0)
                       {
                   	   for(Opportunitylineitem oli:existingOppLineItems)
                       {
                           existingOliMap.put(oli.Dist_oppyline_Id__c, oli);
                       }
                       }
                    }
                system.debug('upserted result for Retail Accounts@@@'+upsertedOppyList);
                
                Map<Id, String> mapStringwithNewoppy = new Map<Id, String>();
                
                for(opportunity o:oppyToinsert)
                {
                    
                    mapStringwithNewoppy.put(o.id,o.Dist_Oppy_Id__c);
                    
                }
                
                // OLi process
                list<Opportunitylineitem> oppyLineItems = new list<Opportunitylineitem>();
                list<Opportunitylineitem> oppyLineItemsToinsert = new list<Opportunitylineitem>();
                
                for(opportunity o:[select id,Name,SalesRep__c,AccountId,Account.Account_Id__c,CloseDate,OwnerId,StageName,RecordTypeId,recordtype.developerName,Territory__c,
                                   Territory__r.district__C,Year__c,NextStep,Pricebook2Id,Dist_Oppy_Id__c,RelatedDistributor__c 
                                   From Opportunity where id in :oppyToinsert])
                {
                    system.debug('mapStringwithNewoppy.get(o.Id)'+mapStringwithNewoppy.get(o.Id));
                    oppyLineItems = oppywithOppline.get(mapStringwithOldoppy.get(mapStringwithNewoppy.get(o.Id)));
                    noofAccounts = mapIDaccountsize.get(o.Territory__c);
                    system.debug('mapIDaccountsize@@@'+mapIDaccountsize+'noofAccounts@@@'+noofAccounts);
                    
                    for(Opportunitylineitem ol:oppyLineItems)
                    {
                        Opportunitylineitem newOppylineitem = new Opportunitylineitem();
                        newOppylineitem.OpportunityId = o.id; //Opportunity Id has to be assigned
                        
                        newOppylineitem.Quantity = ol.Quantity;
                        newOppylineitem.UnitPrice = ol.UnitPrice;
                        
                        newOppylineitem.OliMatchingKey__c = o.AccountId+'|'+o.Year__c+'|'+ ol.Variety__c ;// ol.PricebookEntry.product2Id '0014F0000032oSoQAI|2017|539362';  o.product2.Product_ID__c;
                        
                        newOppylineitem.SP_Matching_Key__c = o.Account.Account_Id__c +'|'+ol.PricebookEntry.product2.Product_ID__c+'|'+o.Year__c+'|'+Category+'|'+Record_type; //ol.PricebookEntry.product2Id
                        newOppylineitem.SP_Matching_Key_1__c = o.Account.Account_Id__c +'|'+ol.PricebookEntry.product2.Product_ID__c+'|'+(Integer.valueOf(o.Year__c)-1)+'|'+Category+'|'+Record_type; //ol.PricebookEntry.product2Id
                        newOppylineitem.SP_Matching_Key_2__c = o.Account.Account_Id__c +'|'+ol.PricebookEntry.product2.Product_ID__c+'|'+(Integer.valueOf(o.Year__c)-2)+'|'+Category+'|'+Record_type; //ol.PricebookEntry.product2Id
                        system.debug('newOppylineitem.SP_Matching_Key__c'+newOppylineitem.SP_Matching_Key__c+'...'+newOppylineitem.SP_Matching_Key_1__c);
                        newOppylineitem.SKUName__c = ol.Product2.Name;  
                        newOppylineitem.Territory__c = o.Territory__c;
                        newOppylineitem.Account__c = o.AccountId;
                        newOppylineitem.Sales_Rep__c =o.SalesRep__c;//Territory__r.Assigned_Rep__r.name;
                        newOppylineitem.Variety__c = ol.Variety__c;
                        
                        newOppylineitem.Dist_oppyline_Id__c = ''+ol.Id+''+ o.Dist_Oppy_Id__c;
                        if(!existingOliMap.containsKey(newOppylineitem.Dist_oppyline_Id__c))
                            {
                                newOppylineitem.PricebookEntryId = ol.PricebookEntryId;
                            }
                        if(noofAccounts>0)
                        {
                                newOppylineitem.AllocatedBaselineUnits__c = Math.floor((ol.CurrentAllocationUnits__c/noofAccounts).setscale(2)); 
                        } 
                        oppyLineItemsToinsert.add(newOppylineitem) ;    
                    }
                }
                system.debug('oppyLineItemsToinsert@@@@'+oppyLineItemsToinsert);
                
                Schema.SObjectField oliExtfield = Opportunitylineitem.Dist_oppyline_Id__c;
                system.debug('externalid Retail accounts OLI@@@' +oliExtfield);
                Database.UpsertResult[] oliUpsert = Database.upsert(oppyLineItemsToinsert, oliExtfield, false);
                system.debug('OliUpsert result for Retail Accounts'+oliUpsert);
                
                List<ID> upsertedOppyLineItems = new List<ID>();
                for(Database.UpsertResult res:oliUpsert)
                {
                    if(res.isSuccess())
                    {
                        upsertedOppyLineItems.add(res.getId());
                    }
                }
                system.debug('upsertedOppyLineItems for Retail Accounts@@@'+upsertedOppyLineItems);
                List<OpportunityLineItem> newOppylineItems = [select id, name,OpportunityId,Quantity,UnitPrice,OliMatchingKey__c,SP_Matching_Key__c, SP_Matching_Key_1__c, SP_Matching_Key_2__c,SKUName__c,Territory__c, Territory__r.Assigned_Rep__c,Dist_oppyline_Id__c,AllocatedBaselineUnits__c from OpportunityLineItem where id in:upsertedOppyLineItems] ;
                OpportunitySeedsAllocation oppySeedsAlloc = new OpportunitySeedsAllocation();
                system.debug('newOppylineItems Retail Accounts'+newOppylineItems);
                oppySeedsAlloc.updateOLICYactualsales(newOppylineItems);
                oppySeedsAlloc.updateOLICYPS(newOppylineItems);
                
            }
            
        }
        
    }
}