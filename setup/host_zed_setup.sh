# Install Zed2 SDK; used for installing Zed SDK on host
# Run as current user without sudo
UBUNTU_MAJOR=22
UBUNTU_MINOR=04
CUDA_MAJOR=12
CUDA_MINOR=1
CUDA_PATCH=0
ZED_SDK_MAJOR=4
ZED_SDK_MINOR=1
ZED_SDK_PATCH=2

wget -q -O ~/ZED_SDK_Linux_Ubuntu.run https://download.stereolabs.com/zedsdk/${ZED_SDK_MAJOR}.${ZED_SDK_MINOR}/cu${CUDA_MAJOR}${CUDA_MINOR%.*}/ubuntu${UBUNTU_MAJOR} 
chmod +x ~/ZED_SDK_Linux_Ubuntu.run
~/ZED_SDK_Linux_Ubuntu.run -- silent skip_cuda
rm ~/ZED_SDK_Linux_Ubuntu.run
