

### No more embedded secrets

The application doesn't have any embedded secrets.

Check it out: `cat ./test-app/test-app-conjur.yml`{{execute}}

The kubernetes authenicator will inject an identity to the application.   By using a short-lived access token, which rotates every 5 mins, we can make sure the app secrets is secured.

To review the access token:

`kubectl ...`{{execute}}
