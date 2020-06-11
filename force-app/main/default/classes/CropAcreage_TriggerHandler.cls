/* 2015-03-03 Brian Hopkins
 * This class contains functions used by triggers on the Crop Acreage Object.
 * updateMostRecentFlag - updates the "most recent" flag on crop acreages
 *          - takes an Account Map and returns a list of Crop Acreages to update.
 * 
 */
public class CropAcreage_TriggerHandler {
    
    public static void UpdateAcreageBioPotential(Crop_Acreage__c[] newList){
        List<id> AccountIDs = new List<id>();
        List<id> CropIDs = new List<id>();
        for (Crop_Acreage__c ca: newList){
            AccountIDs.add(ca.Account__c);
            CropIDs.add(ca.Crop__c);
        }
        
        Map<id,Account> AccountMap = new Map<Id,Account>([Select id,territory__c from Account where id in :AccountIDs]);
        List<String> TerritoryList = new List<String>();
        
        for (Account a: AccountMap.values()){
            TerritoryList.add(a.territory__c);
        }
        
        List<Crop_BioPotential__c> bpList = [Select id, Crop__c, Territory__c, Value_per_Acre__c from Crop_BioPotential__c where Crop__c in :CropIDs and Territory__c in :TerritoryList];
        Map<String,Crop_BioPotential__c> bpMap = new Map<String,Crop_BioPotential__c>();
        
        for (Crop_BioPotential__c bp : bpList){
            bpMap.put(bp.territory__c+bp.crop__c,bp);
        }
    
        // now re-iterate through the new records and update the values.
        Crop_BioPotential__c crop_bp;
        for (Crop_Acreage__c ca: newList){
            crop_bp = bpMap.get(accountMap.get(ca.Account__c).territory__c+ca.crop__c);
            if (crop_bp <> null && crop_bp.Value_per_Acre__c <> null && ca.Acres__c <> null){
                ca.BioPotential__c = ca.Acres__c * crop_bp.Value_per_Acre__c;
            }else{
                ca.BioPotential__c = 0;
            }
        }
    }
    
    public static List<Crop_Acreage__c> UpdateAcreageMostRecent(Crop_Acreage__c[] newList, Crop_Acreage__c[] oldList){
        List<Id> AccountIDs = new List<Id>();
        // get all the affected accounts
        if (newList <> null){
            for (Crop_Acreage__c c : newList){
                AccountIDs.add(c.Account__c);
            }
        }
        if (oldList <> null){
            for (Crop_Acreage__c c : oldList){
                AccountIDs.add(c.Account__c);
            }
        }
        Map<Id,Account> AccountMap = new Map<Id,Account>([Select Id, Opportunity_Decile__c, Total_Opportunity__c from Account where Id in :AccountIds]);

        // get all the crop_acreage__c records on all associated accounts
        Map<Id,Crop_Acreage__c> AcreageMap2 = new Map<Id,Crop_Acreage__c>([Select Id, Account__c, BioPotential__c, Acres__c, Year__c, Most_Recent__c
                                                                           from Crop_Acreage__c where Account__c in :AccountMap.keySet()]);
        // group the crop acreages together for each related account
        Map<Id,List<Crop_Acreage__c>> RelatedMap2 = new Map<Id,List<Crop_Acreage__c>>();
        for (Crop_Acreage__c c : AcreageMap2.values()){
            if (RelatedMap2.get(c.Account__c)==null){
                RelatedMap2.put(c.Account__c,new List<Crop_Acreage__c>());
            }
            RelatedMap2.get(c.Account__c).add(c);
        }
        
        List<Crop_Acreage__c> UpdateList = new List<Crop_Acreage__c>();
        // update the acreages to reflect the most recent year
        for (Account a : AccountMap.values()){
            if (RelatedMap2.get(a.id) == null){
                // the last acreage was deleted
                continue;
            }
            Integer maxYear = 0;
            // determine the most recent year
            for (Crop_Acreage__c c : RelatedMap2.get(a.id)){
                if (maxYear < Integer.valueOf(c.Year__c)){
                    maxYear = Integer.valueOf(c.Year__c);
                }
            }
            // update the most recent flag on all the acreages under this account.
            for (Crop_Acreage__c c : RelatedMap2.get(a.id)){
                if (Integer.valueOf(c.Year__c) == maxYear && c.Most_Recent__c == false){
                    c.Most_Recent__c = true;
                    UpdateList.add(c);
                }else if (Integer.valueOf(c.Year__c) <> maxYear && c.Most_Recent__c == true){
                    c.Most_Recent__c = false;
                    UpdateList.add(c);
                }
            }
        }
        
        return UpdateList;
    }

    public static List<Account> UpdateAccountBiopotentialDecile(Crop_Acreage__c[] newList, Crop_Acreage__c[] oldList){
        List<Id> AccountIDs = new List<Id>();
        // get all the affected accounts
        if (newList <> null){
            for (Crop_Acreage__c c : newList){
                AccountIDs.add(c.Account__c);
            }
        }
        if (oldList <> null){
            for (Crop_Acreage__c c : oldList){
                AccountIDs.add(c.Account__c);
            }
        }
        Map<Id,Account> AccountMap = new Map<Id,Account>([Select Id, Opportunity_Decile__c, Total_Opportunity__c, Most_Recent_Acreage__c from Account 
                                                          where Id in :AccountIds]);
        
        // now get all the MOST RECENT Crop_Acreage__c records for all affected accounts (more than just what changed)
        Map<Id,Crop_Acreage__c> AcreageMap = new Map<Id,Crop_Acreage__c>([Select Id, Account__c, BioPotential__c, Acres__c, Year__c from Crop_Acreage__c 
                                                                          where Account__c in :AccountMap.keySet() and Most_Recent__c = true]);
    
        // group the crop acreages together for each related account
        Map<Id,List<Crop_Acreage__c>> RelatedMap = new Map<Id,List<Crop_Acreage__c>>();
        for (Crop_Acreage__c c : AcreageMap.values()){
            if (RelatedMap.get(c.Account__c)==null){
                RelatedMap.put(c.Account__c,new List<Crop_Acreage__c>());
            }
            RelatedMap.get(c.Account__c).add(c);
        }
        
        // get all the segmentation (decile) bands
        List<Value_Segmentation__c> DecileList = [Select Id, label__c, min_value__c, max_value__c from Value_Segmentation__c where type__c like 'decile'];
        
        // for each affected account, recalculate the total Bio Potential (total Opportunity)
        List<Account> AccountUpdateList = new List<Account>();
        for (Account a : AccountMap.values()){
            Double totalOpp = 0.0;
            String newDecile = null;
            Integer maxYear = 0;
            if (RelatedMap.get(a.id) <> null){
                for (Crop_Acreage__c c : RelatedMap.get(a.id)){
                    totalOpp += c.BioPotential__c;
                    if (maxYear < Integer.valueOf(c.Year__c)){
                        maxYear = Integer.valueOf(c.Year__c);
                    }
                }
            }
            
            // determine the new decile if applicable
            for (Value_Segmentation__c s : DecileList){
                if (totalOpp <= s.max_value__c && totalOpp > s.min_value__c){
                    newDecile = s.label__c;
                    break;
                }
            }
            // update the account values if they have changed
            if (a.Total_Opportunity__c <> totalOpp || a.Opportunity_Decile__c <> newDecile || 
                a.Most_Recent_Acreage__c==null || Integer.valueOf(a.Most_Recent_Acreage__c) <> maxYear) {
                a.Total_Opportunity__c = totalOpp;
                a.Opportunity_Decile__c = newDecile;
                a.Most_Recent_Acreage__c = (String.valueOf(maxYear)).replace(',','');
                AccountUpdateList.add(a);
            }
        }
        return AccountUpdateList;
    }


    public static void checkDeletionPrevilages(List<Crop_Acreage__c> crops ) 
    {
        Crop_Acreage_Deletion__c setting = Crop_Acreage_Deletion__c.getInstance();
        Set<Id> profileIds = new Set<Id>();
        Set<Id> userIds = new Set<Id>();
        Date validDate = Date.today().addDays( Integer.valueOf(-setting.Days__c));

        List<Id> tempIds = setting.Profiles_IDs__c.split(',');
        profileIds = new Set<Id>(tempIds); 
        tempIds.clear();
        tempIds = setting.User_IDs__c.split(',');
        userIds = new Set<Id>(tempIds) ;

        for(Crop_Acreage__c ca : crops )
        {
            if(  ca.CreatedDate < validDate && !profileIds.contains(UserInfo.getProfileId()) && !userIds.contains(UserInfo.getUserId()) ) ca.addError(setting.Error_Message__c);
        }
    }
}