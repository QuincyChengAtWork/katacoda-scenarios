#!/bin/sh
cat > /usr/sbin/sudo << EOF
#!/bin/sh
\$*
EOF
chmod +x /usr/sbin/sudo
clear && printf "\033[0;32mSetting up the system.  Please wait...\033[0m\n"
apt-get install dialog 
export USER=root
clear && printf "\033[0;32mSystem ready! Let's get started.\033[0m\n"
