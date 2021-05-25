/** Author: Shoby Abdi, Program Lead B2B Solution Architect Program
For Learning Lab: Designing Data Strategies for Complex Customer Relationships

Purpose of this class is to be used by Invokable Action from a Flow Screen on an Account Record.
This class traverses Account records heirarchy and returns all children record associated
to account. Then using retrieved data new DataCloud classes eval records for duplicates against
existing record within heirarchy. Returns all Account records matching this Account.
**/

global class FindDuplicateAccounts {

    @InvocableMethod(label='findDuplicateAccountsInHeirarchy' description='Iterate through Account Records in Heirarchy to find Duplicates')
    global static List<AccountFlowOutput> reviewAccountRecords(List<AccountFlowInput> accountRecord) {
        List<Account> al = FindDuplicateAccounts.getAccountHeirarchy(accountRecord[0].accountRecord);
        
        //This is a very magic method
        Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(al);
        
        List<Account> duplicateAcountsFound = new List<Account>();
        if(results.size() > 0) {
            for (Datacloud.FindDuplicatesResult findDupeResult : results) {
              for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                  for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                      duplicateAcountsFound.add((Account)matchRecord.getRecord());
                  }
                }
              }
            }
        }
        
        if(duplicateAcountsFound.size() > 0) {
            AccountFlowOutput output = new AccountFlowOutput();
            output.duplicateAccounts = duplicateAcountsFound;
            return (List<AccountFlowOutput>)new List<AccountFlowOutput>().add(output);
        } else return null;
    }
    
    public static List<Account> getAccountHeirarchy(Account account) {
       Boolean topTier = false;
       Set<Id> accountIds = new Set<Id>();
       while(!topTier) {
           Account currentRecord = [select ParentId, Parent.ParentId, Parent.Parent.ParentId,
               Parent.Parent.Parent.ParentId, Parent.Parent.Parent.Parent.ParentId,
               Parent.Parent.Parent.Parent.Parent.ParentId from Account where
               Id=:account.Id];
           accountIds.add(account.Id);
           
           if(currentRecord.ParentId != null) accountIds.add(currentRecord.ParentId);
           else topTier = true;
           
           if(currentRecord.Parent.ParentId != null) accountIds.add(currentRecord.ParentId); 
           else topTier = true;
    
           if(currentRecord.Parent.Parent.ParentId != null) accountIds.add(currentRecord.Parent.ParentId);
           else topTier = true;       
           
           if(currentRecord.Parent.Parent.Parent.ParentId != null) accountIds.add(currentRecord.Parent.Parent.ParentId);
           else topTier = true;
           
           if(currentRecord.Parent.Parent.Parent.Parent.ParentId != null) accountIds.add(currentRecord.Parent.Parent.Parent.Parent.ParentId);
           else topTier = true;
           
           if(currentRecord.Parent.Parent.Parent.Parent.Parent.ParentId != null) accountIds.add(currentRecord.Parent.Parent.Parent.Parent.Parent.ParentId);
           else topTier = true;
       }
       
       List<Account> accountsToReturn = [select Id, Name from Account where ParentId in: accountIds];
       return accountsToReturn;
    }
    
    global class AccountFlowInput {
        @InvocableVariable (required=true)
        global Account accountRecord;
    }
    
    global class AccountFlowOutput {
        @InvocableVariable (required=true)
        global List<Account> duplicateAccounts;
    }
}