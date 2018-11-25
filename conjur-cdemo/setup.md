
### Install Ansible 
```
echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get -y update && \
apt-get -y install dirmngr ansible ruby ruby-dev python-pip && \
pip install --upgrade pip 
```{{execute HOST1}}

### Verify that ansible 2.5.x or above has been installed 
Run `ansible --version`{{execute HOST1}}

### Install ansible conjur module

`ansible-galaxy install cyberark.conjur-host-identity`{{execute HOST1}}

### Install Conjur OSS
```
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml 
docker-compose pull 
docker-compose run --no-deps --rm conjur data-key generate > data_key 
```{{execute HOST1}}

### Configure Conjur OSS
```
export CONJUR_DATA_KEY="$(< data_key)"
export CONJUR_ADMIN_API=secret 
docker-compose up -d 
docker-compose exec conjur conjurctl account create quick-start
```{{execute HOST1}}

