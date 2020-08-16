global class BatchDelete implements Database.Batchable<sObject>, Database.stateful {
  global List<Contact> globallistofContacts = new List<Contact>();
  global List<Contact> contactstoCheck = new List<Contact>();
  global List<Contact> contactstoDelete = new List<Contact>();
  global List<Contact> contactsToKeep = new List<Contact>();
  global List<Contact> tempcontactsToKeep = new List<Contact>();
  global List<Contact> tempcontactstoDelete = new List<Contact>();
  global Id globalContactId;
  global Contact Cons;
  //global List<Duplicate_Contacts__c> dcList  = new List<Duplicate_Contacts__c>();
  //global Map<Id, List<Contact>> mapofAccountIdwithContacts = new Map<Id, List<Contact>>();

  //global List<Contact> listofRelatedContacts = new List<Contact>();

  global Set<Id> AccountIds = new Set<Id>();

  global Database.QueryLocator start(Database.BatchableContext bc) {
    string query = ' SELECT Id, AccountId, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = null ORDER BY FirstName,LastName LIMIT 100';
    return Database.getQueryLocator(query);
  }

  global void execute(Database.BatchableContext BC, List<Contact> listofduplicateContacts) {
    if (listofduplicateContacts <> null) {
      for (Contact c : listofduplicateContacts) {
        AccountIds.add(c.AccountId);
      }
    }
    List<Duplicate_Records__c> dcList = new List<Duplicate_Records__c>();
    List<Contact> UpdatedList = new List<Contact>(); 
    for (Id loopId : AccountIds) {
      List<Contact> listofRelatedContacts = [
        SELECT Id, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone
        FROM Contact
        WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = NULL AND Has_NPS__c = FALSE AND Has_Related_Case__c = FALSE AND Has_Email_Retention__c  = FALSE AND Is_Campaign_Member__c = FALSE AND AccountId = :loopId ORDER BY FirstName, LastName,Primary_Contact__c ASC
      ];

      //System.debug('Test first Contact in the loop' + listofRelatedContacts);

      String lastFirstName = '';
      String lastLastName = '';
      String tempPhone = '';
      for (Contact AccContact : listofRelatedContacts) {
        /**if(contactstoDelete.size() > 1){
          contactstoDelete.clear();
        }
        **/
        
        //tempPhone = AccContact.Phone;
        
        if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName) {
          contactstoCheck.add(AccContact);
         
          




          //contactstoCheck.add(listofRelatedContacts[0]);
          for(Contact loopOverSame : contactstoCheck){
            if(ContactstoCheck.size() == 1 && loopOverSame.Primary_Contact__c == true){
              
              if(loopOverSame.phone == null && tempPhone <> null){
                loopOverSame.phone = tempPhone;

              }

              if(ContactstoDelete.size() > 0 && contactstoDelete[0].FirstName ==loopOverSame.FirstName && contactstoDelete[0].LastName ==loopOverSame.LastName){
                Duplicate_Records__c fr = new Duplicate_Records__c();
                fr.Duplicate_Contacts__c = contactstodelete[0].Id;
                fr.toBeDeleted__c = true;
                Database.insert(fr);
                //contactstoDelete.clear();
              }

              Duplicate_Records__c dr = new Duplicate_Records__c();
              dr.Duplicate_Contacts__c = AccContact.Id;
              Database.insert (dr);
              

            }
          
              //contactstoCheck.clear();
              else if(ContactstoCheck.size() == 2 ){
                    contactstoCheck.clear();
                    //contactstoDelete.clear();
                //Duplicate_Records__c dr = new Duplicate_Records__c();
                //dr.Duplicate_Contacts__c = loopOverSame.Id;
                //dr.toBeDeleted__c = true;            
                //Database.insert (dr);

              }

            
            }  contactstoCheck.clear();
        }
        contactstoDelete.add(AccContact);
        if(contactstoDelete.size() > 1){
          contactstoDelete.clear();
        }

      
          
          /**else {
            contactstoDelete.add(AccContact);
            Duplicate_Records__c fr = new Duplicate_Records__c();
            fr.Duplicate_Contacts__c = contactstodelete[0].Id;
            fr.toBeDeleted__c = true;
            Database.insert(fr);
            contactstoDelete.clear();
          }
          **/
        lastFirstName = AccContact.FirstName;
        lastLastName = AccContact.LastName;
        tempPhone = AccContact.Phone;
        


          /**if(AccContact.Phone == null && tempPhone <> null){
            AccContact.phone = tempPhone;
            UpdatedList.add(AccContact);
          }
          
          Duplicate_Records__c dr = new Duplicate_Records__c();
            dr.Duplicate_Contacts__c = AccContact.Id;
            
            Database.insert (dr);


          System.debug('Check Contacts to check' + contactstoCheck);

          
        }
        else if(AccContact.Primary_Contact__c == false){
          contactstoDelete.add(AccContact);
          tempcontactstoDelete.add(AccContact);
          if(tempcontactstoDelete.size() ==1){
          
          Duplicate_Records__c dr = new Duplicate_Records__c();
          dr.Duplicate_Contacts__c = AccContact.Id;
          dr.toBeDeleted__c = true;            
          Database.insert (dr);
          }
          else if(tempcontactstoDelete.size() >1){
            tempcontactstoDelete.clear();
          }
      }
        lastFirstName = AccContact.FirstName;
        lastLastName = AccContact.LastName;
        tempPhone = AccContact.Phone;
        //if (contactstoCheck.Size() ==1) {
          //contactstoCheck.add(listofRelatedContacts[0]);
       //} 

        

       **/
        } 
        Update(UpdatedList);
  
  
      System.debug('Check Contacts to check' + contactstoCheck.size());
      }
      /**if (contactstoCheck.size() == 2) {
        Boolean executed = false;
        for (Contact contoCheck : contactstoCheck) {
          String tempPhone = '';

          //checks for related record and if there is no rela
          if (!executed && contoCheck.Primary_Contact__c <> true) {
            contactstoDelete.add(contoCheck);

            System.debug('Check Contacts to check' + contactstoDelete);

            Duplicate_Records__c dr = new Duplicate_Records__c();
            dr.Duplicate_Contacts__c = contoCheck.Id;
            dr.toBeDeleted__c = true;
            insert (dr);

            if (contoCheck.phone <> null) {
              tempPhone = contoCheck.phone;
            } else if (contoCheck.phone == null) {
              contoCheck.phone = tempPhone;
            }
            executed = true;
          } else if (executed && contoCheck.Primary_Contact__c == true) {
            Duplicate_Records__c dr = new Duplicate_Records__c();
            dr.Duplicate_Contacts__c = contoCheck.Id;
            insert (dr);
          }
        }
      } **/
    //}

    //delete contactstoDelete;
  }

  global void finish(Database.BatchableContext BC) {
  }
}
