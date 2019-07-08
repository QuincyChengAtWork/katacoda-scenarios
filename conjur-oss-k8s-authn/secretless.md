

# Deploy PostgresSQL 

```
openssl req -new -x509 -days 365 -nodes -text -out server.crt \
  -keyout server.key -subj "/CN=pg"
chmod og-rwx server.key
```{{execute}}

```
kubectl create secret generic \
  secretless-backend-certs \
  --from-file=server.crt \
  --from-file=server.key
```{{execute}}

```
sed -e "s#{{ TEST_APP_PG_DOCKER_IMAGE }}#$test_app_pg_image#g" ./test-app/pg/secretless-pg.yml |
  sed -e "s#{{ TEST_APP_NAMESPACE_NAME }}#$TEST_APP_NAMESPACE_NAME#g" |
  kubectl create -f -
```{{execute}}


# Update Conjur Policy & Variable

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 policy load root /root/policy/app-access2.yml
```{{execute}}

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 variable values add orquestador-ajustadores-app/secretless-url "secretless-backend.orquestador.svc.cluster.local:5432"
```{{execute}}

# Deploy Secretless App

```
export SERVICE_IP=$(kubectl get svc --namespace conjur \
      conjur-oss-ingress \
      -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
```{{execute}}

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP \
-v $(pwd)/mydata/:/root cyberark/conjur-cli:5 \
policy load conjur/authn-k8s/dev/apps /root/policy/host-policy.yml
```{{execute}}

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP \
-v $(pwd)/mydata/:/root cyberark/conjur-cli:5 \
policy load root /root/policy/host-entitlement.yml
```{{execute}}


```
kubectl create configmap secretless-config --from-file=test-app/secretless.yml
```{{execute}}


```
  export conjur_authenticator_url=$CONJUR_URL/authn-k8s/$AUTHENTICATOR_ID
  sed -e "s#{{ CONJUR_ACCOUNT }}#$CONJUR_ACCOUNT#g"  ./test-app/manifest-secretless.yml |
  sed -e "s#{{ CONJUR_APPLIANCE_URL }}#$CONJUR_URL#g" |
  sed -e "s#{{ CONJUR_AUTHN_URL }}#$conjur_authenticator_url#g" |
  sed -e "s#{{ SERVICE_IP }}#$SERVICE_IP#g" |
  kubectl create -f -
```{{execute}}


## Test the app

```
export secretless_app_url=$(kubectl describe service test-app-secretless | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
```{{execute}}

```
curl $secretless_app_url/pet
```{{execute}}
