

### Usage of Insecure App

Let's test the app!

First, we'll need the application URL and setup a random message generator

```
export app_url=$(kubectl describe service test-app | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
apt install -y fortune
```{{exeucte}}

To list all pet messages:

`curl $app_url/pets`{{execute}}

To add a new message:

`curl  -d '{"name": "$(fortune)"}' -H "Content-Type: application/json" $app_url/pet`{{execute}}

