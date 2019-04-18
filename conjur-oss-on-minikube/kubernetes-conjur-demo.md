

### Get the source code

`git clone https://github.com/conjurdemos/kubernetes-conjur-demo.git`{{execute}}

`cd kubernetes-conjur-demo`{{execute}}

### Setup Environment Variables

```
export TEST_APP_NAMESPACE_NAME=test-app
export TEST_APP_DATABASE=postgres
export CONJUR_NAMESPACE_NAME=default
export CONJUR_ACCOUNT=quickstart
export AUTHENTICATOR_ID=authn
export DOCKER_REGISTRY_PATH=$(minikube ip):5000
export DOCKER_REGISTRY_URL=$(minikube ip):5000
export CONJUR_MAJOR_VERSION=5
export CONJUR_ADMIN_PASSWORD=$(grep API ../admin.out | cut -d: -f2 | tr -d ' \r\n')
```{{execute}}

`./0_check_dependencies.sh`{{execute}}

`./1_create_test_app_namespace.sh`{{execute}}

```
cat >conjur-cli.yml<<EOF
---
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: conjur-cli
  labels:
    app: conjur-cli
spec:
  replicas: 1
  selector:
    matchLabels:
      app: conjur-cli
  template:
    metadata:
      name: conjur-cli
      labels:
        app: conjur-cli
    spec:
      containers:
      - name: conjur-cli
        image: cyberark/conjur-cli:5
        imagePullPolicy: IfNotPresent
        command: ["sleep"]
        args: ["infinity"]
      imagePullSecrets:
        - name: dockerpullsecret
EOF
kubectl create -f conjur-cli.yml
```{{execute}}

`.\2_load_conjur_policies.sh`{{execute}}


```
kubectl get pods --selector app=conjur-cli --no-headers | awk '{ print $1 }')
echo $pod_list | awk '{print $1}'
```{{execute}}
