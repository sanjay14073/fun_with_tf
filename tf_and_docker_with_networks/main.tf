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

resource "docker_volume" "new_volume" {
  name="my_volume"
}

resource "docker_network" "private_network" {
  name = "my_network"
  check_duplicate = true
  driver = "bridge"
  ingress = false
}


resource "docker_container" "new_container" {
    image = docker_image.ubuntu.image_id
    name  = "my_container"
    entrypoint = ["/bin/bash"]        
    command    = ["-c", "tail -f /dev/null"] 
    volumes {
       volume_name = docker_volume.new_volume.name
       container_path = "/mnt/my_volume"
       read_only      = false
    }
    networks_advanced {
      name = docker_network.private_network.name
    }
}