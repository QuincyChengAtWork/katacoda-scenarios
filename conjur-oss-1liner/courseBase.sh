#!/bin/sh
export USER=tutorial
cat >> /usr/sbin/sudo << EOF
#!/bin/sh
$*
EOF
chmod +x /usr/sbin/sudo
