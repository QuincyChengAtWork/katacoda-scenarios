Conjur supports both Jenkins pipeline script & Freestyle project. If you'd like to use Pipeline script project, please go back to previous step.


### Create a Freestyle project 
You can create a Freestyle project item at https://2886795293-8181-ollie02.environments.katacoda.com/job/Conjur%20Demo/newJob

Enter `Demo Freestyle`{{copy}} as the item name
Choose **Freestyle Project** & click **OK**

Scroll down to **Build Environment**
Check **Use secret text(s) or files(s)**

Click **Add** and choose **Conjur Secret Credentials**

By default, the variable will be set to **CONJUR_SECRET** and the **ConjurSecret:db/db_password/*Conjur* (Conjur Demo Folder Credentials** for you.

The secrets will be injected as environment variables to the build steps of the project.
