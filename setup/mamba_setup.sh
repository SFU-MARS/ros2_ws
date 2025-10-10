#!/bin/bash
set -e  # Exit on error

# Directory where Mambaforge will be installed
INSTALL_DIR="$HOME/mambaforge"

# If Mambaforge not already installed, install it
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"

    # Download latest Mambaforge installer
    wget -O "$INSTALL_DIR/mambaforge.sh" "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"

    # Run the installer silently (-b = batch mode, -u = update existing, -p = prefix)
    bash "$INSTALL_DIR/mambaforge.sh" -b -u -p "$INSTALL_DIR"

    # Clean up installer
    rm "$INSTALL_DIR/mambaforge.sh"
else
    echo "Mambaforge already installed in $INSTALL_DIR"
fi

# Activate base environment
source "$INSTALL_DIR/bin/activate"

# Disable automatic base activation (recommended)
conda config --set auto_activate_base false
conda deactivate

# Clean cache
mamba clean -afy

# Add to .bashrc for future sessions
echo "source $INSTALL_DIR/bin/activate" >> ~/.bashrc
echo "conda deactivate" >> ~/.bashrc

echo "Mambaforge installation complete!"
