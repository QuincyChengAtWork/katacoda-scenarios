

## Secretless Broker

Secrets are used to provide privileged access to protected resources.
The Secretless Broker pushes the trust boundary of secrets away from application code into a privileged process that's designed with security best practices in mind. The Secretless Broker provides a local interface for application code to transparently consume protected resources.

![Secretless Broker Architecture](https://github.com/cyberark/secretless-broker/blob/master/docs/img/secretless_architecture.svg)

## Usage: Secretless Broker as Sidecar

The Secretless Broker operates as a sidecar container within a kubernetes application pod. This means there is shared storage/network between the application container and the Secretless Broker. It is this which allows the Secretless Broker to provide a local interface.

In this tutorial, we will walk through creating an application that communicates
with a password-protected PostgreSQL database via the Secretless Broker. _The application
does not need to know anything about the credentials required to connect to the database;_
the admin super-user who provisions and configures the database will also configure the Secretless Broker
to be able to communicate with it. The developer writing the application only needs to
know the socket or address that the Secretless Broker is listening on to proxy the connection to the
PostgreSQL backend.

To accomplish this, we are going to do the following:

**As the admin super-user:**

1. Provision protected resources
1. Configure protected resources for usage by application and add credentials to a secret store
1. Configure the Secretless Broker to broker the connection using credentials from the secret store
1. Create application identity and grant entitlements to provide access to credentials from the secret store 

**As the application developer:**
1. Configure the application to connect to protected resource through the interface exposed by the Secretless Broker
1. Deploy and run the Secretless Broker adjacent to the application

## Quickstart

The tutorial uses an existing [pet store demo application](https://github.com/conjurdemos/pet-store-demo) that exposes the following routes:

- `GET /pets` to list all the pets in inventory
- `POST /pet` to add a pet
  - Requires **Content-Type: application/json** header and body that includes **name** data

There are additional routes that are also available, but these are the two that we will focus on for this tutorial.

Pet data is stored in a PostgreSQL database, and the application may be configured to connect to the database by setting the `DB_URL`, `DB_USERNAME`, and `DB_PASSWORD` environment variables in the application's environment (following [12-factor principles](https://12factor.net/)).

We are going to deploy the application with the Secretless Broker to Kubernetes, configure the Secretless Broker to be able to retrieve the credentials from a secrets store, and configure the application with the `DB_URL` environment variable pointing to the Secretless Broker _and no values set for the `DB_USERNAME` or `DB_PASSWORD` environment variables_.

