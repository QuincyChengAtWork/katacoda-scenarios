
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
`git clone https://github.com/conjurdemos/cdemo.git`{{execute}}

### Install tools
It will take a 10-15 minutes as the process involves downloading latest images
```
cd cdemo/conjurDemo
ansible-playbook -i inventory.yml site.yml --extra-vars "conjur_OSS_url=https://[[HOST_SUBDOMAIN]]-81-[[KATACODA_HOST]].environments.katacoda.com/ gogs_external_url=https://[[HOST_SUBDOMAIN]]-10080-[[KATACODA_HOST]].environments.katacoda.com/ jenkins_external_url=https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/    "
```{{execute}}

If you plan to deploy CDEMO on your own environment, you can simple execute:
```
cd cdemo\conjurDemo
ansible-playbook -i inventory.yml site.yml
```



