@isTest
public class playerDetailTest {
    @testSetup static void Setup(){
        Account playerAccount = new Account(name='Player', ranking__c=100);
        insert playerAccount;
    }
    
    @isTest static void testPlayerDetailComponent(){
        AccountController acctCont = new AccountController();
        acctCont.acct = new Account();
        Account act = [SELECT id, name, NumQuizzes__c, AvgScore__c, TotalScore__c, Ranking__c FROM Account LIMIT 1];
        System.assertEquals(acctCont.getActiveAccount(), act);
    }
}