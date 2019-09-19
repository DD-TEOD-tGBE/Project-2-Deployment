@isTest
public class QuizPageControllerTest {
    
@testSetup
public static void datafactory(){
    account acc = new account(name='test');
    insert acc;
    
    quiz__c nc=new quiz__c(name='j');
    insert nc;
    
    list<quiz__c> qz2=[SELECT id FROM quiz__c];
    questions__c qs= new questions__c(name='jj', quiz__c=qz2[0].id, a__c='a',
                                     b__c='b',c__c='c',d__c='d',CorrectAnswer__c='c');
    insert qs;
    
    questions__c qs2= new questions__c(name='jjj', quiz__c=qz2[0].id, a__c='a',
                                     b__c='b',c__c='c',d__c='d',CorrectAnswer__c='c');
    insert qs2;
}
    
    
@isTest
    public static void Test1(){
    QuizPageController qz = new QuizPageController();
        System.assertNotEquals(null, qz.q);
        System.assertNotEquals(null, qz.ques);
        System.debug(qz.ques);
        
        quiz__c result1=qz.getQuiz();
        questions__c result2 = qz.getQuestions();
        list<selectoption> result3 = qz.getAnswers();
        System.assertNotEquals(null, result1);
        System.assertNotEquals(null, result2);
        System.assertNotEquals(null, result3);
        
        
        System.assertEquals(False, qz.getNxt());
        System.assertEquals(True, qz.getLst());
        qz.next();
        System.assertEquals(1, qz.count);
        //System.assertEquals(1,qz.score);
        qz.getNxt();
        qz.getLst();
        //count=1
        
        qz.submit();
        list<accountQuiz__c> result4=[SELECT name FROM AccountQuiz__c];
        System.assertNotEquals(null, result4);
    }
    
    
    
}