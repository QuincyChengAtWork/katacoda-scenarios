
Let's deploy the backend database for the application

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
cat << EOF > pg.yml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: pg
  labels:
    app: secretless-backend
spec:
  serviceName: secretless-backend
  selector:
    matchLabels:
      app: secretless-backend
  template:
    metadata:
      labels:
        app: secretless-backend
    spec:
      securityContext:
        fsGroup: 999
      containers:
      - name: secretless-backend
        image: postgres:9.6
        imagePullPolicy: IfNotPresent
        ports:
          - containerPort: 5432
        env:
          - name: POSTGRES_DB
            value: postgres
          - name: POSTGRES_USER
            value: security_admin_user
          - name: POSTGRES_PASSWORD
            value: security_admin_password
        volumeMounts:
        - name: backend-certs
          mountPath: "/etc/certs/"
          readOnly: true
        args: ["-c", "ssl=on", "-c", "ssl_cert_file=/etc/certs/server.crt", "-c", "ssl_key_file=/etc/certs/server.key"]
      volumes:
      - name: backend-certs
        secret:
          secretName: secretless-backend-certs
          defaultMode: 384
EOF

kubectl apply -f pg.yml

kubectl get pods
```{{execute}}

```
cat << EOF > pg-service.yml
kind: Service
apiVersion: v1
metadata:
  name: secretless-backend
spec:
  selector:
    app: secretless-backend
  ports:
    - port: 5432
      targetPort: 5432
      nodePort: 30001
  type: NodePort

EOF
kubectl apply -f pg-service.yml
```{{execute}}

```
export SECURITY_ADMIN_USER=security_admin_user
export SECURITY_ADMIN_PASSWORD=security_admin_password
export REMOTE_DB_URL=$(minikube ip):30001

docker run --rm -it -e PGPASSWORD=${SECURITY_ADMIN_PASSWORD} postgres:9.6 \
  psql -U ${SECURITY_ADMIN_USER} "postgres://${REMOTE_DB_URL}/postgres" -c "\du"
```{{execute}}

```
  export SECURITY_ADMIN_USER=security_admin_user
  export SECURITY_ADMIN_PASSWORD=security_admin_password
  export REMOTE_DB_URL="$(minikube ip):30001"


  export APPLICATION_DB_NAME=quick_start_db

  export APPLICATION_DB_USER=app_user
  export APPLICATION_DB_INITIAL_PASSWORD=app_user_password


  docker run --rm -i -e PGPASSWORD=${SECURITY_ADMIN_PASSWORD} postgres:9.6 \
      psql -U ${SECURITY_ADMIN_USER} "postgres://${REMOTE_DB_URL}/postgres" \
      << EOSQL

  CREATE DATABASE ${APPLICATION_DB_NAME};

  /* connect to it */

  \c ${APPLICATION_DB_NAME};

  CREATE TABLE pets (
    id serial primary key,
    name varchar(256)
  );

  /* Create Application User */

  CREATE USER ${APPLICATION_DB_USER} PASSWORD '${APPLICATION_DB_INITIAL_PASSWORD}';

  /* Grant Permissions */

  GRANT SELECT, INSERT ON public.pets TO ${APPLICATION_DB_USER};
  GRANT USAGE, SELECT ON SEQUENCE public.pets_id_seq TO ${APPLICATION_DB_USER};

EOSQL
```{{execute}}
