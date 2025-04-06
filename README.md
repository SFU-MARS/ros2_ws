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
- **If the simulator doesn't run properly**, killing all processes that still are running after `^C` may help. 
    - Execute the following line to kill the likely remaining processes:
    - Run `ps -a` to verify no processes remain. If any remain, kill them one by one until `ps -a` shows they are gone.
    - Double check that these processes are not running both within the docker container and on the host.
```bash
pkill -9 gazebo && pkill -9 gzclient && pkill -9 gzserver && pkill -9 ros2 && pkill -9 python3
```
    
- **If you get an permission denied error** like `error creating runtime directory '/run/user/1001' (permission denied)`:
  - Run the following:
  - Lines 2 and 3 ensure ros has ownership of the runtime directory. The last line sets up the Gazebo environment.
```bash
source ~/.bashrc
sudo chmod -R 700 /run/user
sudo chown -R ros:ros /run/user
source /usr/share/gazebo/setup.sh
```
- **If the initial `colcon build` fails**, it is likely due to dependency issues.
    - Try running
```bash
sudo apt-get update
rosdep update
rosdep install -i --from-path src --rosdistro humble -y
colcon build --symlink-install
```
