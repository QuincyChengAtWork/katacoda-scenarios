

The following steps would be taken by an admin-level user, who has the ability to create and configure a database and to add secret values to a secret store.

These steps make use of the **admin_config.sh** file, which stores the database connection info for the PostgreSQL backend.

### 1. Provision database

#### Provision protected resources

  **[Option 1] PostgreSQL inside k8s**

  Run the following script to deploy a PostgreSQL instance  using a **StatefulSet** in the **quick-start-backend-ns** namespace:


  `cd ~/secretless-broker/demos/k8s-demo/
  ./01_create_db.sh`{{execute}}

    ```
    >>--- Clean up quick-start-backend-ns namespace
    Error from server (NotFound): namespaces "quick-start-backend-ns" not found
    namespace/quick-start-backend-ns created
    Ready!
    >>--- Create database
    statefulset.apps/pg created
    service/quick-start-backend created
    Waiting for quick-start-backend to be ready
    ...
    Ready!
    CREATE DATABASE
    ```

  **[Option 2] Remote PostgreSQL server**

  + Ensure your Kubernetes cluster is able to access your remote DB.
  + Ensure the remote instance has a database called **quick_start_db**
  + Update the `DB_` env vars in **./admin_config.sh**. For example (with Amazon RDS):

    ```bash
    DB_URL=quick-start-backend-example.xyzjshd3bdk3.us-east-1.rds.amazonaws.com:5432/quick_start_db
    DB_ADMIN_USER=quick_start_db
    DB_ADMIN_PASSWORD=quick_start_db
    DB_USER=quick_start_user
    DB_INITIAL_PASSWORD=quick_start_user
    ```

#### 2. Configure database and add credentials to secret store

In this step, we will:

+ Configure the protected resources for usage by application (i.e. create DB user, add tables, etc.)
+ Add the application's access credentials for the database to a secret store

`cd ~/secretless-broker/demos/k8s-demo/
./02_configure_db.sh`{{execute}}

```
>>--- Set up database
CREATE ROLE
CREATE TABLE
GRANT
GRANT
>>--- Clean up quick-start-application-ns namespace
namespace/quick-start-application-ns created
Ready!
secret/quick-start-backend-credentials created
serviceaccount/quick-start-application created
role.rbac.authorization.k8s.io/quick-start-backend-credentials-reader created
rolebinding.rbac.authorization.k8s.io/read-quick-start-backend-credentials created
```

#### 3. Configure the Secretless Broker to broker the connection to the target service

In the last step, we added the database credentials to our secret store - so to configure the Secretless Broker to be able to retrieve these credentials and proxy the connection to the actual PostgreSQL database, we have written a [secretless.yml](/demos/k8s-demo/etc/secretless.yml) file that defines a PostgreSQL listener on port 5432 that uses the Kubernetes Secrets Provider to retrieve the credential values that we stored when we ran the last script:

To view the secretless.yml file: `cat ~/secretless-broker/demos/k8s-demo/etc/secretless.yml`{{execute}}

```yaml
listeners:
  - name: pets-pg-listener
    protocol: pg
    address: localhost:5432

handlers:
  - name: pets-pg-handler
    listener: pets-pg-listener
    credentials:
      - name: address
        provider: kubernetes
        id: quick-start-backend-credentials#address
      - name: username
        provider: kubernetes
        id: quick-start-backend-credentials#username
      - name: password
        provider: kubernetes
        id: quick-start-backend-credentials#password
```
