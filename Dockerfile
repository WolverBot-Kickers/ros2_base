FROM ros:jazzy

# update packages
RUN apt-get update && apt-get upgrade -y

# install turtlesim example
RUN sudo apt-get install ros-jazzy-turtlesim -y

RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

# install SimSpark & RCS stuff

# install dependencies
RUN sudo apt-get install g++ git make cmake libfreetype6-dev libode-dev libsdl2-dev ruby ruby-dev libdevil-dev libboost-dev libboost-thread-dev libboost-regex-dev libboost-system-dev qtbase5-dev qtchooser qt5-qmake libqt5opengl5-dev -y

WORKDIR /

# clone repository
RUN git clone https://gitlab.com/robocup-sim/SimSpark.git

# configure & build

WORKDIR /SimSpark/spark
RUN mkdir build
WORKDIR /SimSpark/spark/build
RUN cmake ..
RUN make

RUN sudo make install
RUN sudo ldconfig

WORKDIR /SimSpark/rcssserver3d
RUN mkdir build
WORKDIR /SimSpark/rcssserver3d/build
RUN cmake ..
RUN make

RUN sudo make install
RUN sudo ldconfig

RUN echo -e '/usr/local/lib/simspark\n/usr/local/lib/rcssserver3d' | sudo tee /etc/ld.so.conf.d/spark.conf 
RUN sudo ldconfig

# Dependencies for MESA 3D
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get install -y libgl1-mesa-dev libosmesa6-dev

# Environment variables setup
# Sets domain id. Change as necessary
ENV ROS_DOMAIN_ID=1 

# Sets ROS node visibility. Change as necessary
ENV ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST

# Add any configs as necessary.
ENTRYPOINT ["/ros_entrypoint.sh"]