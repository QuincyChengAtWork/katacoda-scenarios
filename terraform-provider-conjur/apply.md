
There are 3 Terraform files in this demo:

1. conjur.tf contains the path of secret in Conjur
2. docker.tf specifies the docker settings
3. postgre.tf specifies the database configuration, including the use of POSTGRE_PASSWORD environment variable



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
