This file describes to `openssl` what options to use when generating a self-signed certificate. This allows you to use TLS in testing and staging, but it does not allow clients to automatically authenticate the identity of the Conjur server.

#### Production tip
Don’t use a self-signed certificate in production. It’s better than nothing, but it’s not a sustainable security practice because you’re going to have to manually verify that you’re not talking to a man in the middle.

Instead, ask your security team to provide a certificate signed by a trusted root and use that instead.

**Modifying tls.conf for development use**
These are blocks that you might want to change:

```
[ dn ]
C=US
ST=Wisconsin
L=Madison
O=CyberArk
OU=Onyx
CN=proxy
```
This block describes the distinguished name of the certificate using the (C)ountry, (ST)ate, (L)ocation, (O)rganization, (O)rganizational (U)nit, and (C)ommon (N)ame. You’ll want to change all these to suit your own organization.

```
[ alt_names ]
DNS.1 = localhost
DNS.2 = proxy
IP.1 = 127.0.0.1
This block describes the names by which the server will be known, including its hostnames and IP addresses. You’ll want to modify it to match the hostnames and IP addresses you use.
```

