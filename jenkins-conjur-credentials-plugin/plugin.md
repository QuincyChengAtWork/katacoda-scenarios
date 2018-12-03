### Load Jenkins Dashboard
You can load the Jenkins' dashboard via the following URL https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com

The username is `admin`{{copy}} with the password the default `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

On your own system, the password can be found via `docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`


### Create Credential in Jenkins
You can create the credential manually or by executing the following command 

```
docker exec -it jenkins bash
echo '<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>                                      
<scope>GLOBAL</scope>
  <id>conjur-login</id>
  <description>Login Credential to Conjur</description>
  <username>host/frontend/frontend-01</username>
  <password>
    dummy
  </password>                                                                                                            
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>'\
 | java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ \
   create-credentials-by-xml system::system::jenkins _
exit
```{{execute}}

### Update API Key

Access https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com/credentials/store/system/domain/_/credential/conjur-login/update

And paste the API key from previous step to the Password field.   Click "Save" when finish

### Global Config
