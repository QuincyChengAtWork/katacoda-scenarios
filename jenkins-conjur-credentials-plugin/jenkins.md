
Launch Jenkins as a Docker Container with the following command:

```
mkdir jenkins_home
docker run -d -u root --name jenkins \
    -p 8181:8080 -p 50000:50000 \
    -v ${pwd}/jenkins_home:/var/jenkins_home \
    jenkins/jenkins:lts
```{{execute}}

** It will take a few minutes to start Jenkins.   Meanwhile, let's move on to next step and start deploying Conjur **

Visit https://[[HOST_SUBDOMAIN]]-8181-[[KATACODA_HOST]].environments.katacoda.com

While prompt for initial password, input the response by this command

`docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword`{{execute}}

In the next screen, select **Install suggested plugins**

If any of the plugin failed to be installed, don't worry, we will make sure the necessary plugins work properly in the next few steps.

Create an user called `admin`{{copy}} & password `344827fbdbfb40d5aac067c7a07b9230`{{copy}} to complete the setup
