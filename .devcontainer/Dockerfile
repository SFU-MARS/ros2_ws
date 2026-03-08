FROM althack/ros2:humble-dev 

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
	ros-humble-navigation2 \
	ros-humble-nav2-bringup \
	ros-humble-turtlebot3-msgs \
	ros-humble-turtlebot3 \
	ros-humble-turtlebot3-gazebo \
	nano \
	tmux \
	&& rm -rf /var/lib/apt/lists/*
ENV DEBIAN_FRONTEND=dialog
ENV TURTLEBOT3_MODEL=burger

# Additional pip packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip \
	&& pip install --no-cache-dir --timeout 2000 -r /tmp/requirements.txt

# Set up auto-source of workspace for ros user
ARG WORKSPACE
RUN echo "if [ -f ${WORKSPACE}/install/setup.bash ]; then source ${WORKSPACE}/install/setup.bash; fi" >> /home/ros/.bashrc

# make sure the ROS env is set up for the whole container (not just interactive shell)
COPY ros_entrypoint.sh /usr/local/bin/ros_entrypoint.sh
RUN chmod +x /usr/local/bin/ros_entrypoint.sh
ENTRYPOINT ["/usr/local/bin/ros_entrypoint.sh"]
CMD ["bash"]
