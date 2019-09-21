public without sharing class newTeamController {
    
    public String newName{get;set;}
    
    //Creates a New Team using Chatter Collaboration Group
    public void newTeam(){
        CollaborationGroup team = new CollaborationGroup();
        team.CollaborationType = 'Private';
        team.CanHaveGuests = true;
        team.OwnerId = UserInfo.getUserId();
        team.Name = newName;
        System.debug(team);
        insert team;
    }
    
}