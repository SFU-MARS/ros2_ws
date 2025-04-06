#!/bin/bash
# OptimizedDP setup; assumes conda is installed
set -e

source ~/miniconda3/bin/activate

# Install optimized dp
cd py
if [ ! -d optimized_dp ] ; then # if the directory does not exist
    git clone -b ttr_obs https://github.com/SFU-MARS/optimized_dp.git
fi

# Make odp visible outside conda environment
cd optimized_dp/ 
pip install -e .

# Install odp within the odp environment
conda env create -f environment.yml 
conda activate odp
pip install -e .
conda deactivate

cd ../.. # Back to workspace

# Make conda command available without being in base environment
echo "source ~/miniconda3/bin/activate" >> ~/.bashrc
echo "conda deactivate" >> ~/.bashrc
source ~/.bashrc 