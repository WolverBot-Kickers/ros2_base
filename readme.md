# ROS2 Template Repository

This is a ROS2 Template Repository. This comes with the necessary dockerfile and setups that comes with:

- ROS2 Jazzy
- Turtlesim (examples)
- noVNC (if you've taken EECS 388, this is what they use for docker GUIs as well)

### Getting Started

Ensure that you have Docker installed.

Run 

```
docker compose up
```

To build and run the containers. 

### Running GUI Applications

This branch uses noVNC. If you want to use X11 Forwarding, use the main branch to do so.

Note that for MacOS users, if you don't have any X11 server installed, the main branch will simply not work (because you don't have one). Please use the noVNC configuration. 

(Alternatively, you can install X11 servers like XQuartz)

All GUI output will be redirected to `localhost:8080/vnc.html`.

### Trobleshooting

Reach out to any of the leads or Shin for any questions. 

