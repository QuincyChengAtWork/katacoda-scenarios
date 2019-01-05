*Katacoda platform has provided a SSL protected access for accessing Conjur by default.*  
*Please follow the steps below if you are using your own lab environment*

The Conjur SSL certificate is required on the Jenkins host to enable calls to the Conjur API. The following steps obtain the certificate from Conjur and put in the correct location on Jenkins.

1. Copy the conjur.pem file and store it in a location accessible to the Jenkins host.

The conjur.pem file must come from the Conjur master container. Typically, it is located here: 
 	
`/opt/conjur/etc/ssl/conjur.pem`

You do not need the conjur.key file.

2. Import the conjur.pem file into the Jenkins keystore.

On the Jenkins host command line (e.g., in the container if Jenkins is running as a container), use the following command:

`keytool -import -alias conjur -keystore /docker-java-home/jre/lib/security/cacerts -file /conjur.pem`
