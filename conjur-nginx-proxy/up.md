Now that we’ve got a TLS endpoint for our Conjur server, you can check it with your web browser.

The status page is available at https://localhost:8443 but your browser will warn you about the self-signed certificate. To override the warning and see the page, you’ll have to instruct your browser to trust the certificate. Once you switch to using your own certificate, the browser warning will go away automatically.

In this course, the status page is avaliable at  https://[[HOST_SUBDOMAIN]]-8443-[[KATACODA_HOST]].environments.katacoda.com/ with a valid certificate without any warning prompted by the your web browser.
