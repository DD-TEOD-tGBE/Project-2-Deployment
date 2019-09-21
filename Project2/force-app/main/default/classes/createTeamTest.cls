@isTest
public class createTeamTest {
    @isTest static void teamCreationTest(){
        CollaborationGroup collabGroup = new CollaborationGroup();
        newTeamController cont = new newTeamcontroller();
        String newName = 'Test';
        collabGroup.Name = newName;
        collabGroup.CanHaveGuests = true;
        collabGroup.CollaborationType = 'Private';
        collabGroup.OwnerId = UserInfo.getUserId();
        cont.newName = newName;
        cont.newTeam();
        
        System.assertEquals('Test', collabGroup.name);
        System.assertEquals(True, collabGroup.CanHaveGuests);
        System.assertEquals(UserInfo.getUserId(), collabGroup.OwnerId);
    }
    
    @isTest static void createBulkTeams(){
        List<CollaborationGroup> bulkTeams = new List<CollaborationGroup>();
        for(Integer i = 0; i < 200; i++){
            CollaborationGroup collabGroup = new CollaborationGroup();
            collabGroup.Name = ''+i;
        	collabGroup.CanHaveGuests = true;
            collabGroup.CollaborationType = 'Private';
        	collabGroup.OwnerId = UserInfo.getUserId();
        	System.assertEquals(True, collabGroup.CanHaveGuests);
        	System.assertEquals(UserInfo.getUserId(), collabGroup.OwnerId);
            bulkTeams.add(collabGroup);
        }
        insert bulkTeams;
        System.assertEquals(200, bulkTeams.size());
    }
}