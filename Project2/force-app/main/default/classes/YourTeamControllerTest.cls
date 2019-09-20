@isTest
public class YourTeamControllerTest {
	
    @TestSetup
    public static void createData(){
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', FirstName='Uno', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName);
        insert u;
        
        Account newA = new Account(Name = 'TestAccount', AccountUser__c = u.id);
        insert newA;
        
        System.runAs(u){
            List<CollaborationGroup> cg = new List<CollaborationGroup>();
        
            cg.add(new CollaborationGroup(CollaborationType = 'private',
                                          Description = 'TestGroup',
                                          Name = '1st new CollaborationGroup'));
            cg.add(new CollaborationGroup(CollaborationType = 'private',
                                          Description = 'TestGroup2',
                                          Name = '2nd new CollaborationGroup'));
            
            insert cg;
        }
        List<CollaborationGroup> cg = new List<CollaborationGroup>();
        cg.add(new CollaborationGroup(CollaborationType = 'private',
                                          Description = 'TestGroup3',
                                          Name = '3rd new CollaborationGroup'));
        insert cg;
        /*
        List<CollaborationGroup> cgList = [SELECT id FROM CollaborationGroup WHERE Description Like 'TestGroup%'];
        List<CollaborationGroupMember> members = new List<CollaborationGroupMember>();
        
        members.add(new CollaborationGroupMember(CollaborationGroupId = cgList[0].id, MemberId = u.id));       
        members.add(new CollaborationGroupMember(CollaborationGroupId = cgList[1].id, MemberId = u.id));
        insert members;
        */
    }
    @isTest
    public static void performTest(){
        User u = [SELECT id FROM User WHERE email = 'standarduser@testorg.com'];
        System.runAs(u){
            YourTeamController ytc = new YourTeamController();
        	ytc.getCgm();
            ytc.getNewTeam();
            
            //This gets the collaborationGroupId of the member logged in
            List<CollaborationGroupMember> chatterList = [Select Member.Name, CollaborationGroupId from CollaborationGroupMember where CollaborationGroupId IN (Select Id from CollaborationGroup) and Member.Name Like :UserInfo.getFirstName()+'%'];
            
            //This returns the list of members of a certain CollaborationGroup using chatterList
            List<CollaborationGroupMember> cgm = [SELECT Member.Name FROM CollaborationGroupMember WHERE CollaborationGroupId=:chatterList[0].collaborationGroupId];
            List<Team> newTeam = new List<Team>();
            for(Integer i = 0; i < chatterList.size(); i++){
                newTeam.add(new Team(chatterList[i].collaborationGroupId));
        	}
            System.assertEquals(cgm, ytc.getCgm());
        }
        
        
        
        
    }
    
    @isTest 
    public static void performTest2(){
        User u = [SELECT id FROM User WHERE email = 'standarduser@testorg.com'];
        System.runAs(u){
            TeamDetailsJoinController tdjc = new TeamDetailsJoinController();
            List<CollaborationGroup> cg = new List<CollaborationGroup>();
            cg = [SELECT id FROM CollaborationGroup WHERE Description Like 'TestGroup3' LIMIT 1];
            tdjc.setCollabId(cg[0].id);
            tdjc.addToTeam();
        }
    }
}