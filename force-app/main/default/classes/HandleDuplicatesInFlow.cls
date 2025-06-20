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

        if(inputRecords == null) return;

        Set<Id> contactIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();

        // Loop over flow inputs list to assign object id's to a Set
        for (FlowInputs record : inputRecords) {

            if(record.contactId != null){
                contactIds.add(record.contactId);
            }

            if(record.accountId != null){
                accountIds.add(record.accountId);
            }

        }

        // Set DML options for duplicates
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = true; // Allows the duplicate to save
        dml.DuplicateRuleHeader.runAsCurrentUser = true; // Runs with sharing context
        
        // Assign id's to a record and update
        if(!contactIds.isEmpty()){
            Contact contactRecord = [SELECT Id FROM Contact WHERE Id IN :contactIds];
            Database.SaveResult srContact = Database.update(contactRecord, dml);
            if (srContact.isSuccess()) {
                System.debug('Contact success: ' +contactRecord);
            } else {
                System.debug('Contact failed: '+srContact.errors);
            }
        }

        if(!accountIds.isEmpty()){
            Account accountRecord = [SELECT Id FROM Account WHERE Id IN :accountIds];
            Database.SaveResult srAccount = Database.update(accountRecord, dml);
            if (srAccount.isSuccess()) {
                    System.debug('Account success: ' +accountRecord);
                } else {
                    System.debug('Account failed: ' +srAccount.errors);
            }
        }
    }
}