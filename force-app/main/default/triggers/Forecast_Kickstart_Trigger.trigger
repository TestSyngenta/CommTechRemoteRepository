trigger Forecast_Kickstart_Trigger on Forecast_Kickstart__c (after insert) {

      Forecast_Kickstart_TriggerHandler.createBPandForecast(Trigger.new);
}