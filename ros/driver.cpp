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
