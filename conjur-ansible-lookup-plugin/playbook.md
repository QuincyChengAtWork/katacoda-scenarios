
## "retrieve_conjur_variable" lookup plugin

Conjur's retrieve_conjur_variable lookup plugin provides a means for retrieving secrets from Conjur for use in playbooks.

Note that by default the lookup plugin uses the Conjur 5 API to retrieve secrets. To use Conjur 4 API, set an environment CONJUR_VERSION="4".

Since lookup plugins run in the Ansible host machine, the identity that will be used for retrieving secrets are those of the Ansible host. Thus, the Ansible host requires elevated privileges, access to all secrets that a remote node may need.

The lookup plugin can be invoked in the playbook's scope as well as in a task's scope.

## Example Playbook

Using environment variables:

```
export CONJUR_ACCOUNT="demo"
export CONJUR_APPLIANCE_URL="https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/"
export CONJUR_AUTHN_LOGIN="host/ansible/ansible-01"
export CONJUR_AUTHN_API_KEY="$(tail -n +2 ansible.out | jq -r '.created_roles."quick-start:host:ansible/ansible-01".api_key')"
```{{execute}}

Let's create a sample playbook
```
cat > playbook.yml << EOF
- hosts: 127.0.0.1
  connection: local
  tasks:
    - name: Retrieve secret with master identity
      vars:
        super_secret_key: "{{ lookup('retrieve_conjur_variable', 'db/dbpass') }}"
      shell: echo "Yay! {{super_secret_key}} was just retrieved with Conjur"
      register: foo
    - debug: msg="the echo was {{ foo.stdout }}"
EOF
```{{execute}}

To execute the playbook:

`ansible-playbook playbook.yml`{{execute}}


