#!/usr/bin/env bash
#
## make sure the ROS environment is set up for every container
## command, not just interactive shells
#
set -e

# Source ROS
source /opt/ros/humble/setup.bash
if [ -f "/usr/share/gazebo/setup.sh" ]; then source /usr/share/gazebo/setup.sh; fi

# Source workspace if present
if [ -f "/workspaces/ros2_ws/install/setup.bash" ]; then source /workspaces/ros2_ws/install/setup.bash; fi

# Turtlebot models
export GAZEBO_MODEL_PATH="${GAZEBO_MODEL_PATH}:/opt/ros/humble/share/turtlebot3_gazebo/models"

# Optional package-based path
if ros2 pkg prefix mpc >/dev/null 2>&1; then
    export GAZEBO_MODEL_PATH="${GAZEBO_MODEL_PATH}:$(ros2 pkg prefix mpc)/share/mpc/models"
fi

# Optional Cyclone config (only if you really want Cyclone)
if [ -f "/workspaces/ros2_ws/setup/cyclonedds_lo.xml" ]; then
    export CYCLONEDDS_URI="/workspaces/ros2_ws/setup/cyclonedds_lo.xml"
fi

exec "$@"
