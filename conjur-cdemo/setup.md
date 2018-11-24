
### Install Ansible
```
installAnsible.sh
```
It has been installed for you in this tutorial

### Verify that ansible 2.5.x has been installed 
Run `ansible --version`{{execute}}
 
### Change directory to conjurDemo.
`cd ~/cdemo/conjurDemo`{{execute}}

### Update config files (optional)
Edit inventory.yml to include any machines to be stood up as demo machines.
Edit site.yml to change which tools are installed. 
Set each tool variable to 'YES' for it to be installed automatically. Set to 'NO' for it to be skipped.

### Install demo
Run `sudo ansible-playbook -i inventory.yml site.yml`{{execute}} to install conjur and it's tools.

Conjur alone can be configured by running sudo ansible-playbook -i inventory.yml conjurSetup.yml
Ansible with PAS jobs can be deployed by setting the variable "ansible_pas: 'YES'" in site.yml
