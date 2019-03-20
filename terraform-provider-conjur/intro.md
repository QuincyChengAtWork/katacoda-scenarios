In this course, you will learn how to use **Terraform provider for Conjur** to retreive secrets from Conjur Open Source to Terraform.

We will make use Terraform to spin up a postgres database container.
A random password will be generated and stored in Conjur, and it will be retreived by the provider and inject to the the new postgres container as an environment variable (in this example, it will be the admin password)
