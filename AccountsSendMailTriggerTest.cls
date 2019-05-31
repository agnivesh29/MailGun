@isTest
public class AccountsSendMailTriggerTest {
	@isTest
    private static void testAccountAfterInsert() {
        List<Account> insertedAccount = [Select Id from Account where phone='040040040' or phone='040040050'];
        System.assertEquals(2, insertedAccount.size());
    }
    
    @isTest
    private static void testAccountAfterUpdate() {
		List<Account> accountsToUpdate = [Select Id,Industry from Account where phone='040040040' or phone='040040050'];
        for(Account account: accountsToUpdate) {
            account.Industry = 'Education';
        }
        Test.startTest();
        update accountsToUpdate;
        Test.stopTest();
        List<Account> updatedAccounts = [Select Id,Industry from Account where phone='040040040' or phone='040040050'];
        System.assertEquals('Education', updatedAccounts[0].Industry);
        System.assertEquals('Education', updatedAccounts[1].Industry);
    }
    
    @testSetup
    private static void insertTestAccounts() {
        Account account1 = new Account(Name='Test Account 1', phone='040040040');
        Account account2 = new Account(Name='Test Account 1', phone='040040050');
        insert new List<Account>{account1,account2};
    }
}
