#! /usr/bin/python
# Copyright (c) 2015, Rethink Robotics, Inc.

# Using this CvBridge Tutorial for converting
# ROS images to OpenCV2 images
# http://wiki.ros.org/cv_bridge/Tutorials/ConvertingBetweenROSImagesAndOpenCVImagesPython

# Using this OpenCV2 tutorial for saving Images:
# http://opencv-python-tutroals.readthedocs.org/en/latest/py_tutorials/py_gui/py_image_display/py_image_display.html

# rospy for the subscriber
import rospy
# ROS Image message
from sensor_msgs.msg import Image
# ROS Image message -> OpenCV2 image converter
from cv_bridge import CvBridge, CvBridgeError
# OpenCV2 for saving an image
import cv2

# Instantiate CvBridge
bridge = CvBridge()

def image_callback(msg):
	print("Received an image!")
	# get the frame number (it is stored in the header)
	frame = str(msg.header.seq)
	# write file into user_data volume
	filepath = '/home/ros/user_data/video/'+frame+'.jpg'
	try:
		# Convert your ROS Image message to OpenCV2
		cv2_img = bridge.imgmsg_to_cv2(msg, "bgr8")
	except CvBridgeError, e:
		print(e)
	else:
		# Save your OpenCV2 image as a jpeg 
		cv2.imwrite(filepath, cv2_img)

if __name__ == '__main__':
	rospy.init_node('image_listener')
	# Define your image topic
	image_topic = "/openease/video/frame"
	# Set up your subscriber and define its callback
	rospy.Subscriber(image_topic, Image, image_callback)
	# Spin until ctrl + c
	rospy.spin()

