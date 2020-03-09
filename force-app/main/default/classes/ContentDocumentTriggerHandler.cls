/**
*   @Author:    Usman Ali (Magnet 360 )
*   @Date:      05.10.2017
*   @Jira:      MSP-1355
*   @Purpose:   Update file count on Parent objects (Program , Seed Booking) whenever a file is Deleted . 
*   
*   @Updates:   06/29/2017
*               Usman Ali (Magnet 360)
*               Modified code to file count for Case and Settlement Object too   
*   @Updates:   11/26/2019
*               Jim Buchan
*               Modified code to file count for Stewardship Agreements 
*/

public without sharing class ContentDocumentTriggerHandler 
{
    /**
    *   @Method:    updateCount()
    *   @Purpose:   Update file count on Parent objects (Program , Seed Booking) whenever a file is Deleted. 
    *   @Param:     List<ContentDocumentLink> links : List of new records - Trigger.new
    *   @Return:    void : No return value
    *   @Author:    Usman Ali (Magnet360)
    *   @Date:      05/10/2017
    *
    *   @Updates: 
    */

    public static void updateFileCount(List<ContentDocument> documents) 
    {
        Set<Id> deletedDocLinksParentIds = new Set<Id>();
        Set<Id> documentIds = new Set<Id>();
        Map<Id, Integer> parentCountMap = new Map<Id, Integer>();
        List<Programs__c> programsToUpdate  = new List<Programs__c>();
        List<CA_Seed_Booking__c> seedBookingsToUpdate  = new List<CA_Seed_Booking__c>();
        List<Case> casesToUpdate = new List<Case>();
        List<Stewardship_Agreements__c> StewardshipsToUpdate = new List<Stewardship_Agreements__c>();
        List<Settlement__c> settlementsToUpdate = new List<Settlement__c>();

        // Get Both objects Prefix
        String programPrefix = Programs__c.SObjecttype.getDescribe().getKeyPrefix();
        String seedBookingPrefix = CA_Seed_Booking__c.SObjecttype.getDescribe().getKeyPrefix();
        String casePrefix = Case.SObjecttype.getDescribe().getKeyPrefix();
        String StewardshipPrefix = Stewardship_Agreements__c.SObjecttype.getDescribe().getKeyPrefix();
        String settlementPrefix = Settlement__c.SObjecttype.getDescribe().getKeyPrefix();

        // Get Deletd Content Document Ids 
        for( ContentDocument cd : documents )
        {
            documentIds.add(cd.Id);
        }
        System.debug('UAC: documentIds ' + documentIds );


        // Get ParentIds of Deleted ContentDocument records 
        for(ContentDocumentLink cdl : [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId IN :documentIds ])
        {
            String parentId = String.valueOf(cdl.LinkedEntityId);
            
            // Check that if record is deleted from Program or SeedBooking 
            if(parentId != null && (parentId.startsWith(programPrefix) || parentId.startsWith(seedBookingPrefix) || parentId.startsWith(casePrefix) ||  parentId.startsWith(StewardshipPrefix) || parentId.startsWith(settlementPrefix) ) )
            {
                deletedDocLinksParentIds.add(parentId);
                parentCountMap.put(parentId, 0);
            }
        }

        // No need to process further if no record found
        System.debug('UAC: deletedDocLinksParentIds ' + deletedDocLinksParentIds );
        if(deletedDocLinksParentIds.size() == 0 ) return ;

        // Get Aggregate result under ParentIds and other than deleted ContentDocument Ids 
        for(AggregateResult ar : [  SELECT Count(Id)total, LinkedEntityId FROM ContentDocumentLink 
                                    WHERE LinkedEntityId IN :deletedDocLinksParentIds AND ContentDocumentId NOT IN :documentIds
                                    GROUP BY LinkedEntityId ])
        {
            parentCountMap.put((Id)ar.get('LinkedEntityId'), (Integer)ar.get('total'));
        }
        System.debug('UAC: parentCountMap ' + parentCountMap );

        // Iterate over parentIds 
        for(String parentId : deletedDocLinksParentIds )
        {
            // Check prefix and create respective record to update 
            if( parentId.startsWith(programPrefix)) programsToUpdate.add(new Programs__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(seedBookingPrefix)) seedBookingsToUpdate.add(new CA_Seed_Booking__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(casePrefix)) casesToUpdate.add(new Case(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(StewardshipPrefix)) StewardshipsToUpdate.add(new Stewardship_Agreements__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
            if( parentId.startsWith(settlementPrefix)) settlementsToUpdate.add(new Settlement__c(Id=parentId, File_Count__c = parentCountMap.get(parentId)));
        }
        
        // Update records 
        if(programsToUpdate.size() > 0 ) update programsToUpdate;
        if(seedBookingsToUpdate.size() > 0 ) update seedBookingsToUpdate;
        if(casesToUpdate.size() > 0 ) update casesToUpdate;
        if(StewardshipsToUpdate.size() > 0 ) update StewardshipsToUpdate;
        if(settlementsToUpdate.size() > 0 ) update settlementsToUpdate;

    }
}