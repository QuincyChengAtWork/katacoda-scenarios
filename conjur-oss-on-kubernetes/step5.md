### Steps for the non-privileged user (i.e. developer)

**Note:** None of these steps require the information in `admin_config.sh` - the person deploying the application needs to know _nothing_ about the secret values required to connect to the PostgreSQL database!!

#### 1. Configure application to access the database at `localhost:5432`

In the application manifest, we set the `DB_URL` environment variable to `localhost:5432`, so that when the application is deployed it will open the connection to the PostgreSQL backend via the Secretless Broker.

#### 2. Deploy application

To deploy the application with the Secretless Broker, run:
```bash
./03_deploy_app.sh
```
```
>>--- Create and store Secretless configuration
configmap/quick-start-application-secretless-config created
>>--- Start application
deployment.apps/quick-start-application created
service/quick-start-application created
Waiting for quick-start-application to be ready
...
Ready!
```

### Try it out!

That's it! You've configured your application to connect to PostgreSQL via the Secretless Broker, and we can try it out to validate that it's working as expected.
