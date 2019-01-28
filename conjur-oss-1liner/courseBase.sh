#!/bin/bash
export USER=tutorial
CAT >> /usr/sbin/sudo << EOF
#!/bin/sh
$*
EOF
chmod +x /usr/sbin/sudo
