We will model a simple application in which a frontend service connects to a db server. The db policy defines a password, which the frontend application uses to log in to the database.

Here is a skeleton policy for this scenario, which simply defines two empty policies: db and frontend. Save this policy as “conjur.yml”:

<pre class="file" data-filename="conjur.yml" data-target="replace">- !policy
  id: db

- !policy
  id: frontend
</pre>

Then load it using the following command:

`docker-compose exec client -v .:. conjur policy load --replace root conjur.yml`{{execute}}

```
Loaded policy 'root'
{
  "created_roles": {
  },
  "version": 1
}
```


Use the conjur list command to view all the objects in the system:

`docker-compose exec client conjur list`{{execute}}
```
[
  "myorg:policy:root",
  "myorg:policy:db",
  "myorg:policy:frontend"
]
```
