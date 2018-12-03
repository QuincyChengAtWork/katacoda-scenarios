
Conjur supports both Jenkins pipeline script & Freestyle project.  If you'd like to use Freestyle project, please skip this step and continue to the next step.

### Create a pipeline script
You can create a pipeline script item at https://2886795293-8181-ollie02.environments.katacoda.com/job/Conjur%20Demo/newJob

Enter `Demo Script`{{copy}} as the item name
Choose *Pipeline* & click *OK*

Scroll down to *Pipeline*.   You may need to uncheck *Use Groovy Sandbox* to make the *Script* field appear

Copy & Paste the pipeline script to *Script* field & click *Save*

```
node {
      stage('Work') {
         withCredentials([conjurSecretCredential(credentialsId: 'DB_PASSWORD', variable: 'SECRET')]) {
            echo "Hello World $SECRET"
         }
      }
      stage('Results') {
         echo "Finished!"
      }
}
```{{copy}}

### Build it (optional)
Click *Build Now* to build it

You should find `Hello World ****` in the log

### Verify the secret retrieval
Let's verify the secret retrieval by reviewing the audit log

`
