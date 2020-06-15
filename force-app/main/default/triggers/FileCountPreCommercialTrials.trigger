trigger FileCountPreCommercialTrials on ContentDocumentLink (after insert, after update, after delete, after undelete) {
 /**  Map<Id,List<ContentDocumentLink>> parent = new Map<Id,List<ContentDocumentLink>>();
  set<id> attids = new set<id>();
     
   if(Trigger.new<>null){
       for(ContentDocumentLink c:Trigger.new){
           Customer_Experience_Trials__c l;
           if(c.LinkedEntityId != null)
               attids.add(c.LinkedEntityId);
       }
           
   }else if(Trigger.old != null){
       for(ContentDocumentLink c:Trigger.old){
           if(c.LinkedEntityId<>null)
               attids.add(Trigger.oldMap.get(c.id).LinkedEntityId);
       }
   }
   if(attids.size()>0){
       try{
           List<ContentDocumentLink> a = new List<ContentDocumentLink>();
           Map<id,Customer_Experience_Trials__c> testmap = new Map<id,Customer_Experience_Trials__c>([select id,File_Count__c from Customer_Experience_Trials__c where id IN: attids]);
           a = [select id,LinkedEntityId from ContentDocumentLink where LinkedEntityId IN:attids];
           
           for(ContentDocumentLink at: a){
               List<ContentDocumentLink> llist = new List<ContentDocumentLink>();
               if(parent.get(at.LinkedEntityId) == null){
                   llist = new List<ContentDocumentLink>();
                   llist.add(at);
                   parent.put(at.LinkedEntityId,llist);
               }else if(parent.get(at.LinkedEntityId) != null){
                   llist = new List<ContentDocumentLink>();
                   llist = parent.get(at.LinkedEntityId);
                   llist.add(at);
                   parent.put(at.LinkedEntityId,llist);
               }
           }
           
           for(Id i: attids){
               if(testmap.get(i) != null && parent.get(i) != null){
                  testmap.get(i).File_Count__c = parent.get(i).size();
               
               }else if(testmap.get(i) != null && parent.get(i) == null){
                  testmap.get(i).File_Count__c = 0;
               }
           }
       
           update testmap.values();
           System.Debug(testmap.values());
       }catch(Exception e){}
    }
**/
}