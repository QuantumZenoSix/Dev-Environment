#!/bin/sh

SUDO=""

# if not root, run as sudo
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
fi

# Define the container name or ID
IMAGE_NAME="ubuntu-jammy"
CONTAINER_NAME="ubuntu-jammy-container"  # Replace with your container name or ID
LOCAL_BIND_MOUNT_DIR="$1"
CONTAINER_BIND_MOUNT_DIR=/app

# Define the image name and tag
TAG="v1"
FULL_IMAGE="$IMAGE_NAME:$TAG"

# Check if the image exists locally
IMAGE_ID=$(docker images -q "$FULL_IMAGE")

if [ -n "$IMAGE_ID" ]; then
    echo "Image '$FULL_IMAGE' already exists with ID: $IMAGE_ID"
else
    echo "Image '$FULL_IMAGE' does not exist. Building from Dockerfile..."

    # Create Dockerfile

cat <<EOF > Dockerfile
# Base image
FROM ubuntu:22.04

# Set working directory
WORKDIR /app

# Copy application files
# COPY ./home/control-io/www-core/ .

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Update apt cache and install neovim
# RUN apt-get update && apt install python3 wget zsh lua5.4 curl tar ripgrep fzf make gcc unzip git git-all xclip build-essential p7zip-full jq locatesshpass xsel cmake nodejs npm libstdc++6 -y

# Install essentials programs
RUN apt-get update && apt install wget curl git sudo -y

# Run install script
# CMD sh -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/init.sh -O -)"
# CMD sh -c "wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/init.sh -O - | sh"


EOF

    # Build the image from Dockerfile
    BUILD_OUTPUT=$(sudo docker build -t "$FULL_IMAGE" .)

    # Check if build succeeded
    if [ $? -eq 0 ]; then
        # Get the new image ID
        IMAGE_ID=$($SUDO docker images -q "$FULL_IMAGE")
        echo "Image '$FULL_IMAGE' built successfully with ID: $IMAGE_ID"
    else
        echo "Failed to build image '$FULL_IMAGE'."
        exit 1
    fi
fi




# Check if the container is running
if [ -n "$($SUDO docker ps -q -f name=$CONTAINER_NAME)" ]; then

    echo "Container '$CONTAINER_NAME' is running. Connecting to it..."

    sudo docker exec -it $CONTAINER_NAME /usr/bin/zsh

else

    echo "Container '$CONTAINER_NAME' is not running."



    # Check if the container exists (stopped)
    if [ -n "$($SUDO docker ps -aq -f name=$CONTAINER_NAME)" ]; then

        echo "Found Container. Starting container '$CONTAINER_NAME'..."
        sudo docker start $CONTAINER_NAME

        # Connect to the container after starting it
        echo "Connecting to '$CONTAINER_NAME'..."
        sudo docker exec -it $CONTAINER_NAME /usr/bin/zsh


    else

        echo "Container '$CONTAINER_NAME' does not exist. Creating and starting it..."

        # Replace the following line with your container creation command
        # docker run -d --name $CONTAINER_NAME ubuntu /bin/bash

        if [ -z "$LOCAL_BIND_MOUNT_DIR" ]; then
            $SUDO docker run -it --name "$CONTAINER_NAME" "$IMAGE_ID"

            # $SUDO docker run -it --name "$CONTAINER_NAME" "$IMAGE_ID" sh -c 'wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/init.sh -O - | sh'
        else
            $SUDO docker run -it -v "$LOCAL_BIND_MOUNT_DIR:$CONTAINER_BIND_MOUNT_DIR" --name "$CONTAINER_NAME" "$IMAGE_ID"
        fi


    fi



fi
