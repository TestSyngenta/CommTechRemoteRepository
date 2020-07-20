/********************************************************************************************
* Class:        GridbuddyVisibilityTriggerHandler
* Description:  Handle all actions for Gridbuddy_Visibility__c DML
* ------------------------------------------------------------------------------------------
* Date          Name                    Modification Description
* ------------------------------------------------------------------------------------------
* 02-Mar-2016   Benjamin Ellington      Initial Code
********************************************************************************************/

public class GridbuddyVisibilityTriggerHandler {
 
    /******************** BEFORE ********************/
    // INSERT
    public static void IsBeforeInsert(List<GridBuddy_Visibility__c> lNew, Map<Id,GridBuddy_Visibility__c> mNew){
      removeSpaces(lNew);
    }
    // UPDATE
    public static void IsBeforeUpdate(List<GridBuddy_Visibility__c> lOld, Map<Id,GridBuddy_Visibility__c> mOld, List<GridBuddy_Visibility__c> lNew, Map<Id,GridBuddy_Visibility__c> mNew){
      removeSpaces(lNew);
    }
    // DELETE
    public static void IsBeforeDelete(List<GridBuddy_Visibility__c> lOld, Map<Id,GridBuddy_Visibility__c> mOld){
       
    }
    
    /******************** AFTER *********************/
    // INSERT
    public static void IsAfterInsert(List<GridBuddy_Visibility__c> lNew, Map<Id,GridBuddy_Visibility__c> mNew){
    
    }
    // UPDATE
    public static void IsAfterUpdate(List<GridBuddy_Visibility__c> lOld, Map<Id,GridBuddy_Visibility__c> mOld, List<GridBuddy_Visibility__c> lNew, Map<Id,GridBuddy_Visibility__c> mNew){
    
    }
    // DELETE
    public static void IsAfterDelete(List<GridBuddy_Visibility__c> lOld, Map<Id,GridBuddy_Visibility__c> mOld){
        
    }
    
    // UNDELETE
    public static void IsAfterUndelete(List<GridBuddy_Visibility__c> lNew, Map<Id,GridBuddy_Visibility__c> mNew){
      removeSpaces(lNew);
    }
    
    public static void removeSpaces(list<GridBuddy_Visibility__c> lNew) {
      for (GridBuddy_Visibility__c g : lNew) {
      }
    } 
}