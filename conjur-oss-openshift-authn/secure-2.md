

Let's test the app!   In fact, it's the same as insecure app.

First, we'll need the application URL 
(And no need to setup the dictionary again)

```
export secure_app_url=$(oc describe service test-app | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
```{{execute}}

To list all pet messages:

`curl $secure_app_url/pets`{{execute}}

To add a new message:

`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/words)\"}" -H "Content-Type: application/json" $secure_app_url/pet`{{execute}}

You can repeat the above actions to create & review multiple entries.
