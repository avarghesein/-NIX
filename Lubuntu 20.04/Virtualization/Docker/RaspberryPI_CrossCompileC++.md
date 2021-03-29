## Enable Qemu-User-Mode emulation, for RaspberyPi (Arm) under X64 Machine
    
    docker run --rm --privileged fkrull/qemu-user-static enable

## Build a Docker Image for Building Modern C++, for RaspberryPi

  ### Docker File [DockerModernC++.txt](https://github.com/avarghesein/-NIX/blob/main/Lubuntu%2020.04/Virtualization/Docker/DockerModernC%2B%2B.txt)
  
    FROM arm32v7/python:3.9-slim-buster

    RUN apt update --fix-missing -y
    RUN apt install cmake -y
    RUN apt install build-essential -y
  
  ### Build Docker Image and Tag
  
    docker build -f DockerModernC++.txt -t avarghesein/pi_builder_image:v7_armhf .
 
## Now Run the Docker Container, to build C++ source for RaspberryPi

    docker run --name "PiBuilder" -it \
    --privileged \
    --mount type=bind,source="/home/cpp_source/",target="/mnt/cpp_source/"  \
    -it avarghesein/pi_builder_image:v7_armhf /bin/bash

Where "/home/cpp_source/", is the folder in the Host machine, containing C++ source files to be build for RaspberryPi

## Build the Source for RaspberryPI

    cd /mnt/cpp_source/build_arm
    cmake ..
    make
    #Now run the built program
    exit
    
## If there is a modification to the C++ Source, Reuse the Same Container!

    docker run --rm --privileged fkrull/qemu-user-static enable
    docker start PiBuilder
    docker attach PiBuilder
    #Run CMake commands
