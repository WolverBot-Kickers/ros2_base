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

### Q&A

**Why is `docker build` taking forever?**

`docker build` by default installs `ros2`, `Simspark`, `rcsserver3d`, and all the necessary dependencies for you to run things.

If you don't want to install some of these, feel free to edit `Dockerfile` to exclude some of the steps.

**How do I remove the container and build fresh?** 

Run `docker compose rm` and follow the steps above again.

### Running GUI Applications

All GUI output will be redirected to `localhost:8080/vnc.html`.

### Trobleshooting

Reach out to any of the leads or Shin for any questions. 

