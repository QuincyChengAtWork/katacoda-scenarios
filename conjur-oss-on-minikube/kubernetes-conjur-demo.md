

### Get the source code

`git clone https://github.com/QuincyChengAtWork/kubernetes-conjur-demo.git`{{execute}}

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
For Enterprise version only.   
We can skip this step for Conjur OSS.
`./3_init_conjur_cert_authority.sh`{{execute}}

### Store Conjur Cert
`./4_store_conjur_cert.shh`{{execute}}

### Build and Push containers

`./5_build_and_push_containers.sh`{{execute}}

### Deploy Test App

`./6_deploy_test_app.sh`{{execute}}

### Verify Authentication

`./7_verify_authentication.sh`{{execute}}
