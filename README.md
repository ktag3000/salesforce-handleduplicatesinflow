# Salesforce Handle Duplicates in Flow

Allows bypassing duplicate rules in a flow with one action when receiving the DUPLICATES_DETECTED error. The action is currently set up to handle Accounts and/or Contacts duplicates.

## How to Use

1. Clone the repo and deploy the changes to your target org.
2. Create a fault path on the flow encountering the DUPLICATES_DETECTED error.
3. The fault path will have a decision with the condition to look for the fault interview to contain DUPLICATES_DETECTED.
4. Add the apex class action.
5. Toggle which object(s) you receive the duplicate error for.
6. Pass in the appropriate record Id from the flow.
7. Save and test!
