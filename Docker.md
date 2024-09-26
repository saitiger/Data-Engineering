Why Docker ?
- Virtualization software that makes developing and deploying applications much easier.
- Language and OS agnostic
- Conflict resolution 

Image & Containers :
Images act as an operating system while container is like a machine where the code runs isolated from the outer environment.
Images are read-only templates containing instructions for creating a container. A Docker image creates containers to run on the Docker platform.

- One Image can be run on multiple instances of Containers. Containers are mutually isolated. Data among the containers are isolated.

Daemon : 
It is the service responsible for orchestrating container lifecycle management. It handles various tasks including container creation, 
execution, and monitoring.

Commands Basics :
Docker container ls / Docker ps: List all running containers
Docker container ls -a : Shows all containers
Docker start <container_name>
Docker stop <container_name>
Docker create <image_name> : Creates a new container from Docker image
Docker create --name <container_name> <image_name> : Creates a new container with specific name 
Docker run <image_name> : Combination of create and start i.e. runs the container as soon as creating the container.

Docker rm: Remove a docker container 

Docker run : Spins up a new container from an image.
Docker run -it <image_name>

Docker images : View all images on the local desktop

Docker exec <container_name> <command_name> 
Docker exec -it <container_name> <command_name> 
Execute command in the runnning container 

- To **exit** from **the container/ interactive mode** use cntrl+D

Flags :
-a : All 
-s : Size
-f : Filter. Example : Docker ps -f name=pe "Displays containers with name starting with pe". Docker ps -a status=running
-i : Interactive. After executing we don't exit out of the container and can keep interacting with the container.
-it : Interactive + -t/-tty. T gives the interaction with a terminal like command interface.
-p : Exposes a container's port(s) to the host.
Syntax: -p <host_port>:<container_port>
-d : Runs the container in detached mode. The container will be detached from the current terminal session, so we don't see its output directly in the terminal.
Control is returned to your terminal prompt immediately after the container starts.
-e : Used to pass value of environemt variables 
Syntax : 
-e key=value 
-v : Volume Mounting
Vount container to local disk to avoid losing data when container is deleted.

-- **Port Mapping**
Port allows to connect a container's internal ports to the host system's ports.

Multiple Port Mappings:
Can map multiple ports using multiple -p flags

-- **Converting to Image / Creating Image**
After writing the configuration run the command Docker build -t <name_of_file> . 
. indicates that the image is in the same directory
-t flag allows us to name/tag the image.

-- **Docker Compose**
Docker Compose is used for running multi-container Docker applications.

Main components:
docker-compose.yml file: Defines the services, networks, and volumes
docker-compose CLI: Used to build, run, and manage the application stack

Command to run this : Docker compose up 
Command to stop : Docker compose down 

Networks in Docker : 
Networking allows containers to communicate with each other and with the outside world. 

1. Bridge: The default network driver. Containers on the same bridge network can communicate, while providing isolation from containers not connected to that network.
2. Host: Removes network isolation between the container and the Docker host, using the host's networking directly.
3. Overlay: Enables communication between containers across multiple Docker daemon hosts.
4. Macvlan: Allows to assign a MAC address to a container, making it appear as a physical device on the network.
5. None: Disables all networking for a container.

Caching in Layers 
**Benefits:**
Significantly faster build times for unchanged parts of the image.
Reduced resource usage and network bandwidth.
**Best practices:**
Order Dockerfile instructions from least likely to change to most likely to change.
Use multi-stage builds to separate build-time dependencies from runtime dependencies.
Be mindful of commands that may produce non-deterministic results (e.g., apt-get update).
**Cache-related commands:**
--no-cache: Forces a complete rebuild without using any cached layers.
--cache-from: Specifies images to use as potential cache sources.

[Cheatsheet](https://buddy.works/tutorials/docker-commands-cheat-sheet)
