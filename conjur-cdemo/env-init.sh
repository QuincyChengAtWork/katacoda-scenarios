git clone https://github.com/conjurdemos/cdemo.git

apt-get update -y
apt-get install dirmngr -y
echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
apt-get update -y
#apt-get upgrade -y

apt-get install ansible -y
