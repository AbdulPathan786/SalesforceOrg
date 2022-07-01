/*
*Authur : Abdul Pathan
*Date 	: 06-Sep-2021
*Descriptions : User fetch, addd & remove in Group
*/

public class UserAndGroupController {
    
    // Remove User from Group 
    public static void removeUserGroup(){
        Group groupRec =[SELECT Id, DeveloperName from Group Where DeveloperName='All_User']; 
        Set<Id> setGroupId = new Set<Id>();
        Set<Id> setUserOrGroupId = new Set<Id>();
        for (User user : [SELECT Id, Name, User.Profile.Name, User.IsActive FROM user WHERE Id =: '0052w0000024yjoAAA']){
            // if(user.Profile.Name == 'Clone Profile System Administrator' && (user.IsActive == true || user.IsActive == false)){
            setUserOrGroupId.add(user.Id);
            setGroupId.add(groupRec.Id);
            //}
        }
        if( setGroupId.size() > 0 && setUserOrGroupId.size() > 0 ){
            List<GroupMember> groupMemberRecords  = [SELECT Id FROM GroupMember WHERE UserOrGroupId IN :setUserOrGroupId and GroupId IN :setGroupId];
            if(groupMemberRecords.size() > 0 ) {
                delete groupMemberRecords;
            }
        }
    }
    
    // add User from Group
    public static void insertUser(){
        List<GroupMember> groupMembers = New List<GroupMember>();
        
        GroupMember gm = new GroupMember();
        gm.GroupId = '00G2w000002QAMyEAO';
        gm.UserOrGroupId = '0052w0000024yjoAAA';
        groupMembers.add(GM);
        
        if(groupMembers.size() > 0){
            INSERT groupMembers;
        }
    }
    
    //Fetch User from Group
    public static void FetchUserRecords(){
        Set<Id> userIds = New Set<Id>();
        for(GroupMember gm : [SELECT UserOrGroupId FROM GroupMember WHERE Group.Name = 'All User']){
            if(gm.UserOrGroupID.getsObjectType() == Schema.User.sObjectType)
                userIds.add(gm.UserOrGroupID);
        }
        List<User> lstUser = [Select Id, Name From User Where Id IN :userIds];
        System.debug('lstUser  ' + lstUser);
    }
}