terraform {
 required_providers {
   conjur = {
     source  = "local/cyberark/conjur"
     version = "0.5.0"
   }
   docker = {
     source  = "kreuzwerker/docker"
     version = "2.11.0"
   }
 }
}

provider "conjur" {}

data "conjur_secret" "admin-password" {
   name = "postgres/admin-password"
}
