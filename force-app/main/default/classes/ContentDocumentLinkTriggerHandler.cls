/**
*   @Author:    Usman Ali (Magnet 360 )
*   @Date:      05.10.2017
*   @Jira:      MSP-1355
*   @Purpose:   Update file count on Parent objects (Program , Seed Booking) whenever a file is uploaded. 
*   
*   @Updates:   06/29/2017
*               Usman Ali (Magnet 360)
*               Modified code to file count for Case and Settlement Object too
*   @Updates:   11/26/2019
*               Jim Buchan
*               Modified code to file count for Stewardship Agreement
*   @Updates:   06/13/2020
*               Jim Buchan
*               Modified code to file count for Commercial Trials and Commercial Experience
*/

public without sharing class ContentDocumentLinkTriggerHandler 
{
    
    /**
    *   @Method:    updateCount()
    *   @Purpose:   Update file count on Parent objects (Program , Seed Booking) whenever a file is uploaded. 
    *   @Param:     List<ContentDocumentLink> links : List of new records - Trigger.new
    *   @Return:    void : No return value
    *   @Author:    Usman Ali (Magnet360)
    *   @Date:      05/10/2017
    *
    */
    public static void updateCount(List<ContentDocumentLink> links ) 
    {
        Set<Id> parentIds = new Set<Id>();
        Map<Id, Integer> parentCountMap = new Map<Id, Integer>();
        List<Programs__c> programsToUpdate  = new List<Programs__c>();
        List<CA_Seed_Booking__c> seedBookingsToUpdate  = new List<CA_Seed_Booking__c>();
        List<Case> casesToUpdate = new List<Case>();
        List<Settlement__c> settlementsToUpdate = new List<Settlement__c>();
        List<Stewardship_Agreements__c> StewardshipToUpdate  = new List<Stewardship_Agreements__c>();
        List<Commercial_Experience_Demos__c> CommercialExperienceToUpdate  = new List<Commercial_Experience_Demos__c>();
        List<Customer_Experience_Trials__c> CommercialTrialsToUpdate  = new List<Customer_Experience_Trials__c>();

        // Get Both objects Prefix
        String programPrefix = Programs__c.SObjecttype.getDescribe().getKeyPrefix();
        String seedBookingPrefix = CA_Seed_Booking__c.SObjecttype.getDescribe().getKeyPrefix();
        String casePrefix = Case.SObjecttype.getDescribe().getKeyPrefix();
        String settlementPrefix = Settlement__c.SObjecttype.getDescribe().getKeyPrefix();
        String StewardshipPrefix = Stewardship_Agreements__c.SObjecttype.getDescribe().getKeyPrefix();
        String CommercialExperiencePrefix = Commercial_Experience_Demos__c.SObjecttype.getDescribe().getKeyPrefix();
        String CommercialTrialsPrefix = Customer_Experience_Trials__c.SObjecttype.getDescribe().getKeyPrefix();

        // Check that if record in inserted under Program or SeedBooking 
        for(ContentDocumentLink cdl : links )    
        {
            String parentId = String.valueOf(cdl.LinkedEntityId);

            // Put Ids into list and in map with default value as zero
            if(parentId != null && (parentId.startsWith(programPrefix) || parentId.startsWith(seedBookingPrefix) || parentId.startsWith(casePrefix) || parentId.startsWith(StewardshipPrefix) || parentId.startsWith(settlementPrefix) || parentId.startsWith(CommercialExperiencePrefix) || parentId.startsWith(CommercialTrialsPrefix) ) )
            {
                parentIds.add(cdl.LinkedEntityId);
                parentCountMap.put(cdl.LinkedEntityId, 0);
            }
        }
        System.debug('UAC: parentIds ' + parentIds );
        if(parentIds.size() == 0 ) return ;

        // Get Aggeragte Result from ContentDocumentLink 
        for(AggregateResult ar : [SELECT Count(Id)total, LinkedEntityId FROM ContentDocumentLink 
                                    WHERE LinkedEntityId IN :parentIds GROUP BY LinkedEntityId ])
        {
            // Put into map count
            parentCountMap.put((Id)ar.get('LinkedEntityId'), (Integer)ar.get('total'));
        }
        System.debug('UAC: parentCountMap ' + parentCountMap );

        // Iterate over parentIds 
        for(String parentId : parentIds )
        {   
            // Check prefix and create respective record to update 
            if( parentId.startsWith(programPrefix)) programsToUpdate.add(new Programs__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(seedBookingPrefix)) seedBookingsToUpdate.add(new CA_Seed_Booking__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(casePrefix)) casesToUpdate.add(new Case(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(StewardshipPrefix)) StewardshipToUpdate.add(new Stewardship_Agreements__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(settlementPrefix)) settlementsToUpdate.add(new Settlement__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(CommercialExperiencePrefix)) CommercialExperienceToUpdate.add(new Commercial_Experience_Demos__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(CommercialTrialsPrefix)) CommercialTrialsToUpdate.add(new Customer_Experience_Trials__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
        }
        
        // Update records 
        if(programsToUpdate.size() > 0 ) update programsToUpdate;
        if(seedBookingsToUpdate.size() > 0 ) update seedBookingsToUpdate;
        if(casesToUpdate.size() > 0 ) update casesToUpdate;
        if(StewardshipToUpdate.size() > 0 ) update StewardshipToUpdate;
        if(settlementsToUpdate.size() > 0 ) update settlementsToUpdate;
        if(CommercialExperienceToUpdate.size() > 0 ) update CommercialExperienceToUpdate;
        if(CommercialTrialsToUpdate.size() > 0 ) update CommercialTrialsToUpdate;
    }
}