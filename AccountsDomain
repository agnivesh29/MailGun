public class AccountsDomain {
    private static boolean sendEmailRecursionBlocker = false;
    
    public static void OnAfterInsert(List<Account> accounts) {
        // Don't send mailgun for every test account insert.
        //if(!Test.isRunningTest())
        	sendOnBoardingEmail(accounts);
    }
    
    public static void OnAfterUpdate(List<Account> updatedAccounts, Map<Id,Account> oldAccountRecordMap) {
        if(sendEmailRecursionBlocker)
            return;
        
        // Don't send mailgun for every test account update.
        //if(! Test.isRunningTest())
        sendEmailUpdateConfirmation(updatedAccounts,oldAccountRecordMap);
        sendEmailRecursionBlocker = true;
    }
    
   @TestVisible
   private static void sendOnBoardingEmail(List<Account> accounts) {
        Map<String,String> accountNameByEmailAddress = new Map<String,String>();
        for(Account account: accounts) {
            if(String.isBlank(account.Email__c))
                continue;
            if(account.Name.contains('Test'))
                accountNameByEmailAddress.put(account.Email__c, account.Name);
        }
        if(!accountNameByEmailAddress.isEmpty()) 
            EmailUtil.sendOnboardingEmail(accountNameByEmailAddress);
    }
    
    @TestVisible
    private static void sendEmailUpdateConfirmation(List<Account> updatedAccounts, Map<Id,Account> oldAccountRecordMap) {
        Map<String,String> accountNameByEmailAddress = new Map<String,String>();
        for(Account account: updatedAccounts) {
            String accountOldEmailAddress = oldAccountRecordMap.get(account.Id).Email__c;
            String accountNewEmailAddress = account.Email__c;
            if(String.isNotBlank(accountNewEmailAddress) && (accountNewEmailAddress != accountOldEmailAddress)) {
                accountNameByEmailAddress.put(account.Email__c, account.Name);
            }
        }
        if(!accountNameByEmailAddress.isEmpty()) {
            System.debug('sendEmailUpdateConfirmation');
            EmailUtil.sendEmailUpdateConfirmation(accountNameByEmailAddress);
        }
    }
}
