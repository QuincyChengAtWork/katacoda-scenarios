For testing purposes the command below will generate a self-signed certificate for the domain **cyberarkdemo.com**
This self-signed will cause warning messages about the certificate but ideal for testing configuration locally. 

When deploying into production, you will need certificates generated for your site from a service such as Let’s Encrypt.

### Generate Certificate
The command below creates a new certificate and key within a directory calls certs/. It sets the domain to **cyberarkdemo.com**

```
mkdir certs; cd certs; 
openssl req -nodes -new -x509 \
  -keyout cyberarkdemo-com.key -out cyberarkdemo-com.crt \
  -days 365 \
  -subj '/CN=cyberarkdemo.com/O=CyberArk Demo/C=US'; 
cd -
```{{execute}}

### Securing & Redirecting HTTP Traffic
To secure HTTP traffic the addition of a tls_context is required as a filter. The TLS context provides the ability to specify a collection of certificates for the domains configured within Envoy Proxy. When an HTTPS request is being processed, the matching certificate will be used.

With the TLS Context defined, the site will be able to serve traffic over HTTPS. If a user happens to land on the HTTP version of the site, we want them to redirect them to the HTTPS version to ensure they are secure.

Let's prepare the configuration file:

```
sed "s/THECONJURIP/$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' root_conjur_1)/" envoy.yaml.template > envoy.yaml
cat envoy.yaml
```{{execute}}

### Start Envoy
```
docker run -d --name proxy1 -p 80:8080 -p 443:8443 -p 8001:8001 -v /root/:/etc/envoy/ envoyproxy/envoy
docker network connect root_default proxy1
```{{execute}}

### Testing Configuration
With the Proxy started, it's possible to test the configuration.

First, if we issue a HTTP request the Proxy should return a redirect response to the HTTPS version due to our configuration flag.

```
curl -H "Host: cyberarkdemo.com" http://localhost -i
```{{execute}}

HTTPS requests will be handled according to our configuration.

```
curl -k -H "Host: cyberarkdemo.com" https://localhost/service/1 -i
```{{execute}}

```
curl -k -H "Host: cyberarkdemo.com" https://localhost/service/2 -i
```{{execute}}

```
curl -k -H "Host: conjurdemo.org" https://localhost/ -i
```{{execute}}


Note, without -k argument, cURL will respond with an error due to the self-signed certificate.

```
curl -H "Host: example.com" https://localhost/service/2 -i
```{{execute}}

### Verify Certificate
Using OpenSSL CLI it's possible to view the certificate returned from a server. This will allow us to verify the correct certificate is being returned from Envoy.

```
echo | openssl s_client -showcerts -servername cyberarkdemo.com -connect localhost:443 2>/dev/null | openssl x509 -inform pem -noout -text
```{{execute}}

### Dashboard
The dashboard returns information about the certificates defined and their age. More information can be discovered at https://[[HOST_SUBDOMAIN]]-8001-[[KATACODA_HOST]].environments.katacoda.com/certs
