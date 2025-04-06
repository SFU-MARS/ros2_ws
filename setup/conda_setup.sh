#!/bin/bash
set -e

if [ ! -d ~/miniconda3 ] ; then # if the directory does not exist
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm ~/miniconda3/miniconda.sh 
fi

source ~/miniconda3/bin/activate
conda config --set auto_activate_base false
source ~/.bashrc
