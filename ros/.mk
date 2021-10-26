
PROJECT_DIR=$(pwd)

## Create src directory
mkdir -p src

## Create workspace
cd src
catkin_init_workspace
catkin_create_pkg $NAME roscpp std_msgs

## Add executable to cmake
cmake_template() {
    cat << EOF
add_executable(${NAME} driver.cpp)
target_link_libraries(${NAME} \${catkin_LIBRARIES})
EOF
}
cmake_template >> $NAME/CMakeLists.txt

## Add driver.cpp
driver_template() {
    cat << EOF
#include <geometry_msgs/Twist.h>
#include <ros/ros.h>
#include <stdlib.h>

int main(int argc, char ** argv) {
    ros::init(argc, argv, "${NAME}_driver");
    ros::NodeHandle nh;

    ros::Publisher pub =
        nh.advertise<geometry_msgs::Twist>("${NAME}_controller/cmd_vel", 100);

    srand(time(0));

    ros::Rate rate(10);

    while (ros::ok()) {
        geometry_msgs::Twist msg;
        msg.linear.x = 4 * double(rand()) / double(RAND_MAX) - 2;
        msg.angular.z = 6 * double(rand()) / double(RAND_MAX) - 3;
        pub.publish(msg);
        rate.sleep();
    }
}
EOF
}
driver_template > $NAME/driver.cpp

## Add roslaunch file
roslaunch_template() {
    cat << EOF
<launch>
    <node pkg="$NAME" type="$NAME" name="$NAME" output="screen" />
</launch>
EOF
}
mkdir -p $NAME/launch
roslaunch_template > $NAME/launch/$NAME.launch

## Return to project root
cd $PROJECT_DIR

## Add vscode launch file
vslaunch_template() {
    cat << EOF
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "ROS: Launch",
            "request": "launch",
            "target": "\${workspaceFolder}launch/${NAME}.launch",
            "type": "ros"
        }
    ]
}
EOF
}
vslaunch_template > $PROJECT_DIR/.vscode/launch.json

## Build project
catkin_make

# vi: ft=bash

