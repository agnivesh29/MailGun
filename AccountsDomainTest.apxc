@isTest
public class AccountsDomainTest {
    @isTest
    private static void testOnAfterInsert_success() {
		Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MailgunCalloutMockImpl('Success', 200));
        List<Account> newAccounts = setupAccountData();
        AccountsDomain.onAfterInsert(newAccounts);
        Test.stopTest();   
    }
    
	@isTest
    private static void testSendOnBoardingEmail_success() {
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MailgunCalloutMockImpl('Success', 200));
        List<Account> newAccounts = setupAccountData();
        AccountsDomain.sendOnBoardingEmail(newAccounts);
        
        Test.stopTest();
    }
    
    @isTest
    private static void testSendOnBoardingEmail_failure() {
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MailgunCalloutMockImpl('Bad Request', 400));
        
        try{
            List<Account> newAccounts = setupAccountData();
            AccountsDomain.sendOnBoardingEmail(newAccounts);
        } catch(Exception ex) {
            System.debug('testing error scenario exception='+ex);
        }
        
        Test.stopTest();
    }
	
	@isTest
    private static void testOnAfterUpdate_success() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MailgunCalloutMockImpl('Success', 200));
        List<Account> newAccounts = setupAccountData();
        insert newAccounts;
        
        Map<Id,Account> oldAccountById = new Map<Id,Account>(newAccounts);
        List<Account> updatedAccounts = newAccounts;
        updatedAccounts[0].Email__c = 'a1@test.com';
        updatedAccounts[1].Email__c = 'b1@test.com';
        
        AccountsDomain.OnAfterUpdate(newAccounts, oldAccountById);
        
        Test.stopTest();
    }
    
    @isTest
    private static void testSendEmailUpdateConfirmation_success() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MailgunCalloutMockImpl('Success', 200));
        
        Id accountId_1 = SObjectMocks.getFakeId(Account.SObjectType);
        Id accountId_2 = SObjectMocks.getFakeId(Account.SObjectType);
        
        Account account1 = new Account(Id=accountId_1, Name='Test Account 1', phone='040040040', Email__c='a@test.com');
        Account account2 = new Account(Id=accountId_2,Name='Test Account 2', phone='040040050', Email__c='b@test.com');
        List<Account> accountsToUpdate = new List<Account>{account1,account2};
            
        Map<Id,Account> oldAccountById = new Map<Id,Account>{
           accountId_1 => account1,
           accountId_2 => account2
        };
        
        Account updatedAccount1 = account1.clone(true, true, false, false);
        updatedAccount1.Email__c = 'a1@test.com';
        Account updatedAccount2 = account2.clone(true, true, false, false);
        updatedAccount2.Email__c = 'b1@test.com';
        
        AccountsDomain.sendEmailUpdateConfirmation(new List<Account>{updatedAccount1,updatedAccount2}, oldAccountById);
        
        Test.stopTest();
    }
    
    private static List<Account> setupAccountData() {
        Account account1 = new Account(Name='Test Account 1', phone='040040040', Email__c='a@test.com');
        Account account2 = new Account(Name='Test Account 2', phone='040040050', Email__c='b@test.com');
        Account account3 = new Account(Name='Test Account 2', phone='040040050');
        return new List<Account>{account1,account2,account3};
    }
}
