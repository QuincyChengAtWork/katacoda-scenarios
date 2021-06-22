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

provider "conjur" {
  appliance_url = "http://localhost:8080"
  account = "demo"
}

