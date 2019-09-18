public class MostRecentQuiz {
    public List<AccountQuiz__c> Quizzes {get;set;}
    public MostRecentQuiz(){
        Quizzes = [SELECT Name, Score__c, CreatedById FROM AccountQuiz__c];
    }
}