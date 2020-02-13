
Now, let us "think like an hacker" and review the files

Can you find the service account's embedded secrets?

Try the following command:

`grep DB_PASSWORD insecure-*`{{execute}}

Cool! You have found the service accounts.   
Apparently it is far from ideal and definately not secure.

Click "Continue" to start securing it. 
