#!/bin/bash
set -euo pipefail

. utils.sh

announce "Building and pushing test app images."

readonly APPS=(
  "init"
  "sidecar"
)

pushd test_app_summon
  for app_type in "${APPS[@]}"; do
    # prep secrets.yml
    sed -e "s#{{ TEST_APP_NAME }}#test-summon-$app_type-app#g" ./secrets.template.yml > secrets.yml

    dockerfile="Dockerfile"
    if [[ "$PLATFORM" == "openshift" ]]; then
      dockerfile="Dockerfile.oc"
    fi

    echo "Building test app image"
    docker build \
      -t test-app:$CONJUR_NAMESPACE_NAME \
      -f $dockerfile .

    test_app_image=$(platform_image "test-$app_type-app")
    docker tag test-app:$CONJUR_NAMESPACE_NAME $test_app_image
  done
popd

# If in Kubernetes, build custom pg image
if [[ "$PLATFORM" != "openshift" ]]; then
  pushd pg
    docker build -t test-app-pg:$CONJUR_NAMESPACE_NAME .
    test_app_pg_image=$(platform_image test-app-pg)
    docker tag test-app-pg:$CONJUR_NAMESPACE_NAME $test_app_pg_image

  popd
fi

if [[ "$LOCAL_AUTHENTICATOR" == "true" ]]; then
  # Re-tag the locally-built conjur-authn-k8s-client:dev image
  authn_image=$(platform_image conjur-authn-k8s-client)
  docker tag conjur-authn-k8s-client:dev $authn_image

  # Re-tag the locally-built secretless-broker:latest image
  secretless_image=$(platform_image secretless-broker)
  docker tag secretless-broker:latest $secretless_image
fi
