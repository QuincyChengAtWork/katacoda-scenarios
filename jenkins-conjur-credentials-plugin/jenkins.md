
Launch Jenkins as a Docker Container with the following command:

```
docker run -d -u root --name jenkins \
    -p 8181:8181 -p 50000:50000 \
    -v /root/jenkins_2112:/var/jenkins_home \
    jenkins/jenkins:2.112-alpine
```{{execute}}

Download the plugin
```
docker exec -it jenkins curl https://github.com/QuincyChengAtWork/katacoda-scenarios/raw/master/jenkins-conjur-credentials-plugin/assets/Conjur.hpi -o /var/jenkins_home/plugins/conjur.hpi
```{{execute}}

All plugins and configurations get persisted to the host (`ssh root@host01`) at _/root/jenkins2112. Port 8181 opens the web dashboard, 50000 is used to communicate with other Jenkins agents. Finally, the image has an alpine base to reduce the size footprint.


### Load Dashboard
You can load the Jenkins' dashboard via the following URL https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com

The username is `admin`{{copy}} with the password the default `344827fbdbfb40d5aac067c7a07b9230`{{copy}}

On your own system, the password can be found via `docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

It may take a couple of seconds for Jenkins to finish starting and be available. In the next steps, you'll use the dashboard to configure the plugins and start building Docker Images.

