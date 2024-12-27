terraform {
  required_providers {
    docker={
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

resource "docker_image" "nginx" {
  name = "nginx:latest"
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

##First container spinning up
resource "docker_container" "new_container_1" {
    image = docker_image.ubuntu.image_id
    name  = "my_container_1"
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

##Second container spinning up binded to same volume
resource "docker_container" "new_container_2" {
    image = docker_image.ubuntu.image_id
    name  = "my_container_2"
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

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "web_server"

  networks_advanced {
    name = docker_network.private_network.name
  }

  # Mount a custom NGINX configuration file
  volumes {
    volume_name    = docker_volume.new_volume.name
    container_path = "/etc/nginx/conf.d"
    read_only      = false
  }

  # Use environment variables to pass in NGINX configuration
  env = [
    "UPSTREAM_HOST_1=${docker_container.new_container_1.name}",
    "UPSTREAM_HOST_2=${docker_container.new_container_2.name}"
  ]
}