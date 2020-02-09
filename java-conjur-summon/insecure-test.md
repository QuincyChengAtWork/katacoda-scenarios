
Let's test the app!

First, we'll need the application URL and setup a dictionary for random names.
Typically the URL can point to `localhost`
On Katacoda, we have generated [an external link](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/pets) for you, so that you can access it remotely from internet.


```
export insecure_app_url=https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com
apt install -y wamerican
```{{execute}}

To list all pet messages:

`curl $insecure_app_url/pets`{{execute}}

To add a new message with a random name

`curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $insecure_app_url/pet`{{execute}}

You can repeat the above actions to create & review multiple entries.
