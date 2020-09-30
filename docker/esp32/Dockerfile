FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

# We need libpython2.7 due to GDB tools
RUN apt-get update && apt-get install -y \
    apt-utils \
    bison \
    ca-certificates \
    ccache \
    check \
    cmake \
    curl \
    dfu-util \
    flex \
    git \
    gperf \
    lcov \
    libncurses-dev \
    libusb-1.0-0-dev \
    make \
    ninja-build \
    libffi-dev  \
    libpython2.7 \
    libssl-dev \
    python3 \
    python3-pip \
    python3-setuptools \
    unzip \
    wget \
    xxd \
    xz-utils \
    zip \
   && apt-get autoremove -y \
   && rm -rf /var/lib/apt/lists/* \
   && update-alternatives --install /usr/bin/python python /usr/bin/python3 10



 RUN python -m pip install --upgrade pip virtualenv

# To build the image for a branch or a tag of IDF, pass --build-arg IDF_CLONE_BRANCH_OR_TAG=name.
# To build the image with a specific commit ID of IDF, pass --build-arg IDF_CHECKOUT_REF=commit-id.
# It is possibe to combine both, e.g.:
#   IDF_CLONE_BRANCH_OR_TAG=release/vX.Y
#   IDF_CHECKOUT_REF=<some commit on release/vX.Y branch>.

ARG IDF_CLONE_URL=https://github.com/espressif/esp-idf.git
ARG IDF_CLONE_BRANCH_OR_TAG=master
ARG IDF_CHECKOUT_REF=

ENV IDF_PATH=/opt/esp/idf
ENV IDF_TOOLS_PATH=/opt/esp


RUN echo IDF_CHECKOUT_REF=$IDF_CHECKOUT_REF IDF_CLONE_BRANCH_OR_TAG=$IDF_CLONE_BRANCH_OR_TAG && \
    git clone --recursive \
      ${IDF_CLONE_BRANCH_OR_TAG:+-b $IDF_CLONE_BRANCH_OR_TAG} \
      $IDF_CLONE_URL $IDF_PATH && \
    if [ -n "$IDF_CHECKOUT_REF" ]; then \
      cd $IDF_PATH && \
      git checkout $IDF_CHECKOUT_REF && \
      git submodule update --init --recursive; \
    fi

# Install all the required tools, plus CMake
RUN $IDF_PATH/tools/idf_tools.py --non-interactive install required \
  && $IDF_PATH/tools/idf_tools.py --non-interactive install cmake \
  && $IDF_PATH/tools/idf_tools.py --non-interactive install-python-env \
  && rm -rf $IDF_TOOLS_PATH/dist

# Ccache is installed, enable it by default
ENV IDF_CCACHE_ENABLE=1

COPY ./docker/esp32/entrypoint.sh /opt/esp/entrypoint.sh

ARG TF_CLONE_URL=https://github.com/tensorflow/tensorflow.git
ARG TF_CLONE_BRANCH_OR_TAG=master
ARG TF_CHECKOUT_REF=

ENV TF_PATH=/opt/tensorflow

# Clone Tensorflow
RUN echo TF_CHECKOUT_REF=$TF_CHECKOUT_REF TF_CLONE_BRANCH_OR_TAG=$TF_CLONE_BRANCH_OR_TAG && \
   git clone --recursive \
     ${TF_CLONE_BRANCH_OR_TAG:+-b $TF_CLONE_BRANCH_OR_TAG} \
     $TF_CLONE_URL $TF_PATH && \
   if [ -n "$TF_CHECKOUT_REF" ]; then \
     cd $TF_PATH && \
     git checkout $TF_CHECKOUT_REF && \
     git submodule update --init --recursive; \
   fi

RUN ["chmod", "+x", "/opt/esp/entrypoint.sh"]
ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]

RUN echo '. $IDF_PATH/export.sh' >>~/.profile
CMD [ "/bin/bash" ]