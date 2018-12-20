If you’re deploying Conjur in production, you need to set up Transport Layer Security so that requests made to the server are encrypted in transit.

*Note: if you use Conjur Enterprise, we handle this for you using an audited implementation that is similar to the technique described here.*

### First: A Brief Primer On Transport Layer Security (TLS) 
This gets at the heart of the issue we’re trying to address with this tutorial.

Suppose you install Conjur and make it available at `http://conjur.local`. Then you configure clients to fetch secrets from that address. When they [authenticate](https://www.conjur.org/api.html#authentication-authenticate-post) using the API, they provide their identity by sending their API key to the Conjur server. The Conjur server validates that the identity is authentic, then checks that the provided ID is authorized to [retrieve the secret](https://www.conjur.org/api.html#secrets-retrieve-a-secret-get). Assuming this check passes, the Conjur server returns the secret value to the client.

However, this flow would be vulnerable in two ways. Suppose I were to impersonate the Conjur server and listen with my own illegitimate server on `http://conjur.local`. Then when your client goes to fetch a secret, I can take the API key you send and impersonate you to the real Conjur server. Now I control your identity and can learn your secrets without you finding out. This is called a **man in the middle attack**.

Note: you can use access logs or Conjur Enterprise’s audit records to discover unexplained accesses after the fact, but to maintain proactive security there is no substitute for TLS.

Even if I’m not able to impersonate the Conjur server, I could still learn secrets by joining your network and listening for traffic coming and going from the Conjur server. This is called **passive surveillance**.

#### TLS defeats passive and active attacks
Transport Layer Security allows your client to verify that it’s talking to the real Conjur server, and it uses standard secure technology to encrypt your secrets in transit. This means:

Your Conjur server URL will begin with `https:` instead of `http:`, just like a secure website
Because the client can verify it’s talking to the real server, the “man in the middle” will be exposed and the client won’t leak any secret information
Since the traffic to and from Conjur is scrambled using secure encryption, passive listeners on your network can’t learn anything about the contents of your secrets
For these reasons, it is crucial to set up TLS correctly when you deploy Conjur.

#### Protect Your Secrets
Do not leave this to chance: even a small flaw can totally compromise your secrets. Setting up Conjur and TLS without the appropriate expertise is like packing your own parachute and jumping out of a plane.

That doesn’t mean you should close the tab and walk away. It means you should get in touch with us and your own security team so we can ensure that you can deploy Conjur successfully.

![ga](https://ga-beacon-226104.appspot.com/UA-131132287-1/conjur-nginx-proxy?pixel&useReferer)
