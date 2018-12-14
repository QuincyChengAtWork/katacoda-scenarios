### Create a new User Principle

`kadmin`{{execute}}
Password: `5b1d328bc88b97356f406fab456b5a99`{{execute}}

`ank -policy users quincy`{{execute}}
Password for quincy@CYBERARKDEMO.COM: `d02742206e656fbaa1d33d11b104bb4f`{{execute}}

### Create a keytab file

`ktutil`{{execute}}

`addent -password -p quincy@CYBERARKDEMO.COM -k 1 -e aes256-cts-hmac-sha1-96`{{execute}}

`wkt user.keytab`{{execute}}

`quit`{{execute}}

### Verify the keytab file

Let's try to logon to KDC using the newly created keytab file.  No errors should be shown.

`kinit quincy@CYBERARKDEMO.COM -k -t user.keytab`{{execute}}
