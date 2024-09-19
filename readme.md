# ROS2 Template Repository

This is a ROS2 Container Repository. This comes with the necessary dockerfile and setups that comes with:

- ROS2 Jazzy
- Turtlesim
- Simspark & rcssim3
- noVNC (if you've taken EECS 388, this is what they use for docker GUIs as well)

### Getting Started

Ensure that you have [Docker](https://docs.docker.com/engine/install/) installed.

Run 

```
docker build . 
```

To build our ROS2 container, then run

```
docker compose up -d
```

To build noVNC and run the containers. 

### Setup Dev Contianers/ Docker Extension on VsCode (optional)

Open VSCode pallette, and run:

`Dev Containers: Open Attached Container Configuration File`

Then select:

`ros2_base-ros2`

Then copy and paste the following configuration:

```json
{
	"workspaceFolder": "/home/wbk",
	"remoteUser": "wbk"
}
```

### Removing and rebuilding container

By default, your files will persist through a volume. To restart the container or build a more recent version of the container, stop all containers, then run:

`docker compose rm`

Then run:

`docker compose up --build --no-deps --force-recreate -d `

To re-build the container. Note the mounted volume will persist.

### Q&A

**Why is `docker build` taking forever?**

`docker build` by default installs `ros2`, `Simspark`, `rcsserver3d`, and all the necessary dependencies for you to run things.

If you don't want to install some of these, feel free to edit `Dockerfile` to exclude some of the steps.

**Why are there two containers?**

The `ros2_base-ros2` container is the main container; you can run commands and things in this container. 

The `novnc` container does **NOT** run things. It is there to forward any Graphical outputs from the `ros2` container to `localhost:8080/vovnc.html/`. Please do **not** attach yourself to this container.

**How do I re-start the container?**

First, start up your container. Use Docker Desktop to press the play button, or if you remember the container id, you can run `docker start <id>`. 


Run `docker ps` or open up docker desktop to find your container's id.

For example, `docker ps` will return:

```
CONTAINER ID   IMAGE            ....     NAMES
fb9968bdcce4   ros2_base-ros2            ros2_base-ros2-1
c6c54c1b9f6f   theasp/novnc:latest       ros2_base-novnc-1
```

Here, the container ID for `ros2-base-ros2` is `fb99`. One nice thing about docker is that you only need to use the first four letters of the container id to uniquely identify the container.

To attach your current terminal, you can run:

`docker attach <id>`.

In this example, you would run `docker attach fb99` 

**How do I create multiple terminals?**

To create another terminal, run:

`docker exec -it ros2_base-ros2-1 bash`

to create and attach a bash session to your current terminal.

Alternatively, you may run `xterm && xterm` or such to launch multiple xterm windows, and see them in the vnc window.

### Running GUI Applications

All GUI output will be redirected to `localhost:8080/vnc.html`.

### Trobleshooting

Reach out to any of the leads or Shin for any questions. 

