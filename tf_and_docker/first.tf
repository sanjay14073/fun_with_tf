terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}

resource "docker_container" "my_container" {
  image = docker_image.ubuntu.image_id
  name  = "my_container"
  entrypoint = ["/bin/bash"]        
  command    = ["-c", "tail -f /dev/null"] 
}
