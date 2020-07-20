declare module "@salesforce/apex/campaignCheckInController.insertCampaignMember" {
  export default function insertCampaignMember(param: {campaignId: any, contactId: any, status: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.insertNewLeadCampaignMember" {
  export default function insertNewLeadCampaignMember(param: {campaignId: any, leadId: any, status: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.fetchCampaign" {
  export default function fetchCampaign(param: {Id: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.getCampaignAttendeeCount" {
  export default function getCampaignAttendeeCount(param: {Id: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.searchContactsAndLeads" {
  export default function searchContactsAndLeads(param: {searchword: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.fetchCampaignMembers" {
  export default function fetchCampaignMembers(param: {searchKeyWord: any, ObjectName: any, searchCampaignId: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.fetchCampaigns" {
  export default function fetchCampaigns(param: {searchKeyWord: any, ObjectName: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.updateMemberStatus" {
  export default function updateMemberStatus(param: {memberRecord: any, campaignId: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.updateMemberAction" {
  export default function updateMemberAction(param: {memberRecord: any, campaignId: any, status: any, comments: any, registeredGuest: any, attendingGuest: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.addNewLeadAction" {
  export default function addNewLeadAction(param: {firstName: any, lastName: any, companyName: any, email: any, phone: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.validateContact" {
  export default function validateContact(param: {contactId: any, campaignId: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.validateLead" {
  export default function validateLead(param: {contactId: any, campaignId: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.getContactName" {
  export default function getContactName(param: {contactId: any}): Promise<any>;
}
declare module "@salesforce/apex/campaignCheckInController.getLeadName" {
  export default function getLeadName(param: {leadId: any}): Promise<any>;
}
