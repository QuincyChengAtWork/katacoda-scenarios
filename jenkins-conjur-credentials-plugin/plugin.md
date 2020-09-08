Plugin Configuration
Use the Jenkins UI to configure the following: 

- Conjur/Jenkins connection information.
- Credentials stored in Conjur that Jenkins needs to access. Each secret has a Conjur variable path name and a reference ID to use in the Jenkins script or project.


### Load Jenkins Dashboard
You can load the Jenkins' dashboard via the following URL https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com

The username is `admin`{{copy}} with the password the default `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

If you are using your own environment, the password can be found via `docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

### Download & install the plugin
Download Conjur secrets plugin
`docker exec -it jenkins curl https://github.com/cyberark/conjur-credentials-plugin/releases/download/v0.8.0/Conjur.hpi -o /var/jenkins_home/plugins/conjur.hpi`{{execute}}

Update Credential plugin to v2.1.18 or above
`docker exec -it jenkins java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ install-plugin credentials -deploy`{{execute}}

### Define connection information

** Using CLI **
You can create the credential by executing the following commands.   

```
docker exec -it jenkins sh -c "echo \"<com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl> 
<scope>GLOBAL</scope>
  <id>conjur-login</id>
  <description>Login Credential to Conjur</description>
  <username>host/jenkins-frontend/frontend-01</username>
  <password>${frontend_api_key}</password>
</com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>\" \
 | java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ \
   create-credentials-by-xml system::system::jenkins _ "
```{{execute}}


** Using Jenkins Web UI**

The following steps define the connection to the Conjur appliance. This is typically a one-time configuration.

In a browser, go to the Jenkins UI.

1. Navigate to Jenkins > Credentials > System > Global credentials > host-name.

2. The host-name is a Jenkins host. It must match a host that you declared in Conjur policy.

3. On the form that appears, configure the login credentials. These are credentials for the Jenkins host to log into Conjur.

   - Scope: Select Global.
   - Username: Enter host/jenkins-frontend/<host-name> , where <host-name> is the network name for the Jenkins host that you declared in Conjur.
   - Password: Copy and paste the API key that was returned by Conjur when you loaded the policy declaring this host.
   - ID:  The Jenkins ID, natively provided by Jenkins.
   - Description:  Optional. Provide a description to identify this global credential entry.

Access to the Jenkins host and to the credentials is protected by Conjur.
 	
When a host attempts to authenticate with Conjur, Conjur can detect if the request is originating from the host presenting the request. Conjur denies connection if the requestor is not the actual host. 

4. Click Save.

### Decide whether to set up global or folder-level access to Conjur, or a combination of both.

   - A global configuration allows any job to use the configuration (unless a folder-level configuration overrides the global configuration).
   - A folder-level configuration is specific to jobs in the folder. Folder-level configurations override the global configuration. In a hierarchy of folders, each folder may inherit configuration information from its parent. The top level in such a hierarchy is the global configuration.
   - You may set up a global configuration and override it with folder-level configurations.

** Using CLI **

You can configure Jenkins manually or by executing the following commands

```
docker exec -it jenkins bash
cat >>/var/jenkins_home/org.conjur.jenkins.configuration.GlobalConjurConfiguration.xml<<EOF
<?xml version='1.1' encoding='UTF-8'?>
<org.conjur.jenkins.configuration.GlobalConjurConfiguration plugin="Conjur@0.2">
  <conjurConfiguration>
    <applianceURL>https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/</applianceURL>
    <account>quick-start</account>
    <credentialID>conjur-login</credentialID>
    <certificateCredentialID></certificateCredentialID>
  </conjurConfiguration>
EOF
exit
```{{execute}}

If the above command returns an error, it is likely that Jenkins is still being restarted.   Please wait for a while and try again


** Using Jenkins Web UI **

1. Navigate to either Jenkins > Manage Jenkins > Configure Jenkins   or Jenkins > Folder-name > Configuration.

2. On the form that appears, under Conjur Appliance, configure the Conjur connection information.
   - Inherit from parent?: This checkbox appears only on the folder level configuration window. If checked, the values set here are ignored, and values in the parent folder apply. If all folders up the hierarchy are set to inherit from their parents, the global configuration is used.  
   - Account:  The Conjur organizational account that was assigned when Conjur was originally configured. For example, my-org.
   - Appliance URL: The secure URL to Conjur.  For example: https://conjur-master.example.com
   - Conjur Auth Credentials: The host name and API key to authenticate to Conjur. Select credentials previously configured, or click Add to add new values.
- Conjur SSL Certificate: Select none. You already imported the SSL Certificate onto the Jenkins host in Certificate Preparation. This field allows you to reference a certificate stored as a credential in Jenkins. The stored value must be a .p12 file generated using the openssl command to convert the conjur.pem file. Because openssl requires the conjur.key file for the conversion, we recommend avoiding this method.

3. Click Save.


### Enable Conjur secrets plugin
`docker exec -it jenkins java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ install-plugin https://github.com/cyberark/conjur-credentials-plugin/releases/download/v0.8.0/Conjur.hpi -restart`{{execute}}

** Jenkins will be restarted, you may need to wait for 1-2 min and login to Jenkins dashboard again to proceed **

### Verify Credential created

Access https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com/credentials/store/system/domain/_/credential/conjur-login/update

You may need to login to the Jenkins dashboard again as the previous step involves restarting of Jenkins.
The username is `admin`{{copy}} with the password the default `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

![credential](https://github.com/QuincyChengAtWork/katacoda-scenarios/blob/master/jenkins-conjur-credentials-plugin/sceencap/step4-1.png?raw=true)

### Verify Global Configuration
Access https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com/configure

You should be able to a section named **Conjur Appliance** with details configured.

![global config](https://github.com/QuincyChengAtWork/katacoda-scenarios/blob/master/jenkins-conjur-credentials-plugin/sceencap/step4-2.png?raw=true)
