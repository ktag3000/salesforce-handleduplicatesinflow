public with sharing class HandleDuplicatesInFlow {

    // Input variables for flow
    public class FlowInputs {
        @InvocableVariable
        public Id contactId;

        @InvocableVariable
        public Id accountId;
    }

    // Method called by flow
    @InvocableMethod(label='Handle Duplicate Record')
    public static void saveDuplicates(List<FlowInputs> inputRecords) {
        
        // Define variables to store Contact and Account Id's and to know when the Contact or Acount toggle is used in the flow
        Id contactId;
        Id accountId;
        Boolean contactToggle = false;
        Boolean accountToggle = false;

        // Loop over flow inputs list to assign object id's
        for (FlowInputs record : inputRecords) {
            if(record.accountId == null && record.contactId == null) return;
             
            if(record.contactId != null){
                contactId = record.contactId;
                contactToggle = true;
             }

            if(record.accountId != null){
                accountId = record.accountId;
                accountToggle = true;
            }
        }

        // Set DML options for duplicates
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = true; // Allows the duplicate to save
        dml.DuplicateRuleHeader.runAsCurrentUser = true; // Runs with sharing context
        
        // Assign id's to a record and update
        if(contactToggle == true){
            Contact contactRecord = [SELECT Id FROM Contact WHERE Id = :contactId];
            Database.SaveResult srContact = Database.update(contactRecord, dml);
            if (srContact.isSuccess()) {
                System.debug('Contact success: ' +contactId);
            } else {
                System.debug('Contact failed: '+srContact.errors);
            }
        }
        
        if(accountToggle == true){
            Account accountRecord = [SELECT Id FROM Account WHERE Id = :accountId];
            Database.SaveResult srAccount = Database.update(accountRecord, dml);
            if (srAccount.isSuccess()) {
                    System.debug('Account success: ' +accountId);
                } else {
                    System.debug('Account failed: ' +srAccount.errors);
                }
        }
    }
}