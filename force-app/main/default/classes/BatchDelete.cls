global class BatchDelete implements Database.Batchable<sObject> {
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
    string query = ' SELECT Id, AccountId, Account.Name, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone FROM Contact WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = null ORDER BY FirstName, LastName, Primary_Contact__c ASC LIMIT 2000';
    return Database.getQueryLocator(query);
  }

  global void execute(Database.BatchableContext BC, List<Contact> listofduplicateContacts) {
    if (listofduplicateContacts <> null) {
      for (Contact c : listofduplicateContacts) {
        AccountIds.add(c.AccountId);
      }
    }
    List<Duplicate_Records__c> setofLeavingRecords = new List<Duplicate_Records__c>();
    List<Duplicate_Records__c> setofToBeDeletedRecords = new List<Duplicate_Records__c>();
    List<Contact> UpdatedList = new List<Contact>(); 
    for (Id loopId : AccountIds) {
      List<Contact> listofRelatedContacts = [
        SELECT Id, AccountId, Account.Name, FirstName, LastName, Primary_Contact__c, Has_NPS__c, Has_Related_Case__c, Has_Email_Retention__c, Is_Campaign_Member__c, phone, MobilePhone
        FROM Contact
        WHERE Duplicate_Contact_On_Same_Account__c = TRUE AND Email = NULL AND Has_NPS__c = FALSE AND Has_Related_Case__c = FALSE AND Has_Email_Retention__c  = FALSE AND Is_Campaign_Member__c = FALSE AND AccountId = :loopId ORDER BY LastName,FirstName,Primary_Contact__c ASC
      ];

      //System.debug('Test first Contact in the loop' + listofRelatedContacts);

      String lastFirstName = '';
      String lastLastName = '';
      String tempPhone = '';
      String tempmobileNumber = '';
      contactstoDelete.clear();
      for (Contact AccContact : listofRelatedContacts) {
        /**if(contactstoDelete.size() > 1){
          contactstoDelete.clear();
        }
        **/
        
        //tempPhone = AccContact.Phone;
        
        if (AccContact.FirstName == lastFirstName && AccContact.LastName == lastLastName && AccContact.Primary_Contact__c == true) {
          contactstoCheck.add(AccContact);
         
          




          //contactstoCheck.add(listofRelatedContacts[0]);
          for(Contact loopOverSame : contactstoCheck){
            if(ContactstoCheck.size() == 1 && loopOverSame.Primary_Contact__c == true && contactstoDelete.size() == 1){
              
              if(loopOverSame.phone == null && tempPhone <> null){
                loopOverSame.phone = tempPhone;
                //UpdatedList.add(loopOverSame);

              }
              else if(loopOverSame.MobilePhone == null && tempmobileNumber <> null){
                loopOverSame.MobilePhone = tempmobileNumber;
                //UpdatedList.add(loopOverSame);
              }

              if(ContactstoDelete.size() >0 && contactstoDelete[0].FirstName ==loopOverSame.FirstName && contactstoDelete[0].LastName ==loopOverSame.LastName){
                Duplicate_Records__c fr = new Duplicate_Records__c();
                //fr.Duplicate_Contacts__c = contactstodelete[0].Id;
                fr.Account_Id__c = contactstodelete[0].AccountId;
                fr.Account_Name__c = contactstodelete[0].Account.Name;
                fr.Contact_Id__c = contactstodelete[0].Id;
                fr.Contact_First_Name__c = contactstoDelete[0].FirstName;
                fr.Contact_Last_Name__c =contactstoDelete[0].LastName;
                fr.Contact_is_Primary__c = false;
                fr.Contact_Phone_Number__c = contactstoDelete[0].Phone;
                fr.Contact_Mobile_Number__c = contactstoDelete[0].MobilePhone;
                fr.Had_Campaign__c = false;
                fr.Had_Email_Retention__c = false;	
                fr.Had_NPS__c = false;
                fr.Had_Related_Case__c = false;
                fr.toBeDeleted__c = true;
                setofToBeDeletedRecords.add(fr);
                //Database.insert(fr);
                //contactstoDelete.clear();
              }

              Duplicate_Records__c dr = new Duplicate_Records__c();
              //dr.Duplicate_Contacts__c = AccContact.Id;
                dr.Account_Id__c = AccContact.AccountId;
                dr.Account_Name__c = AccContact.Account.Name;
                dr.Contact_Id__c = AccContact.Id;
                dr.Contact_First_Name__c = AccContact.FirstName;
                dr.Contact_Last_Name__c =AccContact.LastName;
                dr.Contact_is_Primary__c = true;
                dr.Contact_Phone_Number__c = AccContact.Phone;
                dr.Contact_Mobile_Number__c = AccContact.MobilePhone;
                dr.Had_Campaign__c = false;
                dr.Had_Email_Retention__c = false;	
                dr.Had_NPS__c = false;
                dr.Had_Related_Case__c = false;


              setofLeavingRecords.add(dr);
              //Database.insert (dr);
              //contactstoCheck.clear();
              

            }
            //Insert(setofToBeDeletedRecords);
          
              //contactstoCheck.clear();
              if(ContactstoCheck.size() == 2 ){
                    contactstoCheck.clear();
                    //contactstoDelete.clear();
                //Duplicate_Records__c dr = new Duplicate_Records__c();
                //dr.Duplicate_Contacts__c = loopOverSame.Id;
                //dr.toBeDeleted__c = true;            
                //Database.insert (dr);

              }

            
            } 
             
            contactstoCheck.clear();
            
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
        tempmobileNumber = AccContact.MobilePhone;
        


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
       
  
  
      }
      Database.insert(setofToBeDeletedRecords,false);
      Database.insert(setofLeavingRecords, false);
    //delete contactstoDelete;
  }

  global void finish(Database.BatchableContext BC) {
  }
}
