#!/bin/bash

APP_DIRECTORY=/home/ubuntu/environment
touch ~/.bash_aliases
echo "source $APP_DIRECTORY/utility_bash_functions" >> ~/.bash_aliases
echo "source ~/.bash_aliases" >> ~/.bashrc
# Setup sample ros application
if [ -d $APP_DIRECTORY ]; then
    mkdir -p $APP_DIRECTORY
fi
cd $APP_DIRECTORY
git clone https://github.com/aws-samples/multi-robot-fleet-sample-application.git
cd $APP_DIRECTORY/multi-robot-fleet-sample-application/simulation_ws
git checkout 270da92
source /opt/ros/melodic/setup.sh
echo "source /opt/ros/melodic/setup.bash" >> ~/.bash_aliases
rosws update

# clone ros images to rtsp stream rospackage. This needs gstreamer plugins setup in root script
git clone https://github.com/konduri/ros_rtsp.git  $APP_DIRECTORY/multi-robot-fleet-sample-application/simulation_ws/src/deps/ros_rtsp

# Install dependencies
pip install roslibpy
rosdep install --from-paths $APP_DIRECTORY/multi-robot-fleet-sample-application/simulation_ws/src -r -y --skip-keys roslibpy-pip
catkin_make

# Setup sourcing in the bash aliases
source $APP_DIRECTORY/multi-robot-fleet-sample-application/simulation_ws/devel/setup.bash
echo "source $APP_DIRECTORY/multi-robot-fleet-sample-application/simulation_ws/devel/setup.bash" >> ~/.bash_aliases



## Setup webrtc here
cd $APP_DIRECTORY
#git clone --recursive https://github.com/awslabs/amazon-kinesis-video-streams-webrtc-sdk-c.git

git clone https://github.com/awslabs/amazon-kinesis-video-streams-webrtc-sdk-c.git
cd $APP_DIRECTORY/amazon-kinesis-video-streams-webrtc-sdk-c;git checkout 54c4138; git submodule update --recursive

mkdir $APP_DIRECTORY/amazon-kinesis-video-streams-webrtc-sdk-c/build
cd $APP_DIRECTORY/amazon-kinesis-video-streams-webrtc-sdk-c/build
cmake ..
make



# Setup KVS sink
cd $APP_DIRECTORY
git clone https://github.com/awslabs/amazon-kinesis-video-streams-producer-sdk-cpp.git
mkdir $APP_DIRECTORY/amazon-kinesis-video-streams-producer-sdk-cpp/build
cd $APP_DIRECTORY/amazon-kinesis-video-streams-producer-sdk-cpp/build
cmake ..  -DBUILD_GSTREAMER_PLUGIN=TRUE
make

export GST_PLUGIN_PATH=$GST_PLUGIN_PATH:$APP_DIRECTORY/amazon-kinesis-video-streams-producer-sdk-cpp/build
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$APP_DIRECTORY/amazon-kinesis-video-streams-producer-sdk-cpp/open-source/local/lib
