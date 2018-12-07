Here’s the outline of the tutorial flow. Read through the file to see what it does to accomplish each step.

- Pull required container images from Docker Hub
- Remove containers, certs and keys created in earlier tutorial runs (if any)
- Create a self-signed certificate and key for TLS
- Generate a data key for Conjur encryption of data at rest
  - Move this key to a safe place before deploying in production!
- Start services and wait a little while for them to become responsive
- Create a new account in Conjur and fetch its API key
  - [Rotate the admin’s API key](https://www.conjur.org/api.html#authentication-rotate-an-api-key) regularly!
- Configure the Conjur client and log in as admin
