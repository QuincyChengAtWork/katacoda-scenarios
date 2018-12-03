### Load Jenkins Dashboard
You can load the Jenkins' dashboard via the following URL https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com

The username is `admin`{{copy}} with the password the default `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

If you are using your own environment, the password can be found via `docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

### Download & install the plugin
Download Conjur secrets plugin
`docker exec -it jenkins curl https://github.com/QuincyChengAtWork/katacoda-scenarios/raw/master/jenkins-conjur-credentials-plugin/assets/Conjur.hpi -o /var/jenkins_home/plugins/conjur.hpi`{{execute}}

Update Credential plugin to v2.1.18 or above
`docker exec -it jenkins java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ install-plugin credentials -deploy`{{execute}}

### Create Credential in Jenkins
You can create the credential manually or by executing the following commands

```
docker exec -it jenkins bash
echo '<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>                                      
<scope>GLOBAL</scope>
  <id>conjur-login</id>
  <description>Login Credential to Conjur</description>
  <username>host/frontend/frontend-01</username>
  <password>'$frontend_api_key'</password>
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>'\
 | java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ \
   create-credentials-by-xml system::system::jenkins _
exit
```{{execute}}

### Configure System Configuration in Jenkins
You can configure Jenkins manually or by executing the following commands

```
docker exec -it jenkins bash
cat >>/var/jenkins_home/org.conjur.jenkins.configuration.GlobalConjurConfiguration.xml<<EOF
<?xml version='1.1' encoding='UTF-8'?>
<org.conjur.jenkins.configuration.GlobalConjurConfiguration plugin="Conjur@0.2">
  <conjurConfiguration>
    <applianceURL>https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com/</applianceURL>
    <account>quick-start</account>
    <credentialID>conjur-login</credentialID>
    <certificateCredentialID></certificateCredentialID>
  </conjurConfiguration>
EOF
exit
```{{execute}}

If the above command returns an error, it is likely that Jenkins is still being restarted.   Please wait for a while and try again


### Enable Conjur secrets plugin
`docker exec -it jenkins java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ install-plugin https://github.com/QuincyChengAtWork/katacoda-scenarios/raw/master/jenkins-conjur-credentials-plugin/assets/Conjur.hpi -restart`{{execute}}

** Jenkins will be restarted, you may need to wait for 1-2 min and login to Jenkins dashboard again to proceed **

### Update API Key

Access https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com/credentials/store/system/domain/_/credential/conjur-login/update

And paste the API key from previous step to the Password field.   Click "Save" when finish

### Global Config
