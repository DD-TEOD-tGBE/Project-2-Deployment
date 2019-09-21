public class playerDetailController {
    
    public Account acct = new Account();
    
    public Account getActiveAccount(){
        acct = [SELECT id, name, NumQuizzes__c, AvgScore__c, TotalScore__c, Ranking__c FROM Account];
        return acct;
    }
    
}