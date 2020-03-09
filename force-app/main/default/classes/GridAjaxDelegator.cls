/**
 * This class is used for custom Ajax requests made from GridBuddy grids
 */ 
public with sharing class GridAjaxDelegator {
    
    public String jsonResponse {get; private set;}
    
    public void processRequest() {
        // determine what the ajax request is for
        String reqType = ApexPages.CurrentPage().getParameters().get('reqType');
        
        if (reqType == 'trackGridView') {
            trackGridView();
        } else if (reqType == 'trackGridSave') {
            trackGridSave();
        } else if (reqType == 'trackGridExport') {
            trackSimpleAction('Grid Export');
        } else if (reqType == 'trackReorderColumns') {
            trackSimpleAction('Reorder/Hide Columns');
        } 
    }
    
    /**
     * Inserts a record in the Click-Through Analytics object (GridBuddy_Usage_Analytics__c) 
     *   the first time a grid has been accessed in the user's session
     */
    public void trackGridView() {         
        String sessionId = UserInfo.getSessionId();
        String gridName = getGridNameParam();
        
        if (gridName != null && gridName.length() > 0) {
        
            List<GridBuddy_Usage_Analytics__c> recordsForSession = [select Id from GridBuddy_Usage_Analytics__c 
                                                            where Session__c = :sessionId 
                                                            and Grid_Name__c = :gridName
                                                            limit 1];
    
            if (recordsForSession.size() == 0) {
                // insert a record for this session
                GridBuddy_Usage_Analytics__c record = new GridBuddy_Usage_Analytics__c(
                    Type__c = 'Grid View',
                    Grid_Name__c = gridName,
                    Session__c = sessionId,
                    User__c = UserInfo.getUserId()
                );
                
                try {
            if(record!=null)
                    insert record;                
                } catch (Exception e) {
                    System.debug('*** GridAjaxDelegator.trackGridView: Failed to insert tracking record: '+e.getMessage()+', '+e);
                }            
            }
        }
        
        // return an empty response
        this.jsonResponse = '{}';
    }
    
    /**
     * Inserts a record in the Click-Through Analytics object (Usage_Analytics__c) 
     *   when the user has saved on the grid
     */
    public void trackGridSave() {
        String gridName = getGridNameParam();
        String fieldAPINames = getFieldAPINamesParam();
                
        // insert a record for the save action
        GridBuddy_Usage_Analytics__c record = new GridBuddy_Usage_Analytics__c(
            Type__c = 'Grid Save',
            Grid_Name__c = gridName,
            Field_API_Names__c = fieldAPINames,
            User__c = UserInfo.getUserId()
        );
        
        try {
           if(record != null)
            insert record;                
        } catch (Exception e) {
            System.debug('*** GridAjaxDelegator.trackGridSave: Failed to insert tracking record: '+e.getMessage()+', '+e);
        }
        
        // return an empty response
        this.jsonResponse = '{}';    
    }  
    
    /**
     * Inserts a record in the Click-Through Analytics object (Usage_Analytics__c) 
     *   when the user clicks a simple grid action, such as Export or Reorder/Hide Columns
     */
    public void trackSimpleAction(String actionType) {
        
        String gridName = getGridNameParam();
        
        // insert a record for the action
        GridBuddy_Usage_Analytics__c record = new GridBuddy_Usage_Analytics__c(
            Type__c = actionType,
            Grid_Name__c = gridName,
            User__c = UserInfo.getUserId()
        );
        
        try {
            if(record!=null)
            insert record;                
        } catch (Exception e) {
            System.debug('*** GridAjaxDelegator.trackSimpleAction: Failed to insert tracking record for actionType ['+actionType+']: '+e.getMessage()+', '+e);
        }
        
        // return an empty response
        this.jsonResponse = '{}';
        
    }       
       
    private String getGridNameParam() {
        return ApexPages.CurrentPage().getParameters().get('gname');    
    }
    
    private String getFieldAPINamesParam() {
        return ApexPages.CurrentPage().getParameters().get('fieldNames');        
    }        

}