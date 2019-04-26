


### Usage of Secure App

Let's test the app!   In fact, it's the same as insecure app.

First, we'll need the application URL 
(And no need to setup a random message generator again)

```
export app_url=$(kubectl describe service test-app | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
```{{exeucte}}

To list all pet messages:

`curl $app_url/pets`{{execute}}

To add a new message:

`curl  -d '{"name": "$(fortune)"}' -H "Content-Type: application/json" $app_url/pet`{{execute}}
