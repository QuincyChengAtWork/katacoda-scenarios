
**Server**

`podman pod create -n conjur-oss --share net -p 8080:80`{{execute}}

`podman run --name database -d --pod conjur-oss --add-host conjur:127.0.0.1 --add-host database:127.0.0.1 docker.io/postgres:9.3`{{execute}}

`podman run --rm conjur data-key generate > data_key &&  export CONJUR_DATA_KEY="$(< data_key)”`{{execute}}

`podman run --name conjur -d --pod=conjur-oss -e CONJUR_DATA_KEY="$CONJUR_DATA_KEY" -e DATABASE_URL=postgres://postgres@database/postgres --add-host database:127.0.0.1  docker.io/cyberark/conjur server `{{execute}}

`podman exec conjur conjurctl account create quick-start | tee admin.out `{{execute}}

`export api_key="$(grep API admin.out | cut -d: -f2 | tr -d ' \r\n')"`{{execute}}

**Client**

`podman run --rm -it -v $(pwd)/mydata/:/root --entrypoint bash docker.io/cyberark/conjur-cli:5 -c "echo yes | conjur init -a quick-start -u https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/"`{{execute}}
`podman run --rm -it -v $(pwd)/mydata/:/root docker.io/cyberark/conjur-cli:5 authn login -u admin -p $api_key`{{execute}}
