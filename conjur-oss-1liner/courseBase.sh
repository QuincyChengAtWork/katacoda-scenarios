#!/bin/sh
export USER=tutorial
cat >> /usr/sbin/sudo << EOF
#!/bin/sh
$*
EOF
chmod +x /usr/sbin/sudo
clear && printf "\033[0;32mSystem ready! Let's get started.\033[0m"
