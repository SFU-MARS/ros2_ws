# ROS2 Workspace
Workspace for projects from [MARS Lab](https://sfumars.com/) running **ROS2 Humble**
- Originally fork of https://github.com/athackst/vscode_ros2_workspace/tree/humble-nvidia

## Requirements
- Ubuntu 22.04 LTS
- Nvidia driver 555 with CUDA 12.5

## Setup
### Host 
If compatible Nvidia GPU is available:
- See `setup/host_gpu_driver_setup.sh`

If compatible Nvidia GPU is not available:
- Switch to the `no_cuda` branch

### Dev container
See [general instructions for using workspaces with docker](https://github.com/SFU-MARS/ros2_tutorial/wiki/Building-and-using-the-dev-container).

## Running the simulation
1. Launch human simulator: 
    - Settings are in `hunavis/params/hunavsim.yaml`
```bash
ros2 launch hunavis mars.launch.py
```
![Human and robot in an empty room](images/human_robot_gazebo.png)

2. Launch nav2: 
    - Settings are in `hunavis/params/tb3_custom_sim.yaml`
```bash
ros2 launch hunavis tb3_custom_sim.launch.py
```

3. Launch human detection (including loading rviz)
```bash
ros2 launch hunavis hudet.launch.py
```
![Rviz display](images/human_robot_rviz.png)

#### Known issues
- If the simulator doesn't run properly, killing all processes that still are running after `^C` may help. 
- `gzserver` may be running in the background after `^C`, but can be killed using `pkill -9 gzserver`.
    - Similarly, killing `gzclient`, `ros`, `python3` or any other related processes may help