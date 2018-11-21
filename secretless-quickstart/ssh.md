The default SSH service is exposed over port 2221. You can try opening an SSH connection to the server, but you don't have the credentials to log in:

`ssh -p 2221 user@localhost`{{execute}}

`The authenticity of host '[localhost]:2221 ([127.0.0.1]:2221)' can't be established.
ECDSA key fingerprint is SHA256:FLnEsQ6aa1qEQopwywlWXI0LeNb04An72BThZZ8GNy8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[localhost]:2221' (ECDSA) to the list of known hosts.
Permission denied (publickey,keyboard-interactive).`


The good news is that you don't need credentials! You can establish an SSH connection through the Secretless Broker on port 2222 without any credentials. Give it a try:

`ssh -p 2222 user@localhost`{{execute}}

`The authenticity of host '[localhost]:2222 ([127.0.0.1]:2222)' can't be established.
RSA key fingerprint is SHA256:fSn95WSqzC9JpAdZNs3iAEuRQckQSts26dJM9Hqwwh8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[localhost]:2222' (RSA) to the list of known hosts.

You've established an SSH connection via Secretless!

Check out https://secretless.io for more information.

bdfe24ac8aaf:~$`
