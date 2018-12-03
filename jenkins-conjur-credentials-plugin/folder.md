You can override the global configuration by setting the Conjur Appliance information at Folder level, if the checkbox “Inherit from parent?” is checked, it means it will ignore the values set here, and go up the level navigating to the parent folder, or taking the global configuration if all folder up the hierarchy are inheriting from parent.


```
docker exec -it jenkins bash
cat >> conjur_folder << _EOF_
<?xml version='1.1' encoding='UTF-8'?>
<com.cloudbees.hudson.plugins.folder.Folder plugin="cloudbees-folder@6.4">
  <actions/>
  <description></description>
  <properties>
    <org.conjur.jenkins.configuration.FolderConjurConfiguration plugin="Conjur@0.2">
      <inheritFromParent>false</inheritFromParent>
      <conjurConfiguration>
        <applianceURL>[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]]</applianceURL>
        <account>quick-start</account>
        <credentialID>conjur-login</credentialID>
        <certificateCredentialID></certificateCredentialID>
      </conjurConfiguration>
    </org.conjur.jenkins.configuration.FolderConjurConfiguration>
    <org.jenkinsci.plugins.pipeline.modeldefinition.config.FolderConfig plugin="pipeline-model-definition@1.2.7">
      <dockerLabel></dockerLabel>
      <registry plugin="docker-commons@1.11"/>
    </org.jenkinsci.plugins.pipeline.modeldefinition.config.FolderConfig>
    <com.cloudbees.hudson.plugins.folder.properties.FolderCredentialsProvider_-FolderCredentialsProperty>
      <domainCredentialsMap class="hudson.util.CopyOnWriteMap$Hash">
        <entry>
          <com.cloudbees.plugins.credentials.domains.Domain plugin="credentials@2.1.18">
            <specifications/>
          </com.cloudbees.plugins.credentials.domains.Domain>
          <java.util.concurrent.CopyOnWriteArrayList>
            <org.conjur.jenkins.ConjurSecrets.ConjurSecretCredentialsImpl plugin="Conjur@0.2">
              <id>DB_PASSWORD</id>
              <description>Conjur Demo Folder DB Password</description>
              <variablePath>db/db_password</variablePath>
            </org.conjur.jenkins.ConjurSecrets.ConjurSecretCredentialsImpl>
          </java.util.concurrent.CopyOnWriteArrayList>
        </entry>
      </domainCredentialsMap>
    </com.cloudbees.hudson.plugins.folder.properties.FolderCredentialsProvider_-FolderCredentialsProperty>
  </properties>
  <folderViews class="com.cloudbees.hudson.plugins.folder.views.DefaultFolderViewHolder">
    <views>
      <hudson.model.AllView>
        <owner class="com.cloudbees.hudson.plugins.folder.Folder" reference="../../../.."/>
        <name>All</name>
        <filterExecutors>false</filterExecutors>
        <filterQueue>false</filterQueue>
        <properties class="hudson.model.View$PropertyList"/>
      </hudson.model.AllView>
    </views>
    <tabBar class="hudson.views.DefaultViewsTabBar"/>
  </folderViews>
  <healthMetrics>
    <com.cloudbees.hudson.plugins.folder.health.WorstChildHealthMetric>
      <nonRecursive>false</nonRecursive>
    </com.cloudbees.hudson.plugins.folder.health.WorstChildHealthMetric>
  </healthMetrics>
  <icon class="com.cloudbees.hudson.plugins.folder.icons.StockFolderIcon"/>
</com.cloudbees.hudson.plugins.folder.Folder>
_EOF_
cat conjur_folder | java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://admin:344827fbdbfb40d5aac067c7a07b9230@localhost:8080/ 
exit
```{{execute}}

### Verify Folder settings
Access https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com//job/Conjur%20Demo/configure

