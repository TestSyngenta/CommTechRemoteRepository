// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class UserChangeEvent {
    global Id Id;
    global String ReplayId;
    global Object ChangeEventHeader;
    global String Username;
    global String LastName;
    global String FirstName;
    global String Name;
    global String CompanyName;
    global String Division;
    global String Department;
    global String Title;
    global String Street;
    global String City;
    global String State;
    global String PostalCode;
    global String Country;
    global String StateCode;
    global String CountryCode;
    global Double Latitude;
    global Double Longitude;
    global String GeocodeAccuracy;
    global Address Address;
    global String Email;
    global Boolean EmailPreferencesAutoBcc;
    global Boolean EmailPreferencesAutoBccStayInTouch;
    global Boolean EmailPreferencesStayInTouchReminder;
    global String SenderEmail;
    global String SenderName;
    global String Signature;
    global String StayInTouchSubject;
    global String StayInTouchSignature;
    global String StayInTouchNote;
    global String Phone;
    global String Fax;
    global String MobilePhone;
    global String Alias;
    global String CommunityNickname;
    global Boolean IsActive;
    global String TimeZoneSidKey;
    global UserRole UserRole;
    global Id UserRoleId;
    global String LocaleSidKey;
    global Boolean ReceivesInfoEmails;
    global Boolean ReceivesAdminInfoEmails;
    global String EmailEncodingKey;
    global Profile Profile;
    global Id ProfileId;
    global String UserType;
    global String LanguageLocaleKey;
    global String EmployeeNumber;
    global SObject DelegatedApprover;
    global Id DelegatedApproverId;
    global User Manager;
    global Id ManagerId;
    global Datetime LastLoginDate;
    global Datetime LastPasswordChangeDate;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Integer NumberOfFailedLogins;
    global Datetime OfflineTrialExpirationDate;
    global Datetime OfflinePdaTrialExpirationDate;
    global Boolean UserPermissionsMarketingUser;
    global Boolean UserPermissionsOfflineUser;
    global Boolean UserPermissionsAvantgoUser;
    global Boolean UserPermissionsCallCenterAutoLogin;
    global Boolean UserPermissionsMobileUser;
    global Boolean UserPermissionsSFContentUser;
    global Boolean UserPermissionsKnowledgeUser;
    global Boolean UserPermissionsInteractionUser;
    global Boolean UserPermissionsSupportUser;
    global Boolean UserPermissionsChatterAnswersUser;
    global Boolean ForecastEnabled;
    global Boolean UserPreferencesActivityRemindersPopup;
    global Boolean UserPreferencesEventRemindersCheckboxDefault;
    global Boolean UserPreferencesTaskRemindersCheckboxDefault;
    global Boolean UserPreferencesReminderSoundOff;
    global Boolean UserPreferencesDisableAllFeedsEmail;
    global Boolean UserPreferencesDisableFollowersEmail;
    global Boolean UserPreferencesDisableProfilePostEmail;
    global Boolean UserPreferencesDisableChangeCommentEmail;
    global Boolean UserPreferencesDisableLaterCommentEmail;
    global Boolean UserPreferencesDisProfPostCommentEmail;
    global Boolean UserPreferencesContentNoEmail;
    global Boolean UserPreferencesContentEmailAsAndWhen;
    global Boolean UserPreferencesApexPagesDeveloperMode;
    global Boolean UserPreferencesReceiveNoNotificationsAsApprover;
    global Boolean UserPreferencesReceiveNotificationsAsDelegatedApprover;
    global Boolean UserPreferencesHideCSNGetChatterMobileTask;
    global Boolean UserPreferencesDisableMentionsPostEmail;
    global Boolean UserPreferencesDisMentionsCommentEmail;
    global Boolean UserPreferencesHideCSNDesktopTask;
    global Boolean UserPreferencesHideChatterOnboardingSplash;
    global Boolean UserPreferencesHideSecondChatterOnboardingSplash;
    global Boolean UserPreferencesDisCommentAfterLikeEmail;
    global Boolean UserPreferencesDisableLikeEmail;
    global Boolean UserPreferencesSortFeedByComment;
    global Boolean UserPreferencesDisableMessageEmail;
    global Boolean UserPreferencesDisableBookmarkEmail;
    global Boolean UserPreferencesDisableSharePostEmail;
    global Boolean UserPreferencesEnableAutoSubForFeeds;
    global Boolean UserPreferencesDisableFileShareNotificationsForApi;
    global Boolean UserPreferencesShowTitleToExternalUsers;
    global Boolean UserPreferencesShowManagerToExternalUsers;
    global Boolean UserPreferencesShowEmailToExternalUsers;
    global Boolean UserPreferencesShowWorkPhoneToExternalUsers;
    global Boolean UserPreferencesShowMobilePhoneToExternalUsers;
    global Boolean UserPreferencesShowFaxToExternalUsers;
    global Boolean UserPreferencesShowStreetAddressToExternalUsers;
    global Boolean UserPreferencesShowCityToExternalUsers;
    global Boolean UserPreferencesShowStateToExternalUsers;
    global Boolean UserPreferencesShowPostalCodeToExternalUsers;
    global Boolean UserPreferencesShowCountryToExternalUsers;
    global Boolean UserPreferencesShowProfilePicToGuestUsers;
    global Boolean UserPreferencesShowTitleToGuestUsers;
    global Boolean UserPreferencesShowCityToGuestUsers;
    global Boolean UserPreferencesShowStateToGuestUsers;
    global Boolean UserPreferencesShowPostalCodeToGuestUsers;
    global Boolean UserPreferencesShowCountryToGuestUsers;
    global Boolean UserPreferencesPipelineViewHideHelpPopover;
    global Boolean UserPreferencesHideS1BrowserUI;
    global Boolean UserPreferencesDisableEndorsementEmail;
    global Boolean UserPreferencesPathAssistantCollapsed;
    global Boolean UserPreferencesCacheDiagnostics;
    global Boolean UserPreferencesShowEmailToGuestUsers;
    global Boolean UserPreferencesShowManagerToGuestUsers;
    global Boolean UserPreferencesShowWorkPhoneToGuestUsers;
    global Boolean UserPreferencesShowMobilePhoneToGuestUsers;
    global Boolean UserPreferencesShowFaxToGuestUsers;
    global Boolean UserPreferencesShowStreetAddressToGuestUsers;
    global Boolean UserPreferencesLightningExperiencePreferred;
    global Boolean UserPreferencesPreviewLightning;
    global Boolean UserPreferencesHideEndUserOnboardingAssistantModal;
    global Boolean UserPreferencesHideLightningMigrationModal;
    global Boolean UserPreferencesHideSfxWelcomeMat;
    global Boolean UserPreferencesHideBiggerPhotoCallout;
    global Boolean UserPreferencesGlobalNavBarWTShown;
    global Boolean UserPreferencesGlobalNavGridMenuWTShown;
    global Boolean UserPreferencesCreateLEXAppsWTShown;
    global Boolean UserPreferencesFavoritesWTShown;
    global Boolean UserPreferencesRecordHomeSectionCollapseWTShown;
    global Boolean UserPreferencesRecordHomeReservedWTShown;
    global Boolean UserPreferencesFavoritesShowTopFavorites;
    global Boolean UserPreferencesExcludeMailAppAttachments;
    global Boolean UserPreferencesSuppressTaskSFXReminders;
    global Boolean UserPreferencesSuppressEventSFXReminders;
    global Boolean UserPreferencesPreviewCustomTheme;
    global Boolean UserPreferencesHasCelebrationBadge;
    global Boolean UserPreferencesUserDebugModePref;
    global Boolean UserPreferencesSRHOverrideActivities;
    global Boolean UserPreferencesNewLightningReportRunPageEnabled;
    global Contact Contact;
    global Id ContactId;
    global Account Account;
    global Id AccountId;
    global CallCenter CallCenter;
    global Id CallCenterId;
    global String Extension;
    global String FederationIdentifier;
    global String AboutMe;
    global String DigestFrequency;
    global String DefaultGroupNotificationFrequency;
    global Boolean IsProfilePhotoActive;
    global Individual Individual;
    global Id IndividualId;
    global User Account_Development_Manager__c;
    global User Approver_Level_1__c;
    global User Customer_Marketing_Manager__c;
    global User Approver_Level_2__c;
    global User Agronomy_Service_Rep__c;
    global User CU_Head__c;
    global User Approver_Level_3__c;
    global String Commercial_Unit__c;
    global User Approver_Level_4__c;
    global User District_Manager__c;
    global String Domain_ID__c;
    global String Employee_ID__c;
    /* Check this box to give this user the option to open DSA content using any iPad apps that support the opened file type.
    */
    global Boolean Enable_DSA_Open_In_Functionality__c;
    /* Select a value for this user. If the user is to be excluded from reporting, leave blank. On the report, select the value(s) to include in the report criteria.
    */
    global String Include_User_in_Reporting__c;
    global String SF_Full_ID__c;
    global String Territory_Code__c;
    /* Contains the Legacy SFDC ID from the NA org
    */
    global String Legacy_ID__c;
    /* This indicates a non Syngenta Canada user.
    */
    global Boolean External_User__c;
    global String SyngentaDSA__DSA_User_Country__c;
    global User Seed_Care_Specialist__c;
    global String DOA__c;
    global String Gridbuddy_Admin__c;
    global Boolean SyngentaDSA__Enable_ALL_MACs__c;
    global String SyngentaDSA__User_Country__c;
    /* If checked, DSA app will download all contacts for user.
    */
    global Boolean Download_All_DSA_Contacts__c;
    global String User_Country__c;
    global String DSA_User_Country_v4__c;

    global UserChangeEvent () 
    {
    }
}