@istest
public class indiLeadControllerTest {

    
@testSetup
public static void datafactory(){
    account acc = new account(name='test');
    insert acc;
}
    
@istest
    public static void AccountTest(){
        list<account> result = indiLeadController.getmyAccount();
        System.assertNotEquals(null, result[0].ranking__c);
    }
 
@istest
    public static void AccountTest2(){
        list<account> result=indiLeadController.getAccount();
        System.assertNotEquals(null, result);
    }
}