#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install git wget flex bison gperf python python-pip python-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util

sudo apt-get install python3 python3-pip python3-setuptools
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10

sudo mkdir /opt/esp
sudo chown pi:root /opt/esp
cd /opt/esp
git clone --recursive https://github.com/espressif/esp-idf.git

mkdir /opt/esp/.espressif
export IDF_TOOLS_PATH=/opt/esp/.espressif
cd /opt/esp/esp-idf
./install.sh

. /opt/esp/esp-idf/export.sh

