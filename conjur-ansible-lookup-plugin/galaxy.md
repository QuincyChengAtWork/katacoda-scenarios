
Install the Conjur role using the following syntax:

```
ansible-galaxy install cyberark.conjur-lookup-plugin
```{{execute}}

We will install the lookup plugin from the downloaded role

```
mkdir -p /usr/share/ansible/plugins/lookup
cp  /root/.ansible/roles/cyberark.conjur/lookup_plugins/retrieve_conjur_variable.py /usr/share/ansible/plugins/lookup
```{{execute}}
