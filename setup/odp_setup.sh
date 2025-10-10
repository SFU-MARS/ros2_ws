#!/bin/bash
# OptimizedDP setup — assumes Mambaforge (mamba) is installed and on PATH
set -euo pipefail

MAMBA_INSTALL_DIR="$HOME/mambaforge"
source "$MAMBA_INSTALL_DIR/bin/activate"


# Initialize Conda in this shell so "conda activate" works
eval "$(conda shell.bash hook)"

# Activate base environment
conda activate base

# Go to project directory
cd py

# Clone repository if missing
if [ ! -d optimized_dp ]; then
    echo "🔹 Cloning optimized_dp repository..."
    git clone -b ttr_obs https://github.com/SFU-MARS/optimized_dp.git
else
    echo "🔹 Updating existing optimized_dp repository..."
    git -C optimized_dp pull
fi

cd optimized_dp

# Install package editable in base env (optional for dev visibility)
pip install -e .

# Create the 'odp' environment if environment.yml exists
if [ -f environment.yml ]; then
    echo "🔹 Creating odp environment..."
    mamba env create -f environment.yml -y || echo "Environment may already exist — skipping creation."
else
    echo "⚠️ environment.yml not found — skipping environment creation."
fi

# Activate the environment properly
conda activate odp

# Install optimized_dp inside the odp environment
pip install -e .

# Deactivate environment
conda deactivate

# Return to workspace root
cd ../..

echo "✅ OptimizedDP setup complete!"
