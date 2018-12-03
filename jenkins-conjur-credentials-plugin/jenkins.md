
Launch Jenkins as a Docker Container with the following command:

```
docker run -d -u root --name jenkins \
    -p 8181:8080 -p 50000:50000 \
    -v /root/jenkins_2112:/var/jenkins_home \
    jenkins/jenkins:2.112-alpine
```{{execute}}


All plugins and configurations get persisted to the host (`ssh root@host01`) at __/root/jenkins2112__. Port 8181 opens the web dashboard, 50000 is used to communicate with other Jenkins agents. Finally, the image has an alpine base to reduce the size footprint.

** It will take a few minutes to start Jenkins.   Meanwhile, let's move on to next step and start deploying Conjur **
