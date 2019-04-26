

Let's test the app!

First, we'll need the application URL and setup a dictionary for random names

```
export insecure_app_url=$(kubectl describe service test-app | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
apt install -y wamerican
```{{execute}}

To list all pet messages:

`curl $insecure_app_url/pets`{{execute}}

To add a new message with a random name

`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $insecure_app_url/pet`{{execute}}

You can repeat the above actions to create & review multiple entries.
