
Now, let us "think like an hacker" and review the files

Can you find the service account's embedded secrets?

Try the following command:

`grep DB_PASSWORD insecure-*`{{execute}}

Cool! You have found the service accounts.   Apparently it is far from ideal and definately not secure.

Let's clean up the environment before proceed
```
docker-compose -f insecure-app.docker-compose.yml down
echo y | docker volume prune
```{{execute}}

Click "Continue" to start securing it. 
