
### Install Ansible 
```
echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get -y update 
apt-get -y install ansible 
```{{execute HOST1}}

### Verify that ansible 2.5.x or above has been installed 
`ansible --version`{{execute HOST1}}

### Get CDEMO 
`git clone https://github.com/conjurdemos/cdemo.git`

### Install tools
It will take a 10-15 minutes as the process involves downloading latest images
```
cd cdemo\conjurDemo
ansible-playbook -i inventory.yml site.yml
```{{execute}}




### Install Conjur OSS 
```
curl -o docker-compose.yml https://www.conjur.org/get-started/docker-compose.quickstart.yml 
docker-compose pull 
docker-compose run --no-deps --rm conjur data-key generate > data_key 
export CONJUR_DATA_KEY="$(< data_key)"
export CONJUR_ADMIN_API=secret 
docker-compose up -d 
docker-compose exec conjur conjurctl account create quick-start
```{{execute HOST1}}

