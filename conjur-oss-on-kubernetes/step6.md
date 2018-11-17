
That's it! You've configured your application to connect to PostgreSQL via the Secretless Broker, and we can try it out to validate that it's working as expected.

#### Use the pet store app

`POST /pet` to add a pet - the request must include `name` in the JSON body

`APPLICATION_URL=$(. ./admin_config.sh; echo ${APPLICATION_URL})
curl \
  -i \
  -d '{"name": "Mr. Snuggles"}' \
  -H "Content-Type: application/json" \
  ${APPLICATION_URL}/pet`{{execute}}

```bash
HTTP/1.1 201 
Location: http://192.168.99.100:30002/pet/1
Content-Length: 0
Date: Thu, 23 Aug 2018 12:57:45 GMT
```

`GET /pets` to retrieve notes

`APPLICATION_URL=$(. ./admin_config.sh; echo ${APPLICATION_URL})
curl -i ${APPLICATION_URL}/pets`{{execute}}

```
HTTP/1.1 200 
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Date: Thu, 23 Aug 2018 12:58:16 GMT

[{"id":1,"name":"Mr. Snuggles"}]
```

#### Rotate application database credentials

In addition to the demo you've seen so far, you can also **rotate the DB credentials** and watch the app continue to perform as expected.

The rotator script:
 + Rotates the credentials in the database
 + Updates the password in the secrets store
 + Prunes previously open connections

To see graceful rotation in action, poll the endpoint to retrieve the list of pets (`GET /pets`) in a separate terminal before rotating:

`APPLICATION_URL=$(. ./admin_config.sh; echo ${APPLICATION_URL})
while true
do
    echo "Retrieving pets"
    curl -i ${APPLICATION_URL}/pets
    echo ""
    echo ""
    echo "..."
    echo ""
    sleep 3
done`{{execute}}

```
Retrieving pets
HTTP/1.1 200 
Content-Type: application/json;charset=UTF-8
Transfer-Encoding: chunked
Date: Thu, 23 Aug 2018 12:58:43 GMT

[{"id":1,"name":"Mr. Snuggles"}]

...
.
.
.
```
To rotate the database password (note: you are acting as an admin user), run the following with a random value for `[new password value]`:

`./rotate_password.sh $(dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev)`{{execute}}

```
ALTER ROLE
secret/quick-start-backend-credentials patched
 pg_terminate_backend 
----------------------
 t
 t
 t
 .
 .
 .
(30 rows)

```

Observe that requests to the application API are not affected by the password rotation - we continue to be able to query the application as usual, without interruption!

## Conclusion

If you enjoyed this Secretless Broker tutorial, please try to make it your own by trying out some of the [suggested modifications](#suggested-modifications-for-advanced-demos). Please also let us know what you think of it! You can submit [Github issues](https://github.com/cyberark/secretless-broker/issues) for features you would like to see, or send a message to our [mailing list](https://groups.google.com/forum/#!forum/secretless) with comments and/or questions.
