# Salesforce Handle Duplicates in Flow

Allows bypassing duplicate rules in flow with one action. The action is currently set up to handle Accounts and/or Contacts duplicates.

## How to Use

1. Clone the repo and deploy the changes to your target org.
2. Create a fault path on the flow that is encountering the DUPLICATES_DETECTED error.
3. The fault path with have a decision with the condtion to look for the fault interview to contain DUPLICATES_DETECTED.
4. Add the apex class action.
5. Toggle on which object(s) you are receiving the duplicate error for.
6. Pass in the appropriate record id from the flow.
7. Save and test!
