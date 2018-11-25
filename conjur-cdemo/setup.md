
### Install Ansible & other dependencies
```
apt-get -y update && \
apt-get -y install dirmngr ansible ruby ruby-dev python-pip && \
pip install --upgrade pip 
```{{execute}}

### Verify that ansible 2.5.x has been installed 
Run `ansible --version`{{execute}}

### Pull the docker images (optional)

```
docker pull cyberark/conjur && \
docker pull cyberark/conjur-cli:5-6.1.0 && \
docker pull postgres:9.3
```{{execute}}

### Create Playbook
<pre class="file" data-filename="katacoda.yml" data-target="replace">---
- import_playbook: toolSetup.yml
  vars:
   weavescope_install: 'YES'
   gogs_install: 'YES'
   jenkins_install: 'YES'
   ansible_install: 'YES'
   ansible_pas: 'NO'
   splunk_install: 'NO'
</pre>


### Install Conjur OSS
```
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml && \
docker-compose pull && \
docker-compose run --no-deps --rm conjur data-key generate > data_key && \
export CONJUR_DATA_KEY="$(< data_key) && \
export CONJUR_ADMIN_PASSWORD=secret && \
docker-compose up -d && \
docker-compose exec conjur conjurctl account create quick-start
```{{execute}}

The Admin password is <pre class="file" data-target="clipboard">secret</pre>


### Change directory to conjurDemo.
`cd cdemo/conjurDemo`{{execute}}

### Update config files (optional)
 - Edit inventory.yml to include any machines to be stood up as demo machines.
 - Edit site.yml to change which tools are installed. 
 - Set each tool variable to 'YES' for it to be installed automatically. Set to 'NO' for it to be skipped.

### Install demo
Run `ansible-playbook -i inventory.yml katacoda.yml`{{execute}} to install conjur and it's tools.

Conjur alone can be configured by running sudo ansible-playbook -i inventory.yml conjurSetup.yml
Ansible with PAS jobs can be deployed by setting the variable "ansible_pas: 'YES'" in site.yml
