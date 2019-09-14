  
public class QuizPageController {

public string choice {get;set;}

    integer count=0;
    integer limitSize=10;
    integer score=0;
    integer totalRecs=0;

    list<account> newAcc=[SELECT Id FROM account WHERE OwnerId = :UserInfo.getUserID() LIMIT 1];

      public QuizPageController() {
        q = [SELECT id, Name FROM Quiz__c];
        ques = [SELECT Name ,Right_Answer__c, Wrong_Answer_1__c,  Wrong_Answer_2__c,  Wrong_Answer_3__c FROM Questions__c WHERE Quiz__c IN :q LIMIT :limitSize OFFSET :count ];
        totalrecs=ques.size();

        
    }

       public list<quiz__c> q;
       public list<questions__c> ques;


 
  
 
    public Quiz__c getQuiz() {
        return q[0];
    }
    
    public Questions__c getQuestions(){
        return ques[count];
        

    }

    
    public List<SelectOption> getAnswers() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('A',Ques[count].Right_Answer__c)); 
        options.add(new SelectOption('B',Ques[count].Wrong_Answer_1__c)); 
        options.add(new SelectOption('C',Ques[count].Wrong_Answer_2__c)); 
        options.add(new SelectOption('D',Ques[count].Wrong_Answer_3__c)); 
        return options; 
    }
    

    
    public PageReference Q1(){
        count=0;
        return null;
    }

    public PageReference next(){
        if(choice == ques[count].Right_Answer__c){
            score++;

        System.debug('score:'+score);
        }

        count++;
        return null;
    }

        public Boolean getNxt() {
        if(count> totalRecs-2)
       		return true;
     	else
       		return false;     
    }

        public Boolean getLst(){
            if(count==TotalRecs-1){
                return false;
            }else{
                return true;
            }
        }

    public PageReference previous(){
        count--;
        return null;
    }

    public void submit(){
        if(choice == ques[count].Right_Answer__c){
            score++;
        }
        System.debug('score:'+score);
        System.debug('final'+ques.size());
        AccountQuiz__c newAccQuiz = new AccountQuiz__c(name='test', Account__c=newAcc[0].Id, Quiz__c=q[0].id,Score__c=((score*100/ques.size())));
        insert newAccQuiz;

        
    }
    



 



}