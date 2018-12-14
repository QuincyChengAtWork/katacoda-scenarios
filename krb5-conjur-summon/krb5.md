We will make use of the host as the client and create a container as Kerberos KDC

### Setup Kerberos Server
Let's setup a Kerberos server on docker
`docker-compose -f docker-compose-krb5.yml up -d `{{execute}}


### Install Kerberos Client
Now install Kerberos client on the host

```
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y krb5-user
cp -f krb5.conf /etc/
```{{execute}}

### Verify if setup works
Let's try to logon as `admin/admin@CYBERARKDEMO.COM`

`kinit admin/admin@CYBERARKDEMO.COM`{{execute}}

Password for admin/admin@CYBERARKDEMO.COM:`5b1d328bc88b97356f406fab456b5a99`{{execute}}

To verify the logged on principal, we can execute  `klist`{{execute}}

```
Ticket cache: FILE:/tmp/krb5cc_0
Default principal: admin/admin@CYBERARKDEMO.COM

Valid starting       Expires              Service principal
2018-12-14 14:10:16  2018-12-15 02:10:16  krbtgt/CYBERARKDEMO.COM@CYBERARKDEMO.COM
        renew until 2018-12-21 14:10:05
```
