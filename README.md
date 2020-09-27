# toolchain

Toolchain provides all the tools for building Microcontroller in docker. It becomes quite difficul to build all the tools in a host environment. Each board requires a different setup. Toolchain provides a normalised environment where all tools can be loaded inside a docker container. The code can be written on the host system using IDE (vscode / similar) and then deployment happens inside the container.

## Serial
The serial port is exposed to docker container to enable flashing the hardware from the container.

## Ubuntu 18.04
The base system image is selected as Ubuntu 20.04 to ensure python3 is the default interpretor

## Host
The docker images are targetted for RPI4 with 4GB Ram to ensure it has a uniform system for all deployment and there is no requirement of any host hardware.


