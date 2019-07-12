
Let's test the app

# Listing items
```
export secretless_app_url=$(kubectl describe service test-app-secretless | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
```{{execute}}

```
curl $secretless_app_url/pets
```{{execute}}


# Add an item

```
curl  -d "{\"name\": \"$(shuf -n 1 /usr/share/dict/american-english)\"}" -H "Content-Type: application/json" $secretless_app_url/pet
```{{execute}}
