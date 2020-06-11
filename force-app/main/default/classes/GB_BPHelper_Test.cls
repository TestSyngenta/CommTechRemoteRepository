@isTest

public class GB_BPHelper_Test {
    public static testmethod void testGridbuddy() {
        
        Gridbuddy_Visibility__c gv = new GridBuddy_Visibility__c();
        gv.Country__c = 'CA';
        gv.IsActive__c = true;
        gv.Object__c = 'Account';
        gv.Record_Type__c = 'Default';
        gv.Tab_One_Label_Type__c = 'Object';
        gv.Tab_One_Label_Source__c = 'Account';
        gv.Tab_One_Page__c = 'GBEmbed_Template';
        gv.Tab_One_Field__c = 'Id';
        gv.Tab_One_Relation__c = 'Id';
        gv.Tab_Two_Visible__c = true;
        gv.Tab_Two_Label_Type__c = 'Object';
        gv.Tab_Two_Label_Source__c = 'Account';
        gv.Tab_Two_Page__c = 'GBEmbed_Template';
        gv.Tab_Two_Field__c = 'Id';
        gv.Tab_Two_Relation__c = 'Id';
        gv.Tab_Three_Visible__c = true;
        gv.Tab_Three_Label_Type__c = 'Object';
        gv.Tab_Three_Label_Source__c = 'Account';
        gv.Tab_Three_Page__c = 'GBEmbed_Template';
        gv.Tab_Three_Field__c = 'Id';
        gv.Tab_Three_Relation__c = 'Id';
        gv.Tab_Four_Visible__c = true;
        gv.Tab_Four_Label_Type__c = 'Object';
        gv.Tab_Four_Label_Source__c = 'Account';
        gv.Tab_Four_Page__c = 'GBEmbed_Template';
        gv.Tab_Four_Field__c = 'Id';
        gv.Tab_Four_Relation__c = 'Id';
        gv.Tab_Five_Visible__c = true;
        gv.Tab_Five_Label_Type__c = 'Object';
        gv.Tab_Five_Label_Source__c = 'Account';
        gv.Tab_Five_Page__c = 'GBEmbed_Template';
        gv.Tab_Five_Field__c = 'Id';
        gv.Tab_Five_Relation__c = 'Id';
        gv.Tab_Six_Visible__c = true;
        gv.Tab_Six_Label_Type__c = 'Object';
        gv.Tab_Six_Label_Source__c = 'Account';
        gv.Tab_Six_Page__c = 'GBEmbed_Template';
        gv.Tab_Six_Field__c = 'Id';
        gv.Tab_Six_Relation__c = 'Id';
        gv.Tab_Seven_Visible__c = true;
        gv.Tab_Seven_Label_Type__c = 'Object';
        gv.Tab_Seven_Label_Source__c = 'Account';
        gv.Tab_Seven_Page__c = 'GBEmbed_Template';
        gv.Tab_Seven_Field__c = 'Id';
        gv.Tab_Seven_Relation__c = 'Id';
        gv.Tab_Eight_Visible__c = true;
        gv.Tab_Eight_Label_Type__c = 'Object';
        gv.Tab_Eight_Label_Source__c = 'Account';
        gv.Tab_Eight_Page__c = 'GBEmbed_Template';
        gv.Tab_Eight_Field__c = 'Id';
        gv.Tab_Eight_Relation__c = 'Id';
        gv.Tab_Nine_Visible__c = true;
        gv.Tab_Nine_Label_Type__c = 'Object';
        gv.Tab_Nine_Label_Source__c = 'Account';
        gv.Tab_Nine_Page__c = 'GBEmbed_Template';
        gv.Tab_Nine_Field__c = 'Id';
        gv.Tab_Nine_Relation__c = 'Id';
        gv.Tab_Ten_Visible__c = true;
        gv.Tab_Ten_Label_Type__c = 'Object';
        gv.Tab_Ten_Label_Source__c = 'Account';
        gv.Tab_Ten_Page__c = 'GBEmbed_Template';
        gv.Tab_Ten_Field__c = 'Id';
        gv.Tab_Ten_Relation__c = 'Id';
        gv.Tab_Eleven_Visible__c = true;
        gv.Tab_Eleven_Label_Type__c = 'Object';
        gv.Tab_Eleven_Label_Source__c = 'Account';
        gv.Tab_Eleven_Page__c = 'GBEmbed_Template';
        gv.Tab_Eleven_Field__c = 'Id';
        gv.Tab_Eleven_Relation__c = 'Id';
        gv.Tab_Twelve_Visible__c = true;
        gv.Tab_Twelve_Label_Type__c = 'Object';
        gv.Tab_Twelve_Label_Source__c = 'Account';
        gv.Tab_Twelve_Page__c = 'GBEmbed_Template';
        gv.Tab_Twelve_Field__c = 'Id';
        gv.Tab_Twelve_Relation__c = 'Id';
        gv.Tab_Thirteen_Visible__c = true;
        gv.Tab_Thirteen_Label_Type__c = 'Object';
        gv.Tab_Thirteen_Label_Source__c = 'Account';
        gv.Tab_Thirteen_Page__c = 'GBEmbed_Template';
        gv.Tab_Thirteen_Field__c = 'Id';
        gv.Tab_Thirteen_Relation__c = 'Id';
        gv.Tab_Fourteen_Visible__c = true;
        gv.Tab_Fourteen_Label_Type__c = 'Object';
        gv.Tab_Fourteen_Label_Source__c = 'Account';
        gv.Tab_Fourteen_Page__c = 'GBEmbed_Template';
        gv.Tab_Fourteen_Field__c = 'Id';
        gv.Tab_Fourteen_Relation__c = 'Id';
        gv.Tab_Fifteen_Visible__c = true;
        gv.Tab_Fifteen_Label_Type__c = 'Object';
        gv.Tab_Fifteen_Label_Source__c = 'Account';
        gv.Tab_Fifteen_Page__c = 'GBEmbed_Template';
        gv.Tab_Fifteen_Field__c = 'Id';
        gv.Tab_Fifteen_Relation__c = 'Id';
        gv.Tab_Sixteen_Visible__c = true;
        gv.Tab_Sixteen_Label_Type__c = 'Object';
        gv.Tab_Sixteen_Label_Source__c = 'Account';
        gv.Tab_Sixteen_Page__c = 'GBEmbed_Template';
        gv.Tab_Sixteen_Field__c = 'Id';
        gv.Tab_Sixteen_Relation__c = 'Id';
        //end of addition
        
        insert gv;
        
        Account acc = new Account();
        List<Account> accs = [SELECT Name, Id FROM ACCOUNT Limit 1];
        If (accs.size() > 0) {
            acc = accs[0];
        } else {
            //acc = new Account();
            acc.Name = 'Test';
           /* acc.ShippingStreet = '123456';
            acc.ShippingCity = 'Concord';
            acc.ShippingPostalCode = '28027';
            acc.ShippingCountry = 'Canada';
            acc.ShippingCountryCode = 'CA';
            acc.ShippingState = 'Nova Scotia';
            // acc.Region__c = 'Nova Scotia'; */
            insert acc;
        }
        
               
        Test.starttest();
        ApexPages.StandardController stdAcct = new ApexPages.StandardController(acc);
        GB_BPHelper gb = new GB_BPHelper(stdAcct);
       // gv.Tab_Fifteen_Visible__c = false;
        gv.Tab_One_Label_Type__c = 'Custom Label';
        update gv;
        //gv.Tab_One_Label_Type__c = 'Custom Label';
        //update TabOneLabel;
        //gv.Tab_One_Label_Type__c = 'Explicit Value';
        //update gv;
        delete gv;
        
        Test.stoptest();
    }
     
}