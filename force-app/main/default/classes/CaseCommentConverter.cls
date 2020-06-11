public class CaseCommentConverter {
	
    public static void convertComments_all(){
        List<CaseComment> newComments = [Select Id, ParentId from CaseComment where not (CommentBody like '~~~%')];
        List<Id> caseIDs = new List<Id>();
        for (CaseComment cc : newComments){
            caseIDs.add(cc.ParentId);
        }
        System.debug('Processing all Comments ('+newComments.size()+' records)');
        convertComments(caseIDs);
    }
    
    public static void convertComments(Id[] caseIds){
        Integer batchsize = 200;
        Map<id,CaseComment> commentMap;
        if (caseIds==null){
            return;
        }else{
            commentMap = new Map<Id,CaseComment>([Select Id, ParentId, CreatedBy.Name, CreatedDate, CommentBody 
                                                  from CaseComment where ParentId in :caseIds
                                                  order by CreatedDate DESC
                                                 ]);
        }
        
        Map<id,Case> caseMap = new Map<Id,Case>([Select Id, Case_Comments__c 
                                                 from Case where Id in :caseIDs]);
        List<CaseComment> updateList = new List<CaseComment>();
        for (CaseComment cm : commentMap.values()){
            if (cm.CommentBody.startsWith('~~~')){
                continue;
            }
            Case c = caseMap.get(cm.ParentId);
            if (c.Case_Comments__c == null){
                c.Case_Comments__c = '';
            }else{
                c.Case_Comments__c += '\n';
            }
            
            c.Case_Comments__c += '('+cm.CreatedBy.Name+' '+cm.CreatedDate+'): '+cm.CommentBody;
            cm.CommentBody = '~~~'+cm.CommentBody;
            updateList.add(cm);
        }
        
        update caseMap.values();
        System.debug('Updating: '+updateList);

        List<List<CaseComment>> batchlist = new List<List<CaseComment>>();
        for (Integer i=0; i< Math.ceil(updateList.size()/(1.0*batchSize)); i++){
            List<CaseComment> batch = new List<CaseComment>();
            batchlist.add(batch);
            for (Integer k=0; k<batchSize; k++){                
                if (updateList.size()<=(i*batchSize)+k) break;
                batch.add(updateList[(i*batchSize)+k]);
            }
        }
        for (List<CaseComment> batch : batchlist){
            System.debug('Updating batch... '+batch.size()+' records...');

            try{
            	update(batch);
            }catch(DMLException e){
                System.debug(e.getCause());
                System.debug(e.getMessage());
                System.debug(e.getStackTraceString());
                System.debug(e.getTypeName());
                for (Integer err=0; err<e.getNumDml(); err++){
                    System.debug(e.getDmlId(err));
                    System.debug(e.getDmlMessage(err));
                    System.debug(e.getDmlType(err));
                }
            }

/*
            try{
                for (SObject cm : batch){
                    update cm;
                }
            }catch(LimitException e){
                System.debug(e);
            }
*/
        }
    }
}