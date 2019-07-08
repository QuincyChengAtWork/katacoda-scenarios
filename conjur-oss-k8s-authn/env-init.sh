git clone https://github.com/QuincyChengAtWork/conjur-oss-k8s-authn-katacoda.git
#cd conjur-oss-k8s-authn-katacoda

wget https://github.com/QuincyChengAtWork/conjur-oss-k8s-authn-katacoda/archive/v1.0.zip
unzip v1.0.zip

cp conjur-oss-k8s-authn-katacoda/policy/host-policy.yml conjur-oss-k8s-authn-katacoda-1.0/policy/
cp conjur-oss-k8s-authn-katacoda/policy/host-entitlement.yml conjur-oss-k8s-authn-katacoda-1.0/policy/
cp conjur-oss-k8s-authn-katacoda/policy/app-access2.yml conjur-oss-k8s-authn-katacoda-1.0/policy/


cp conjur-oss-k8s-authn-katacoda/test-app/secretless.yml conjur-oss-k8s-authn-katacoda-1.0/test-app/
cp conjur-oss-k8s-authn-katacoda/test-app/manifest-secretless.yml conjur-oss-k8s-authn-katacoda-1.0/test-app/
cp conjur-oss-k8s-authn-katacoda/test-app/pg/secretless-pg.yml conjur-oss-k8s-authn-katacoda-1.0/test-app/pg/



cd conjur-oss-k8s-authn-katacoda-1.0/

clear
