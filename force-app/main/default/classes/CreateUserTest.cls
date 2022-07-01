@isTest
private class CreateUserTest {
    @isTest
    public static void createUserMethod(){
        String currentUser = UserInfo.getUserName();
        String currentProfile = UserInfo.getProfileId();
        String orgId = UserInfo.getOrganizationId(); 
        
        List<Profile> lstProfile = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator' ];
        
        User createUser = new User();
        createUser.ProfileId = lstProfile[0].Id;
        createUser.lastname = 'Bano';
        createUser.FirstName = 'Shabana';
        createUser.alias = 'shbn';
        createUser.email = 'shabana' + '@test.com';
        createUser.emailencodingkey = 'UTF-8';
        createUser.languagelocalekey = 'en_US';
        createUser.localesidkey = 'en_US';
        createUser.timezonesidkey = 'America/Los_Angeles';
        createUser.username = 'shabana@test.com'; 
        insert createUser;
        
        System.debug('Current User: ' + UserInfo.getUserName());
        System.debug('Current Profile: ' + UserInfo.getProfileId());
        System.debug('orgId : ' + UserInfo.getOrganizationId());
    }
}