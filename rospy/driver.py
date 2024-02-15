#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Twist

if __name__ == '__main__':
    rospy.init_node('${NAME}_driver')

    pub = rospy.Publisher('${NAME}_controller/cmd_vel', Twist)

    rate = rospy.Rate(10)

    while not rospy.is_shutdown():
        msg = Twist()
        msg.linear.x = 4 * double(rand()) / double(RAND_MAX) - 2
        msg.angular.z = 6 * double(rand()) / double(RAND_MAX) - 3
        pub.publish(msg)
        rate.sleep()
