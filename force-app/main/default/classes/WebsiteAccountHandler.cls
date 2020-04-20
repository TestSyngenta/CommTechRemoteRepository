/*********************************************************************************************
* Apex Class Name    :     WebsiteAccountHandler
* Version            :     1.0
* Created Date       :     06-Jan-2020
* Function           :     This is class is used to deserialize the JSON data coming into website account object on agriclime registration to send out an auto responder through pardot.
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Aakash                    06-Jan-2020            Created
***********************************************************************************************/
public with sharing class WebsiteAccountHandler {
    /********************************************************************************************
* Method   : farmWrapperCalling
* Description: Method to call farm wrapper class to deserialize the JSON data coming into webstie account   
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 06-Jan-2020 Aakash                          Created  
********************************************************************************************/
    
    public static void farmWrapperCalling(Set<id> triggernew){
        FarmWrapper farmtest;
        List<wint__Website_Account__c> tempwebAcc = [SELECT id,wint__Contact__c, wint__Contact2__c, wint__Email__c, wint__Lead__c,wint__Any__c,wint__ReferenceNo__c,wint__FirstName__c,wint__LastName__c,wint__Company__c, wint__Street__c,wint__City__c, wint__Street2__c,wint__PostalCode__c, wint__State__c, wint__FarmName__c  FROM wint__Website_Account__c WHERE id IN :triggernew];      
        for(wint__Website_Account__c w : tempwebAcc){
            if(w.wint__Contact__c != null || w.wint__Lead__c != null ){
                List <Contact> contactId = [SELECT id, AgriclimeProgramDetails__c FROM Contact WHERE id =: w.wint__Contact__c ];
                List<Lead> LeadId = [SELECT id, Name, Email FROM Lead WHERE id =: w.wint__Lead__c ];
                List<Campaign> campaigns = new List<Campaign>();
                List<CampaignMember> members = new List<CampaignMember>();                
                farmtest = (FarmWrapper)JSON.deserialize(w.wint__Any__c, FarmWrapper.class); 
                Map<Id,Contact> conList = new Map<Id,Contact>();
                Map<Id,Lead> leadList = new Map<Id, Lead>();
                Double Area = 0;
                Double potentialCashback = 0;
                Double committedPurchase = 0;                
                for(Contact e: contactId){
                    e.AgriclimeProgramDetails__c = ('');                        
                    campaignMember cm = new CampaignMember(CampaignId  = '7013m0000012aK8', ContactId = e.Id, Status = 'Responded');
                    database.insert (cm,false);
                }                                	               
                for(FarmWrapper.cls_farms fm : farmtest.farms){
                    String farmName = (fm.name !=null ? fm.name : '*No Field Name Specified*'); //fm.name;
                    Integer committedArea = fm.committedArea.intValue();
                    Area += committedArea;
                    String commitedAreaUoM = fm.commitedAreaUoM;                    
                    Decimal CashBack = fm.cashback.setScale(2);
                    potentialCashback += CashBack;
                    String pc = potentialCashback.format();                    
                    String StartPayout = fm.weatherGuarantee;
                    String actualCashbackCurrency = fm.actualCashbackCurrency;
                    double lattitude = (Double)fm.gridCell.location.lat;                    
                    double longitude = (Double)fm.gridCell.location.lng;                   
                    Decimal committedSpend = fm.committedSpend.setScale(2);
                    committedPurchase +=committedSpend;
                    String compspend = committedPurchase.format();
                    String committedSpendCurrency = fm.committedSpendCurrency;
                    List<String> productLabel = new List<String>();
                    List<String> productDetails = new List<String>();
                    String weGuarantee = fm.weatherGuarantee;
                    String threshold = weGuarantee.substringBetween('if the rainfall during the selected guarantee period is below ', 'mm, up to a maximum payout of 30 % of the qualifying AgriClime purchases, if the rainfall is at or below');                   
                    String thresholdCashback = weGuarantee.substringAfter(' up to a maximum payout of 30 % of the qualifying AgriClime purchases, if the rainfall is at or below ');
                    String Prodslabel;
                    String prodsAmount;                   
                    String startPeriods;
                    Integer periodDuration;
                    for(FarmWrapper.cls_purchases purchase : fm.purchases){
                        String prdLabel = purchase.productLabel;
                        Double quantity = purchase.quantity;
                        Decimal amount = purchase.amount;
                        Decimal amts = (amount*quantity).setScale(2);
                        //String amounts = (amount*quantity).format();
                        String amounts = amts.format();						                        
                        String quantityUoM = purchase.quantityUoM;
                        String amountCurrency = purchase.amountCurrency;
                        //String prdDetails = prdLabel +','+' '+ '$'+ amounts +' '+amountCurrency;
                        String prdDetails = prdLabel +','+' '+ '$'+ amounts +' '+amountCurrency;                         
                        productDetails.add(prdDetails);
                    }
                    for(FarmWrapper.cls_riskPeriods Periods : fm.riskPeriods){
                        Date startDate = Periods.start;
                        Integer duration = Periods.duration;
                        periodDuration = duration;
                        Date EndDate = startDate.addDays(duration);                       
                        startPeriods = String.valueOf(startDate).removeEnd('00:00:00');                      
                    }                     
                    for(Contact d : contactId){                         
                        d.AgriclimeRefNumber__c = '<span style="font-size:18px;">Your Program Reference: <strong>' +w.wint__ReferenceNo__c+ '</strong>';
                        d.AgriclimeName__c = '<span style="font-size:18px;">Name: <strong>' +w.wint__FirstName__c + ' ' +w.wint__LastName__c+ '</strong>';
                        d.AgriclimeCompanyName__c = '<span style="font-size:18px;">Company Name: <strong>' +w.wint__Company__c+ '</strong>';
						d.AgriclimeActualCashback__c = '<span style="font-size:18px;"><strong>Potential Cash Back Amount: ' +'$' +pc+' '+'CAD' +'</strong>';                        
                        d.AgriclimeCommittedSpend__c = '<span style="font-size:18px;"><strong>Total Committed Purchases: ' +'$' +compspend+'&nbsp;CAD</strong>';                           
                        d.AgriclimeProgramDetails__c += '<span style="font-size:20px;"><span style="color:#71840a;">Field: <strong>'+farmName+'</strong></span></span><br> <span style="font-size:18px;">Longitude: <strong>'+longitude+'</strong><br> Latitude: <strong>'+lattitude+'</strong><br> &nbsp;<br> <strong>Program&nbsp;Details</strong><br> Risk Period:</span></p> <ul> <li><span style="font-size:18px;">Start date: <strong>'+startPeriods+'</strong>, duration <strong>'+periodDuration+ '&nbsp;days</strong></span></li> </ul> <span style="font-size:18px;">Weather Guarantee:</span> <ul> <li><span style="font-size:18px;"><strong>Rainfall Threshold:'+' '+threshold+' &nbsp;mm</strong></span></li> <li><span style="font-size:18px;"><strong>Rainfall Threshold Exit (30% Cash-Back):'+' '+thresholdCashback+'</strong></span></li> </ul> <span style="font-size:18px;">Committed Area:</span><ul> <li><span style="font-size:18px;"><strong>'+String.valueOf(committedArea)+ '&nbsp;Acres</strong></span></ul></li><span style="font-size:18px;">Committed&nbsp;Product&nbsp;Details<span style="font-size:18px;"><ul> <strong>';                                                
                        d.AgriclimeStatus__c = 'Unsend';
                        d.AgriclimeCommittedArea__c = '<span style="font-size:18px;"><strong>Total Committed Area: ' +Area+ '&nbsp;Acres</strong><br>';                        
                        for(String p: productDetails){
                            d.AgriclimeProgramDetails__c +='<li>'+p+'<span style="font-size:18px;">';
                            d.AgriclimeProgramDetails__c +='<br>';
                        }                         
                        d.AgriclimeProgramDetails__c +='</strong></span></li> </ul> <p><span style="font-size:18px;"><strong></strong><br></span>';                        
                        conList.put(d.Id,d);                          
                    } 
                    //if(Trigger.isinsert){
                    
                //}   
                    update conList.values();
                    //update leadList.values();                     
                }  
                for(Lead ld : LeadId){
                    if(w.wint__Email__c != null){
                        Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
                        list<String> toAddresses = new List<String>{'cic.canada@syngenta.com'};
                        singleMail.setToAddresses(toAddresses);
                        singleMail.setSubject('Lead needs to be converted for :'+' ' +ld.Name);
                        singleMail.setPlainTextBody('Please convert this lead to send out registration email to: ' +'<a href=' +System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+ld.Id+' >'+ ld.Name+'</a> <br/>' + '<br>' + 'Email  address:</b>' +' '+ ld.Email);
                        //singleMail.setHtmlBody('Please convert this lead to send out registration email to: <b> ' +ld.Name + '<br>' + 'Email  address:</b>' + ld.Email);
                        singleMail.setHtmlBody('Please convert this lead to send out registration email to: <b> ' +'<a href=' +System.URL.getSalesforceBaseUrl().toExternalForm()+'/'+ld.Id+' >'+ ld.Name+'</a> <br/>' + '<br>' + 'Email  address :</b>' +' '+ ld.Email);
                        Messaging.sendEMail(new Messaging.SingleEmailMessage[]{singleMail});
                        //system.debug('lead is' +ld);

                    }

                }   
                
            } 
            
        }                         
    }      
}