global class MassUpdater_Async {
    @future
    public static void updateContacts(integer batchsize, integer iterations){
        for (integer n=0; n<iterations; n++){
            integer offset = n*batchsize;
            List<Contact> cList = [Select Id, update_flag__c
                                   from Contact
                                   where update_flag__c = false
                                   limit :batchsize offset :offset ];
            if (cList == null || cList.size() == 0){
                break;
            }
            List<SObject> updateList = new List<SObject>();
            for (Contact c : cList){
                c.update_flag__c = true;
                updateList.add(c);
            }
            
            system.debug('('+n+') Updating '+updateList.size()+' Contacts...');
            system.debug('First Contact ID: '+updateList.get(0).Id);
            
            try{
                update cList;
            }catch(DMLException e){
                system.debug(e);
            }
            
        }
        system.debug('Update Successful!');
    }
}