trigger CommTech_Projects on CommTech_Project__c (after delete) {

    Messaging.reserveSingleEmailCapacity(trigger.size);
    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
    for (CommTech_Project__c commmTechproject : Trigger.old) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {'shawn.weishar@syngenta.com'});
        email.setSubject('Deleted Project Alert');
        email.setPlainTextBody('This message is to alert you that the project named ' + commmTechproject.Name + ' has been deleted.');
        emails.add(email);
    }
    Messaging.sendEmail(emails);
  
}