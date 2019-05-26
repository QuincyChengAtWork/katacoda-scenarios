

### Install Summon
Installing Summon is simple.  Simply download 2 files and summon is ready to go.

```
curl -OL https://github.com/cyberark/summon/releases/download/v0.6.9/summon-linux-amd64.tar.gz
tar zvxf summon-linux-amd64.tar.gz
cp -f summon /usr/local/bin/

curl -OL https://github.com/cyberark/summon-conjur/releases/download/v0.5.2/summon-conjur-linux-amd64.tar.gz
tar zvxf summon-conjur-linux-amd64.tar.gz 
mkdir /usr/local/lib/summon/
cp -f summon-conjur /usr/local/lib/summon/
```{{execute}}

### Install Postgres Client

```
apt-get -y -f install postgresql-client
```{{execute}}


### Review secrets.yml
To inject the password to Postgres client using Summon, `secrets.yml` file is needed.   

To review, execute `cat secrets.yml`{{execute}}

`PGPASSWORD: !var postgres/admin-password`

### Connect to Postgres DB using Summon

As we have exposed TCP port 5432 from postgres database, we can connect to it to by:

```
summon psql -h docker -U postgres
```{{execute}}

You should have logged in using the postgres database client without knowing the password! Cool!
