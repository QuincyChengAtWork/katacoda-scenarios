
Install the Conjur role using the following syntax:

```
ansible-galaxy install cyberark.conjur
mkdir /usr/share/ansible/plugins/lookup
cp  /root/.ansible/roles/cyberark.conjur/lookup_plugins/retrieve_conjur_variable.py /usr/share/ansible/plugins/lookup
```{{execute}}
