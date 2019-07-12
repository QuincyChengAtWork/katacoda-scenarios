
# Update Conjur Policy & Variable

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 policy load root /root/policy/app-access2.yml
```{{execute}}

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 variable values add orquestador-ajustadores-app/secretless-url "secretless-backend.orquestador.svc.cluster.local:5432"
```{{execute}}

```
  docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 variable values add orquestador-ajustadores-app/secretless-username "app_user"
```{{execute}}

```
docker run --rm -it --add-host conjur.demo.com:$SERVICE_IP -v $(pwd)/mydata/:/root cyberark/conjur-cli:5 variable values add orquestador-ajustadores-app/secretless-password "app_user_password"
```{{execute}}
