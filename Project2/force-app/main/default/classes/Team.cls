public with sharing class Team {
    //Overall Score of the team
    public double score;

    //Team
    public CollaborationGroup Chattergroup;

    //List of team members
    public List<Account> members;

    public Team(collaborationGroup passedGroup) {

        Chattergroup = passedGroup;
        score = 0;

        //get the id of the users in the chatter group
        List<CollaborationGroupMember> teamMemberUsers = [SELECT id, MemberId FROM CollaborationGroupMember WHERE CollaborationGroupid= :Chattergroup.id];
        
        //for each user, find their account, and add to the list of team members
        for(CollaborationGroupMember cgm: teamMemberUsers)
        {
            Account foundHim = [SELECT id, name, AvgScore__c FROM Account WHERE AccountUser__c = :cgm.id];
            score = score + foundHim.AvgScore__c;
            members.add(foundHim);
        }

        //determine overall score based on score of the individual users
        score = score/members.size();
        
        

    }
}