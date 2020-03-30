public with sharing class sendDatatoContacts {
    public ApexPages.StandardController programsController;

    public sendDatatoContacts(ApexPages.StandardController programsController){
        this.programsController = programsController;
    }
    public PageReference sendData(){ 
        List<Programs__c> records = [SELECT Id, Contact__c, Risk_Start_Period__c, Actual_Cashback__c, Payout_Status__c, Actual_Rainfall__c, Program_Reference__c, Rainfall_Threshold__c, Rainfall_Exit_Point__c FROM Programs__c WHERE RecordTypeId in (SELECT Id FROM RecordType WHERE Name = 'AgriClime Lentils')];        
        Set<Id> contactIds = new Set<Id>();
        Map<Id,Contact> conList = new Map<Id,Contact>();
       
        for(Programs__c record : records ){
            contactIds.add(record.Contact__c);
        }
        
        List<Contact> contactId = [SELECT id, AgriclimeRefNumber__c, (SELECT Id, Risk_Start_Period__c, Actual_Cashback__c, Payout_Status__c, Actual_Rainfall__c, Program_Reference__c, Rainfall_Threshold__c, Rainfall_Exit_Point__c FROM Programs__r),  Payout_Email_Sent__c, Payout_Details__c, Agriclime_Total_Payout__c FROM Contact WHERE id =: contactIds ];
        for(Contact e : ContactId){
            e.Payout_Details__c = ('');
            e.Agriclime_Total_Payout__c = 0;
        }
        for(Contact con : contactId){
            for(Programs__c onerecord : con.Programs__r ){
                if(onerecord.Actual_Cashback__c != null && (onerecord.Payout_Status__c == 'FINISH_PAYOUT' || con.Programs__r.Size() > 1 )){
                 //con.AgriclimeRefNumber__c = onerecord.Program_Reference__c;
                 //con.Payout_Details__c += '<span style ="font-size:18px;"><strong>Actual Cash Back Amount: ' +'$' +onerecord.Actual_Cashback__c+' '+'CAD' +'</strong>';
                 con.Payout_Details__c+= '<span style="font-size:20px;"><span style="color:#71840a;">Field: <strong>farmName</strong></span></span><br><span style="font-size:18px;">Risk Period Start Date: <strong>'+onerecord.Risk_Start_Period__c+'</strong><br> Rainfall Threshold: <strong>'+onerecord.Rainfall_Threshold__c+'</strong><br>Rainfall Exit Ppoint: <strong>'+onerecord.Rainfall_Exit_Point__c+'</strong><br>Actual Rainfall: <strong>'+onerecord.Actual_Rainfall__c+'</strong><br>Actual Cashback: <strong>'+onerecord.Actual_Cashback__c+'</strong><br>&nbsp;<br>';
                 con.Agriclime_Total_Payout__c +=onerecord.Actual_Cashback__c;
                 CampaignMember qualifiedMember = new CampaignMember(CampaignId  = '70163000000OZFa', ContactId = con.Id, Status = 'Qualified');
                 database.upsert (QualifiedMember,false);
                 
                 System.debug('actual cashback is:' +onerecord.Actual_Cashback__c);
                 
                }
                else if (oneRecord.Actual_Cashback__c == 0 && oneRecord.Payout_Status__c == 'FINISH_NO_PAYOUT') { 
                    //else if (oneRecord.Actual_Cashback__c == 0 ) { 
                    //else{
                        CampaignMember notQualifiedMember = new CampaignMember(CampaignId  = '70163000000OZFa', ContactId = con.Id, Status = 'Not Qualified');
                        database.insert (notQualifiedMember,false);
                    

                }
                con.Payout_Email_Sent__c = false;
        }       
        conList.put(con.Id, con);
        Apexpages.addMessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Payout Details Sent to Contacts Successfully'));     
    }
    Update ConList.values();


    





        /**List<AggregateResult> AggResultList = [Select Contact__c, sum(Actual_Cashback__c)totalCashback from Programs__c where Contact__c in:contactIds group by Contact__c];
        if(AggResultList!= null && AggResultList.size() > 0){ 
            for(AggregateResult agg:AggResultList){ 
                Contact con=new Contact(); 
                con.Id=(id)agg.get('Contact__C'); 
                //con.=(decimal)agg.get('amts'); 
                //updatemap1.put(con.Id, con); 
            } 
        }
        **/

        //Map<id, Contact> mapofContacts = new Map<id, Contact>();
        //Map<Id, List<Programs__c>> mapofPrograms = new Map<Id, List<Programs__c>>();
        
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
     
  
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Records were sent Successfully'));
        return null;
}
  
           
}
            /**  if(programRecord.Contact__c!= null){
                List<Contact> contactId = [SELECT id, AgriclimeRefNumber__c, Payout_Email_Sent__c, Payout_Details__c FROM Contact WHERE id =: programRecord.Contact__c ];
                Map<Id,Contact> conList = new Map<Id,Contact>();
                //List<
                
                for(Contact con : contactId){
                    con.AgriclimeRefNumber__c = programRecord.Program_Reference__c;
                    //totalCashback += Double.Valueof(con.Actual_Cashback__c);
                   //con.Payout_Details__c += String.valueof(totalCashback);

                    conList.put(con.Id, con);
                }
                Update ConList.values();

                

            }
            
            If(mapofPrograms.containsKey(programRecord.Contact__c)){
                mapofPrograms.get(programRecord.Contact__c).add(programRecord);
                
            } 
            System.debug('One Value:' +mapofPrograms.keyset());
            //Update mapofPrograms.values();
        }  

            for(Id idValue : mapofPrograms.keyset())
            {
                for(Programs__c prg : mapofPrograms.get(idValue) ){
                System.debug('One Value:' +idValue);
            }

             List<Contact> contactId = [SELECT id, AgriclimeRefNumber__c, Payout_Email_Sent__c, Payout_Details__c FROM Contact WHERE id =: programRecord.Contact__c ];
            List<Campaign> campaigns = new List<Campaign>();

            Map<Id,Contact> conList = new Map<Id,Contact>();
            
            if(programRecord.contact__c != null && programRecord.Payout_Status__c == 'FINISH_PAYOUT' ){
              
                for(Contact con : contactId){
                    //totalCashback += Double.valueof(programRecord.Actual_Cashback__c);
                    con.AgriclimeRefNumber__c = programRecord.Program_Reference__c;
                    //con.Payout_Details__c += String.valueof(programRecord.Actual_Cashback__c);
                    
                    conList.put(con.Id, con);

                }
                Update ConList.values();
            }**/
        
   
