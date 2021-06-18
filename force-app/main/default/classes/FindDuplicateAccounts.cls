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
        Datacloud.FindDuplicatesResult[] foundDuplicateResults = Datacloud.FindDuplicates.findDuplicates(al);
        
        Set<Id> accountUniques = new Set<Id>();
        for (Datacloud.FindDuplicatesResult findDupeResult : foundDuplicateResults) {
            for (Datacloud.DuplicateResult dupeResult : findDupeResult.getDuplicateResults()) {
                for (Datacloud.MatchResult matchResult : dupeResult.getMatchResults()) {
                    for (Datacloud.MatchRecord matchRecord : matchResult.getMatchRecords()) {
                        if(matchRecord.getMatchConfidence() > 0) {
                            accountUniques.add(matchRecord.getRecord().Id);
                        }
                    }
                }
            }
        }
        if(accountUniques.size() > 0) {
            List<Account> duplicateAcountsFound = [select Id, Name from Account where Id in: accountUniques];
            AccountFlowOutput output = new AccountFlowOutput();
            output.duplicateAccounts = duplicateAcountsFound;
            List<AccountFlowOutput> listAccounts = new List<AccountFlowOutput>();
            listAccounts.add(output);
            return listAccounts;
        } 
        else {
            return null;
        }
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