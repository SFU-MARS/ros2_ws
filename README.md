# ROS2 Workspace
Workspace for projects from [MARS Lab](https://sfumars.com/)

## Information
- OS: Ubuntu 22.04 LTS 
- ROS2: Humble

Installed ROS2 Packages:
- [HuNavSim](https://github.com/robotics-upo/hunav_sim)
- [hunav_gazebo_wrapper](https://github.com/robotics-upo/hunav_sim)

Example Usage:
```
ros2 launch hunav_gazebo_wrapper example_cafe.launch.py
```
> [!NOTE]  
> Gazebo may fail to close or a zombie process will be left. A solution is to run `pkill -9 gzclient; pkill -9 gzserver` to ensure the process is terminated.
