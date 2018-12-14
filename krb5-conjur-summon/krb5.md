### Setup Kerberos Server
Let's setup a Kerberos server on docker
`./setupKrb5.sh`{{execute}}



### Install Kerberos Client

```
apt-get update
apt-get install -y krb5-user
cp -f krb5.conf /etc/
```{{execute}}

### Verify if setup works
`kinit admin/admin@CYBERARKDEMO.COM`{{execute}}
`password: ``5b1d328bc88b97356f406fab456b5a99`{{execute}}

