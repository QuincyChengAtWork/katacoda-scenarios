
Let's install PostgreSQL database client

`apt-get -y update
apt-get install postgresql-client -y`{{execute}}

Direct access to the PostgreSQL database is available over port 5432. You can try querying some data, but you don't have the credentials required to connect (even if you know the username):

`psql \
--host localhost \
--port 5432 \
--set=sslmode=disable \
--username secretless \
-d quickstart \
-c 'select * from counties;'`{{execute}}

```
Password for user secretless:
psql: FATAL:  password authentication failed for user "secretless"
```

The good news is that you don't need any credentials! Instead, you can connect to the password-protected PostgreSQL database via the Secretless Broker on port 5454, without knowing the password. Give it a try:

`psql \
--host localhost \
--port 5454 \
--set=sslmode=disable \
--username secretless \
-d quickstart \
-c 'select * from counties;'`{{execute}}

```
id |    name
----+------------
 1 | Middlesex
 2 | Worcester
 3 | Essex
 4 | Suffolk
 5 | Norfolk
 6 | Bristol
 7 | Plymouth
 8 | Hampden
 9 | Barnstable
10 | Hampshire
11 | Berkshire
12 | Franklin
13 | Dukes
14 | Nantucket
(14 rows)
```
