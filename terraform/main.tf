terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Build Docker image
resource "docker_image" "todo_image" {
  name         = "todo-puppet:v1"
  keep_locally = true

  build {
    context    = "../puppet"
    dockerfile = "Dockerfile"
  }
}

# Run container
resource "docker_container" "todo_container" {
  name  = "todo-web"
  image = docker_image.todo_image.image_id

  ports {
    internal = 3000
    external = 8082
  }

  restart = "no"
}
