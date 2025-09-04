FROM ros:jazzy
ARG RCSSSERVER_VERSION="19.0.0"

# update packages
RUN apt-get update && apt-get upgrade -y

# install turtlesim example
RUN sudo apt-get install ros-jazzy-turtlesim -y

RUN echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc

# install SimSpark & RCS 3d stuff

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

# Install rcssserver

WORKDIR /

RUN sudo apt install wget build-essential automake autoconf libtool flex bison libboost-all-dev -y
RUN wget https://github.com/rcsoccersim/rcssserver/releases/download/rcssserver-${RCSSSERVER_VERSION}/rcssserver-${RCSSSERVER_VERSION}.tar.gz
RUN tar xzvfp rcssserver-${RCSSSERVER_VERSION}.tar.gz -C /
RUN rm rcssserver-${RCSSSERVER_VERSION}.tar.gz
WORKDIR /rcssserver-${RCSSSERVER_VERSION}
RUN mkdir build
RUN ./configure
RUN make
RUN sudo make install

# Install rcssmonitor

WORKDIR /

RUN git clone https://github.com/rcsoccersim/rcssmonitor.git
WORKDIR /rcssmonitor
RUN ./bootstrap
RUN ./configure
RUN make
RUN sudo make install

# Dependencies for MESA 3D
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get install -y libgl1-mesa-dev libosmesa6-dev

# Environment variables setup
# Sets domain id. Change as necessary
ENV ROS_DOMAIN_ID=1 

# Sets ROS node visibility. Change as necessary
ENV ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST

# set user & directory
# password is wolverbot!
RUN useradd -rm -d /home/wbk -s /bin/bash -g root -G sudo -u 1001 -p $(perl -e 'print crypt($ARGV[0], "password")' 'wolverbot!') wbk
USER wbk
WORKDIR /home/wbk

# Set volume mount
VOLUME [ "/home/wbk" ]

# Add any configs as necessary.
ENTRYPOINT ["/ros_entrypoint.sh"]