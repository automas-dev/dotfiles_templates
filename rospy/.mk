#!/bin/bash

PROJECT_DIR=$(pwd)

## Create src directory
mkdir -p src

## Create workspace
cd src
catkin_init_workspace
catkin_create_pkg $NAME rospy std_msgs

## Add executable to cmake
envsubst_rm "$PROJECT_DIR/CMakeLists.txt" >> "$NAME/CMakeLists.txt"

## Add driver.cpp
envsubst_rm "$PROJECT_DIR/driver.cpp" > "$NAME/driver.cpp"

## Add roslaunch file
mkdir -p $NAME/launch
envsubst_rm "$PROJECT_DIR/roslaunch.launch" > "$NAME/launch/$NAME.launch"

## Return to project root
cd $PROJECT_DIR

## Add vscode launch file
envsubst_rm "$PROJECT_DIR/vs_launch.json" > "$PROJECT_DIR/.vscode/launch.json"

## Build project
catkin_make

# vi: ft=bash

