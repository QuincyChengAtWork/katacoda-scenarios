
### Review TF files

There are 3 Terraform files in this demo:

1. conjur.tf contains the path of secret in Conjur
2. docker.tf specifies the docker settings
3. postgre.tf specifies the database configuration, including the use of POSTGRE_PASSWORD environment variable

To review the files, execute `cat *.tf`{{execute}}

### Before

There are 3 running containers in the environment.
To verify, execute `docker ps`{{execute}}

### Apply!

```
terraform init
terraform apply
```{{execute}}


Terraform will apply the changes once you confirm:

```
...
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: 
```  
`yes`{{execute}}

You should be able to get a green successful message after execution

```
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

### After

An additional container is now up & running.
To verify, execute `docker ps`{{execute}}

To review the postgres database log, we can execute;

`docker logs postgres`{{execute}}
