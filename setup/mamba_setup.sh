#!/bin/bash
set -e  # Exit on error

# Directory where Mambaforge will be installed
INSTALL_DIR="$HOME/mambaforge"

# If Mambaforge not already installed, install it
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Installing Mambaforge in $INSTALL_DIR ..."
    mkdir -p "$INSTALL_DIR"

    # Download latest Mambaforge installer
    wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh \
         -O "$INSTALL_DIR/mambaforge.sh"

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
mamba config --set auto_activate_base false

# Clean cache
mamba clean -afy

# Add to .bashrc for future sessions
if ! grep -q "source $INSTALL_DIR/bin/activate" ~/.bashrc; then
    echo "source $INSTALL_DIR/bin/activate" >> ~/.bashrc
fi

echo "Mambaforge installation complete!"
