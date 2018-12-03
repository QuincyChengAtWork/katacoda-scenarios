
Conjur supports both Jenkins pipeline script & Freestyle project.  If you'd like to use Freestyle project, please skip this step and continue to the next step.

### Create a pipeline script
You can create a pipeline script item at https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]]/job/Conjur%20Demo/newJob

Enter `Demo Script`{{copy}} as the item name
Choose **Pipeline** & click **OK**

![new script](https://github.com/QuincyChengAtWork/katacoda-scenarios/blob/master/jenkins-conjur-credentials-plugin/sceencap/step6-1.png?raw=true)

Scroll down to **Pipeline**.   You may need to uncheck **Use Groovy Sandbox** to make the *Script* field appear

Copy & Paste the pipeline script to **Script** field & click **Save**


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

![new script](https://github.com/QuincyChengAtWork/katacoda-scenarios/blob/master/jenkins-conjur-credentials-plugin/sceencap/step6-2.png?raw=true)

### Build it (optional)
Click **Build Now** to build it

You should be able to find `Hello World ****` in the log

![build now](https://github.com/QuincyChengAtWork/katacoda-scenarios/blob/master/jenkins-conjur-credentials-plugin/sceencap/step6-3.png?raw=true)
