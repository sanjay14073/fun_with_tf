# Terraform Docker Configuration for NGINX with Multiple Ubuntu Containers

This Terraform configuration spins up a Docker environment with the following resources:
- Two Ubuntu containers (`my_container_1` and `my_container_2`) that share a volume.
- A custom NGINX container (`web_server`) configured to load balance between the two Ubuntu containers.
- A private Docker network (`my_network`) to connect the containers.
- A Docker volume (`my_volume`) shared between the containers.

## Prerequisites

1. Docker must be installed and running on the host machine.
2. Terraform must be installed.

## Files

- `main.tf`: Terraform configuration file defining the Docker images, containers, volumes, and networks.

## Resources

### Docker Images

- **Ubuntu**: The Ubuntu image (`ubuntu:latest`) is used for the two Ubuntu containers.
- **NGINX**: The NGINX image (`nginx:latest`) is used for the web server container.

### Docker Containers

1. **my_container_1**: An Ubuntu container running a bash shell with a `tail -f /dev/null` command to keep it running.
2. **my_container_2**: Another Ubuntu container running the same bash shell and command.
3. **web_server (NGINX)**: An NGINX web server that serves as a load balancer for the two Ubuntu containers.

### Docker Volume

- **my_volume**: A Docker volume shared between the two Ubuntu containers and the NGINX container for persistent data storage.

### Docker Network

- **my_network**: A private Docker network connecting all the containers to ensure communication between them.

## How It Works

1. **NGINX Load Balancer**: 
   The `web_server` (NGINX container) is configured to act as a load balancer between `my_container_1` and `my_container_2`. The containers are connected through the private network `my_network`. 
   
2. **Volume Sharing**: 
   Both Ubuntu containers (`my_container_1` and `my_container_2`) share the same volume (`my_volume`), which is also mounted to the NGINX container to allow custom NGINX configurations.

3. **Private Network**: 
   All containers are connected to a private Docker network (`my_network`), enabling internal communication between the containers.


