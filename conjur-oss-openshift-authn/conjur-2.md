
Let's review the script by `cat ./2_initialize_conjur.sh`{{execute}}

In this step, we will now create an account in Conjur and get the admin key.

We will also configure /etc/hosts, such that conjur.demo.com will be the hostname of the newly created Conjur OSS.

To execute the script: `./2_initialize_conjur.sh`{{execute}}

If you found the admin is empty, or the script returns errors, that means the Conjur is still being initialized.

Please wait for a moment and retry.   Typical it should work within a minute.
