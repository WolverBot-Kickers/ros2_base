FROM ros:jazzy

# update packages
RUN apt-get update && apt-get upgrade -y

# install turtlesim example
RUN sudo apt-get install ros-jazzy-turtlesim -y

RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

# Environment variables setup
# Sets domain id. Change as necessary
ENV ROS_DOMAIN_ID=1 

# Sets ROS node visibility. Change as necessary
ENV ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST

# Display X11 forwarding vars
# ENV XDG_RUNTIME_DIR=/tmp
# Change permissions on run dir
# RUN chmod 0700 /tmp/

# Add any configs as necessary.
ENTRYPOINT ["bash"]