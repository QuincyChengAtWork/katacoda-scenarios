

Let's test the app again!

Again, we'll need the application URL and typically it points to `localhost`
On Katacoda, we have generated [an external link](https://[[HOST_SUBDOMAIN]]-8081-[[KATACODA_HOST]].environments.katacoda.com/pets) for you, so that you can access it remotely from internet.


```
export secure_app_url=https://[[HOST_SUBDOMAIN]]-8081-[[KATACODA_HOST]].environments.katacoda.com
```{{execute}}

To list all pet messages:

`curl $secure_app_url/pets`{{execute}}

To add a new message with a random name

`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $secure_app_url/pet`{{execute}}

You can repeat the above actions to create & review multiple entries.
