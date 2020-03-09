/********************************************************************************************
* Class:     ToUpdateRelatedPlan to write the methods
* Description: US-240841
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 17-Jan-2018   Hema                     Created
********************************************************************************************/
public class ToUpdateRelatedPlan{
    public static Opportunity opp;
    public static Account acc;
    public static String recType;
    public static Id recordTypeId;
    public static Id bpRecordTypeId;
    Public static Business_Plan__c bp;
    Public static Business_Plan__c bpr;
    Public static Territory__C dist;
    
    
/********************************************************************************************
* Method     :  UpdateDSPRelatedPlan
* Description:  To update related CU plan details on opportunity
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
*17-Jan-2018    HLT      Created
********************************************************************************************/  
    public static void UpdateDSPRelatedPlan(Opportunity oppsid){
        Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
        Map<string,id> bpRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Business_Plan__c.SObjectType);
        //recType = ApexPages.currentPage().getParameters().get('OppRecType');
        system.debug('ApexPages.currentPage():'+ApexPages.currentPage());
        try{
            Opportunity Oppid = [select id,year__c,Territory__c,commercialunit__C,RelatedDistributor__c,RelatedDistributorPlan__c, product_type__c,Recordtype.Developername,recordtypeid from Opportunity where id =:oppsId.id limit 1];
            recordtype rt = [select developername from recordtype where id =:Oppid.recordtypeid limit 1];
            rectype = rt.developername;
            system.debug('oppid...:'+oppid);
            if(recType == label.DistributorCPSalesPlan || (recType == label.Distributor_Seeds_Sales_Plan)){
                if(oppid.product_type__C == 'Seeds'){
                    recordTypeId = oppRecordtypes.get(label.CU_SeedsSalesPlan);    
                }
                else{
                    recordTypeId = oppRecordtypes.get(label.CP_CU_Sales_Plan_Record_Type_Name);    
                }
                bpRecordTypeId = bpRecordtypes.get(label.CU_BusinessPlan); 
                system.debug('recordTypeId...:'+recordTypeId);      
                try{
                opp = [Select id,AccountBusinessPlan__c,commercialunit__C,RelatedDistributor__c,Product_Type__c from Opportunity where account.Territory_Lookup__r.name =: OppId.commercialunit__C and Year__c =: oppid.Year__c and account.Territory_Lookup__r.TerritoryLevel__c = 'L1:Commercial unit' and product_type__C =: oppid.Product_Type__c and account.recordtype.developername =: label.Planning_Account and recordTypeId =:recordTypeId limit 1] ;
                }catch(exception e){
                    opp = null;
                }
                system.debug('opp....:'+opp);
                if(opp==null){
                    try{
                    acc = [select id, Territory_Lookup__r.id  from account where Territory_Lookup__r.name =: OppId.commercialunit__C and Territory_Lookup__r.TerritoryLevel__c = 'L1:Commercial unit' and account.recordtype.developername =:label.Planning_Account limit 1];
                    }catch(exception e){
                    acc = null;
                   }                        
                    if(acc != null){
                        try{
                        bpr = [select id from Business_Plan__c where Year__c =: OppId.Year__c and account__C =: acc.id limit 1];
                        }catch(exception e){
                         bpr = null;
                        }  
                     if(bpr==null){
                            bpr =  CreatebpPlan(acc.id,oppid.year__c,bpRecordTypeId);
                        }
                        Opportunity oppt = createopp(acc.id,bpr,OppId,bpRecordTypeId,recordTypeId,null,null,null,null);
                        OppId.RelatedCUPlan__c = oppt.id;
                        system.debug('oppt....:'+oppt);
                        update oppId;
                        
                    }
                }
                else{ OppId.RelatedCUPlan__c = opp.id;
                     update oppId;
                     system.debug('oppt....:'+oppId);
                    }
            }
            else if(recType == label.Territory_Sales_Plan || (recType == label.Territory_Seeds_Sales_Plan)){
              try{
                        system.debug('oppid.Territory__c....'+oppid.Territory__c);
                        dist = [select id, District__c,district__r.Assigned_Rep__c from Territory__c where id =: oppid.Territory__c limit 1];
                        opp = [Select id,commercialunit__c,accountid from opportunity where Account_Territory__r.Territory__c =: dist.District__c and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c limit 1] ;//and account__r.Territory_Lookup__r.TerritoryLevel__c = 'L2:District' and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c and account.recordtype.developername =:label.Planning_Account];    
                        }catch(exception e){
                          if(dist==null){
                            dist = null;
                            opp=null;
                          }
                          else{
                            opp=null;
                          }
                         }   
                if(opp==null){
                    if(oppid.product_type__C == 'CP'){
                        recordTypeId = oppRecordtypes.get(label.District_Sales_Plan);    
                    }
                    else{
                        recordTypeId = oppRecordtypes.get(label.District_Seeds_Sales_Plan);    
                    }
                    bpRecordTypeId = bpRecordtypes.get(label.District_Business_Plan);
                    Account_territory__C acct;
                    try{
                    //acct = [select id, account__c from account_territory__C where Territory__c =: OppId.Territory__c and Account__r.recordtype.developername =:label.Planning_Account limit 1];
                    acct = [select id, account__c from account_territory__C where Territory__c =: dist.District__c and Territory__r.TerritoryLevel__c = 'L2:District' and Account__r.recordtype.developername =:label.Planning_Account limit 1];
                    }catch(exception e){
                    acct = null;
                   } 
                   if(acct!=null){
                        try{
                            bp = [select id from Business_Plan__c where Year__c =: OppId.Year__c and Account__c =:acct.account__c limit 1];
                        }catch(exception e){
                        bp = null;
                        }  
                        if(bp==null){
                            bp =  CreatebpPlan(acct.account__c,oppid.year__c,bpRecordTypeId);
                        }
                        Opportunity retopp = createopp(acct.account__c,bp,OppId,bpRecordTypeId,recordTypeId,null,null,dist,null);
                        OppId.RelatedTerritoryPlan__c = retopp.id;
                        update oppId;
                    }
                }
                else{
                    OppId.RelatedTerritoryPlan__c = opp.id;
                    update oppId;
                    system.debug('oppId....:'+oppId);
                }
            }
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('opportunity','NA','ToUpdateRelatedPlan','UpdateDSPRelatedPlan','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        }  
        
    }
    /********************************************************************************************
* Method     :  ASPRelatedPlan
* Description:  To update related distributor plan and related head office plan details on opportunity
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
*17-Jan-2018    HLT      Created
********************************************************************************************/
    public void ASPRelatedPlan(Id oppIdlist){
        try{
            Opportunity Oppid = [select id,year__c,Territory__c,commercialunit__C,Account_Territory__r.account__c,Account_Territory__r.Head_Office_Account__c,RelatedDistributor__c,RelHeadOfficePlan__c,RelatedDistributorPlan__c,RelatedTerritoryPlan__c, product_type__c,Recordtype.Developername from Opportunity where id =:oppIdlist limit 1];
            if(oppid!= null){
                recType = Oppid.Recordtype.Developername;
                system.debug('oppid.recordtype.developername...:'+recType);
                if(recType.contains('Retail')){
                    system.debug('Oppid....:'+Oppid);
                    Map<string,id> oppRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Opportunity.SObjectType);
                    Map<string,id> bpRecordtypes = GenericUtils.GetRecordTypeIdsByDeveloperName(Business_Plan__c.SObjectType);
                    bpRecordTypeId = bpRecordtypes.get(label.Retail_Business_Plan);
                    Opportunity oppty;
                    if(Oppid.Account_Territory__r.Head_Office_Account__c != null){
                        try{
                        oppty = [Select id,commercialunit__c from opportunity where accountid =: oppid.Account_Territory__r.Head_Office_Account__c and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c limit 1];
                        }catch(exception e){
                        oppty = null;
                        }  
                        if(oppty==null){
                            if(oppid.product_type__C == 'CP'){
                                recordTypeId = oppRecordtypes.get(label.CP_Retailer_Head_Office_Sales_Plan_Record_Type_Name);  
                            }
                            else{
                                recordTypeId = oppRecordtypes.get(label.Seeds_Retailer_Head_Office_Sales_Plan_Record_Type_Name);
                            }
                            try{
                            bp = [select id from Business_Plan__c where Year__c =: OppId.Year__c and Account__c =:oppid.Account_Territory__r.Head_Office_Account__c limit 1];
                            }catch(exception e){
                             bp = null;
                            }  
                            if(bp==null){
                                bp =  CreatebpPlan(oppid.Account_Territory__r.Head_Office_Account__c,oppid.year__c,bpRecordTypeId);    
                            }
                            Opportunity oppt = createopp(oppid.Account_Territory__r.Head_Office_Account__c,bp,OppId,bpRecordTypeId,recordTypeId,null,null,null,Oppid.RelatedDistributor__c);
                            OppId.RelHeadOfficePlan__c = oppt.id;
                        }
                        else{
                            OppId.RelHeadOfficePlan__c = oppty.id;
                        }
                    }
                    else{
                        Opportunity opptlist;
                        try{
                        opptlist= [Select id,commercialunit__c from opportunity where accountid =: oppid.RelatedDistributor__c and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c limit 1];
                        }catch(exception e){
                         opptlist = null;
                         }  
                        if(opptlist==null){
                            try{
                                 if(oppid.product_type__C == 'CP'){
                                    recordTypeId = oppRecordtypes.get(label.CP_CU_Sales_Plan_Record_Type_Name);    
                                }
                                else{
                                    recordTypeId = oppRecordtypes.get(label.CU_SeedsSalesPlan);    
                                }
                            //opp =[select id from Opportunity where AccountId in (select id from Account where Territory_Lookup__r.name=:OppId.commercialunit__C) and Account.RecordType.Name =:label.Planning_Account limit 1];
                            opp = [Select id from Opportunity where account.Territory_Lookup__r.name =: OppId.commercialunit__C and Year__c =: oppid.Year__c and account.Territory_Lookup__r.TerritoryLevel__c = 'L1:Commercial unit' and product_type__C =: oppid.Product_Type__c and account.recordtype.developername =: label.Planning_Account and recordTypeId =:recordTypeId limit 1] ;
                            }catch(exception e){
                             opp = null;
                             }  
                          if(opp == null){
                               
                                bpRecordTypeId = bpRecordtypes.get(label.CU_BusinessPlan); 
                                system.debug('recordTypeId...:'+oppid.recordTypeId);    
                                // acc = [select id, Territory_Lookup__r.id,(select id from Business_Plans__r where Year__c =: OppId.Year__c limit 1)  from account where Territory_Lookup__r.name =: OppId.commercialunit__C and account.recordtype.developername =:label.Planning_Account limit 1];
                                try{
                                acc = [select id, Territory_Lookup__r.id  from account where Territory_Lookup__r.name =: OppId.commercialunit__C and Territory_Lookup__r.TerritoryLevel__c = 'L1:Commercial unit' and account.recordtype.developername =:label.Planning_Account limit 1];
                                system.debug('recType...:'+recType);
                                }catch(exception e){
                                 acc = null;
                                 }  
                                if(acc != null){
                                    try{
                                    bp = [select id from Business_Plan__c where Year__c =: OppId.Year__c and account__C =: acc.id limit 1];
                                    }catch(exception e){
                                        bp = null;
                                     }  
                                    if(bp==null){
                                        bp =  CreatebpPlan(acc.id,oppid.year__c,bpRecordTypeId);
                                    }
                                    
                                      opp = createopp(acc.id,bp,OppId,bpRecordTypeId,recordTypeId,null,null,null,null); 
                                }
                            }     
                            if(oppid.product_type__C == 'CP'){
                                recordTypeId = oppRecordtypes.get(label.DistributorCPSalesPlan);
                            }
                            else{
                                recordTypeId = oppRecordtypes.get(label.Distributor_Seeds_Sales_Plan);
                            }
                            bpRecordTypeId = bpRecordtypes.get(label.Distributor_Business_Plan);
                            try{
                            bp = [select id from Business_Plan__c where Year__c =: OppId.Year__c and Account__c =:oppid.RelatedDistributor__c limit 1];
                            }catch(exception e){
                             bp = null;
                            } 
                            if(bp==null){
                                bp =  CreatebpPlan(oppid.RelatedDistributor__c,oppid.year__c,bpRecordTypeId);     
                            }
                            Opportunity oppt = createopp(oppid.RelatedDistributor__c,bp,OppId,bpRecordTypeId,recordTypeId,null,opp,null,null);
                            OppId.RelatedDistributorPlan__c = oppt.id;
                            system.debug(' OppId.RelatedDistributorPlan__c....:'+ OppId.RelatedDistributorPlan__c);
                        }
                        else{
                            OppId.RelatedDistributorPlan__c = opptlist.id;
                            system.debug('oppId....:'+oppId);
                        }
                    //}
                    Opportunity teropp;
                    Opportunity disopp;
                    try{
                    teropp= [Select id,commercialunit__c,accountid from opportunity where territory__C =: oppid.territory__c and account.Territory_Lookup__r.TerritoryLevel__c = 'L3:Territory' and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c and account.recordtype.developername =:label.Planning_Account and (recordtype.developername =: label.Territory_Sales_Plan or recordtype.developername =: label.Territory_Seeds_Sales_Plan) limit 1];
                    }catch(exception e){
                    teropp = null;
                   }  
                    system.debug('oppid.Account.Territory_Lookup__c---:'+oppid.Account.Territory_Lookup__c);
                    Territory__C    dist;   
                    Account_territory__C acct;
                    if(teropp==null){
                        try{
                            system.debug('oppid.Territory__c....'+oppid.Territory__c);
                        dist = [select id, District__c, district__r.Assigned_Rep__c from Territory__c where id =: oppid.Territory__c limit 1];
                        disopp = [Select id,commercialunit__c,accountid from opportunity where Account_Territory__r.Territory__c =: dist.District__c and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c limit 1] ;//and account__r.Territory_Lookup__r.TerritoryLevel__c = 'L2:District' and year__c =:oppid.year__C and product_type__C =: oppid.Product_Type__c and account.recordtype.developername =:label.Planning_Account]; 
                        }catch(exception e){
                          if(dist==null){
                            dist = null;
                            disopp=null;
                          }
                          else{
                            disopp=null;
                          }
                         }  
                        if(disopp == null)  {
                            if(oppid.product_type__C == 'CP'){
                                recordTypeId = oppRecordtypes.get(label.District_Sales_Plan);    
                            }
                            else{
                                recordTypeId = oppRecordtypes.get(label.District_Seeds_Sales_Plan);    
                            }
                            bpRecordTypeId = bpRecordtypes.get(label.District_Business_Plan);
                            
                            try{
                            acct = [select id, account__c from account_territory__C where Territory__c =: dist.District__c and Territory__r.TerritoryLevel__c = 'L2:District' and Account__r.recordtype.developername =:label.Planning_Account limit 1];
                            }catch(exception e){
                              acct = null;
                             }  
                            if(acct!=null){
                                try{
                                bp = [select id from Business_Plan__c where Year__c =: OppId.Year__c and Account__c =:acct.account__c limit 1];
                                }catch(exception e){
                                 bp = null;
                                }  
                                if(bp==null){
                                    bp =  CreatebpPlan(acct.account__c,oppid.year__c,bpRecordTypeId);
                                }
                                 disopp = createopp(Acct.account__c,bp,OppId,bpRecordTypeId,recordTypeId,null,null,dist,null) ;
                            }
                        }
                                if(oppid.product_type__C == 'CP'){
                                    recordTypeId = oppRecordtypes.get(label.Territory_Sales_Plan);
                                }
                                else{
                                    recordTypeId = oppRecordtypes.get(label.Territory_Seeds_Sales_Plan);
                                }
                                bpRecordTypeId = bpRecordtypes.get(label.Territory_Business_Plan);
                                 try{
                            acct = [select id, account__c from account_territory__C where Territory__c =: OppId.Territory__c and Territory__r.TerritoryLevel__c = 'L3:Territory' and Account__r.recordtype.developername =:label.Planning_Account limit 1];
                            }catch(exception e){
                              acct = null;
                             }  
                            if(acct!=null){
                                try{
                                bp = [select id from Business_Plan__c where Year__c =: OppId.Year__c and Account__c =:acct.account__c limit 1];
                                }catch(exception e){
                                 bp = null;
                                }  
                                if(bp==null){
                                    bp =  CreatebpPlan(acct.account__c,oppid.year__c,bpRecordTypeId);
                                }
                                Opportunity retopp =  createopp(Acct.account__c,bp,OppId,bpRecordTypeId,recordTypeId,disopp,null,null,null);
                                OppId.RelatedTerritoryPlan__c = retopp.id;
                            //}
                            }
                        
                    }
                    else{
                        OppId.RelatedTerritoryPlan__c = teropp.id;
                    }
                   }
                    system.debug('OppId.RelatedTerritoryPlan__c....:'+OppId.RelatedTerritoryPlan__c);
                    system.debug('oppidRelatedDistributorPlan__c....:'+oppid.RelatedDistributorPlan__c);
                    system.debug('OppId.RelHeadOfficePlan__c....:'+OppId.RelHeadOfficePlan__c);
                    UpdateASPRelatedPlan(Oppid.id,OppId.RelatedTerritoryPlan__c,oppid.RelatedDistributorPlan__c,OppId.RelHeadOfficePlan__c);
                }
            }
          
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('opportunity','NA','ToUpdateRelatedPlan','ASPRelatedPlan','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        } 
        
    }
    /********************************************************************************************
* Method     :  UpdateASPRelatedPlan
* Description:  To update related plan in future method since it is excecuted from trigger
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
*18-Jan-2018    HLT      Created
********************************************************************************************/    
    @future 
    public static void UpdateASPRelatedPlan(Id oppId,Id rtpId, Id rdpId, Id rhpId ){ 
        
        Try{
            Opportunity Opp = [select RelatedTerritoryPlan__c,RelatedDistributorPlan__c,RelHeadOfficePlan__c from opportunity where id =: oppId limit 1];
            Opp.RelatedTerritoryPlan__c = rtpid;
            if(rhpId == null){
                Opp.RelatedDistributorPlan__c = rdpid;
            }
            else{
                Opp.RelHeadOfficePlan__c = rhpid;   
            }
            system.debug('opp...'+opp);
            update Opp;
        }catch(Exception e){
            Exception_Log__c exceptionLogRecord = ExceptionLogHelperClass.createExceptionLogRecord('opportunity','NA','ToUpdateRelatedPlan','UpdateASPRelatedPlan','Technical exception',UserInfo.getUserId(),e.getStackTraceString(),e.getMessage());
            insert exceptionLogRecord;
        } 
    } 
    /********************************************************************************************
* Method     :  createopp
* Description:  To update related plan by creating the opportunity
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
*19-Jan-2018    HLT      Created
********************************************************************************************/    
    public static Opportunity createopp(Id accid,Business_plan__c bpr,Opportunity OppId,Id bpRecordTypeId,Id recordTypeId,Opportunity disOpp,Opportunity cuopp,territory__c dist, Id relatedDistributor){
        Account_Territory__c actTerritory = new Account_Territory__c();
        Acc = [select id, ownerid,Territory_Lookup__c from account where id =: accid];
        RecordType rt;
        rt = [select id,developername from RecordType where id =: recordTypeId limit 1];
        Opportunity oppt = new Opportunity();
        oppt.accountid = accid;
        oppt.Product_Type__c = Oppid.Product_Type__c;
        oppt.StageName = label.Opportunity_Stage;
        oppt.CloseDate = Date.newInstance(Integer.valueOf(oppid.Year__c), 12, 31);
        oppt.recordTypeId = recordTypeId;
        oppt.year__c = oppid.year__c;
        oppt.AccountBusinessPlan__c = bpr.id;
        oppt.Territory__c = Acc.Territory_Lookup__c;
        //oppt.Territory__c = Oppid.Territory__c;
        //if(rt.DeveloperName.contains('CU') ){
        oppt.Territory__c = Acc.Territory_Lookup__c;    
        //}
        oppt.name = label.Opportunity_Name;
        oppt.Probability = 100;
        Oppt.OwnerId =  acc.ownerid;   
        if(Oppid.product_type__C == 'CP'){
            oppt.Pricebook2Id =  Label.CP_Price_Book;   
        }
        else{
            oppt.Pricebook2Id =  Label.Seeds_Price_Book;   
        }
        try{
              actTerritory = [Select id From Account_Territory__c
                              WHERE Territory__c =: Acc.Territory_Lookup__c  AND Account__c =:accid limit 1];    
                }Catch(Exception e){
                    oppt.Account_Territory__c = null;
                }
                if(actTerritory != null){
                    oppt.Account_Territory__c = actTerritory.Id;
                }
        if(disOpp!=null){
            Oppt.RelatedTerritoryPlan__c = disOpp.id;
        }
        if(dist!=null){
            Oppt.District__c = dist.district__C;
            //Oppt.OwnerId = dist.district__r.Assigned_Rep__c;
            /* try{
              actTerritory = [Select id From Account_Territory__c
                              WHERE Territory__c =: dist.district__C  AND Account__c =:accid limit 1];    
                }Catch(Exception e){
                    oppt.Account_Territory__c = null;
                }
                if(actTerritory != null){
                    oppt.Account_Territory__c = actTerritory.Id;
                }*/
        }
        if(cuopp!=null){
            Oppt.RelatedCUPlan__c = cuopp.id;
        }
        if(relatedDistributor != null){
            Oppt.RelatedDistributor__c = relatedDistributor;
        }    
        if(Oppt!=null){
            insert oppt; 
        }
        return oppt; 
    }
    /********************************************************************************************
* Method     :  CreatebpPlan
* Description:  To update related plan by creating the Business Plan
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
*20-Jan-2018    HLT      Created
********************************************************************************************/    
    public Static Business_plan__c CreatebpPlan(Id accid,String year,Id bpRecordTypeId){
        Acc = [select id, ownerid,Territory_Lookup__c from account where id =: accid];
        Business_Plan__c bp = new Business_Plan__c();
        bp.Account__c = accid;
        bp.Year__c = year;
        bp.name = label.Business_Plan_Name;
        bp.RecordTypeid = bpRecordTypeId;
        bp.OwnerId =  acc.ownerid;
        if(bp!=null){
            insert bp;
        }
        return bp;
    }  
}