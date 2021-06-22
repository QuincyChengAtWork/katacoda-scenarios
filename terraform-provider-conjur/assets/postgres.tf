data "conjur_secret" "admin-password" {
   name = "postgres/admin-password"
}

resource "docker_image" "postgres" {
  name = "postgres:9.3"
}

resource "docker_container" "postgres" {
  name = "postgres"
  image = "${docker_image.postgres.latest}"
  env = ["POSTGRES_PASSWORD=${data.conjur_secret.admin-password.value}"]
  networks = ["${docker_network.demo.name}"]
  ports {
    internal = 5432
    external = 5432
  }
}

