#!/bin/bash

# Install gstreamer libraries used by kvs, ros-rtsp
apt-get install -y libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev libgstreamer-plugins-bad1.0-dev libgstrtspserver-1.0-dev
apt-get install -y libssl-dev libcurl4-openssl-dev liblog4cplus-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-plugins-base-apps gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-tools

# Install VLC
snap install vlc

# Install jq utility for json parsin
apt-get install -y jq

# Misc software and initialize rosdep
apt install -y git tar terminator 
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
pip install --upgrade pip
apt install -y python-rosdep python-rosinstall-generator python-wstool build-essential unzip 
rosdep init

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install ros related packages
apt install -y ros-melodic-gazebo-ros ros-melodic-gazebo-ros-pkgs ros-melodic-gazebo-ros-control 
apt install -y ros-melodic-controller-manager ros-melodic-lms1xx ros-melodic-velodyne-description 
apt install -y ros-melodic-robot-localization ros-melodic-interactive-marker-twist-server ros-melodic-twist-mux
apt install -y ros-melodic-joy ros-melodic-teleop-twist-joy ros-melodic-teleop-twist-keyboard ros-melodic-pointcloud-to-laserscan
apt install -y ros-melodic-map-server ros-melodic-amcl ros-melodic-move-base ros-melodic-realsense2-description
apt install -y ros-melodic-hector-gazebo ros-melodic-joint-state-controller ros-melodic-diff-drive-controller
apt install -y ros-melodic-dwa-local-planner