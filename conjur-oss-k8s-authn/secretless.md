
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


TEST:

```
export secretless_app_url=$(kubectl describe service test-app-secretless | grep 'LoadBalancer Ingress' | awk '{ print $3 }'):8080
```{{execute}}

```
curl $secretless_app_url/pet
```{{execute}}
