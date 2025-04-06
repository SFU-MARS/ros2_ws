#!/bin/bash
read -p "WARNING: The clean script will rm -rf the src folder, and you will lose all changes that have not been pushed! Type ros2_ws to proceed, or any other input abort. " confirmation

if [[ "$confirmation" == "ros2_ws" ]]; then
    rm -rf \
        build \
        install \
        log \
        src \
        py

else
    echo "Aborted."
fi