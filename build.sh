#!/usr/bin/env bash

sudo apt-get update -y
#cmake >= 3.20.5 required
#wget https://apt.kitware.com/kitware-archive.sh
#sudo bash kitware-archive.sh
sudo apt-get install -y --no-install-recommends git cmake ninja-build gperf \
  ccache dfu-util device-tree-compiler wget \
  python3-dev python3-pip python3-setuptools python3-tk python3-wheel xz-utils file \
  make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1
pip install west

west init .
west update
west zephyr-export
pip install -r zephyr/scripts/requirements.txt

# Install Zephyr SDK
test -f zephyr-sdk-0.16.1_linux-x86_64.tar.xz || wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.1/zephyr-sdk-0.16.1_linux-x86_64.tar.xz
wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.1/sha256.sum | shasum --check --ignore-missing
test -d /opt/zephyr-sdk-0.16.1/ || sudo tar xvf zephyr-sdk-0.16.1_linux-x86_64.tar.xz -C /opt
cd /opt/zephyr-sdk-0.16.1
yes | ./setup.sh
