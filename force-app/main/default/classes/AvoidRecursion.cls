/**************************************************************************************
* Apex Class Name  :     AvoidRecursion
* Version            :     1.0
* Created Date       :     16/Feb/2018
* Function           :     To avoid recursion of Trigger
* Modification Log
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Srni                     16/Feb/2018                Created.
* Vijay					   15/Mar/2018				  Modified
*************************************************************************************/
public Class AvoidRecursion{
    private static boolean firstRun = true;
    private static boolean updateplndstockfirstRun = true;
    private static boolean updatePreviousUnitsFirstRun = true;
    private static boolean batchFirstRun = true;
    public static boolean isFirstRun(){
    if(firstRun){
      firstRun = false;
      return true;
    }else{
        return firstRun;
    }
    }
    public static boolean isUpdatePreviousUnitsFirstRun(){
    if(updatePreviousUnitsFirstRun){
      updatePreviousUnitsFirstRun = false;
      return true;
    }else{
        return updatePreviousUnitsFirstRun;
    }
    }
    public static boolean isupdateplndstockfirstRun(){
    if(updateplndstockfirstRun){
      updateplndstockfirstRun = false;
      return true;
    }else{
        return updateplndstockfirstRun;
    }
    }
    public static boolean isbatchfirstRun(){
    if(batchFirstRun){
      batchFirstRun = false;
      return true;
    }else{
        return batchFirstRun;
    }
    }
    
}