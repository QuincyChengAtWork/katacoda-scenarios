
## "retrieve_conjur_variable" lookup plugin

Conjur's retrieve_conjur_variable lookup plugin provides a means for retrieving secrets from Conjur for use in playbooks.

Note that by default the lookup plugin uses the Conjur 5 API to retrieve secrets. To use Conjur 4 API, set an environment CONJUR_VERSION="4".

Since lookup plugins run in the Ansible host machine, the identity that will be used for retrieving secrets are those of the Ansible host. Thus, the Ansible host requires elevated privileges, access to all secrets that a remote node may need.

The lookup plugin can be invoked in the playbook's scope as well as in a task's scope.

## Example Playbook

Using environment variables:

```
export CONJUR_ACCOUNT="orgaccount"
export CONJUR_VERSION="4"
export CONJUR_APPLIANCE_URL="https://conjur-appliance"
export CONJUR_CERT_FILE="/path/to/conjur_certficate_file"
export CONJUR_AUTHN_LOGIN="host/host_indentity"
export CONJUR_AUTHN_API_KEY="host API Key"
```{{execute}}

Let's create a sample playbook
```
cat > playbook.yml << EOF
- hosts: 127.0.0.1
  connection: local
  vars:
    super_secret_key: {{ lookup('retrieve_conjur_variable', 'path/to/secret') }}
  tasks:
    - name: Retrieve secret with master identity
      vars:
        super_secret_key: {{ lookup('retrieve_conjur_variable', 'path/to/secret') }}
      shell: echo "Yay! {{super_secret_key}} was just retrieved with Conjur"
      register: foo
    - debug: msg="the echo was {{ foo.stdout }}"
EOF
```{{execute}}

To execute the playbook:

`ansible-playbook playbook.yml`{{execute}}


