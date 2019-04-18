

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
export DEPLOY_MASTER_CLUSTER=true
```{{execute}}

### Check Dependencies

`./0_check_dependencies.sh`{{execute}}

### Create Test App Namespace

`./1_create_test_app_namespace.sh`{{execute}}

### Load Policies

`./2_load_conjur_policies.sh`{{execute}}

### Store Conjur Cert
```
kubectl delete --ignore-not-found=true configmap $TEST_APP_NAMESPACE_NAME
kubectl create configmap $TEST_APP_NAMESPACE_NAME --from-file=../conjur-quickstart.pem
```{{execute}}

### Build and Push containers

`./5_build_and_push_containers.sh`{{execute}}

### Deploy Test App

`./6_deploy_test_app.sh`{{execute}}

### Verify Authentication

`./7_verify_authentication.sh`{{execute}}
