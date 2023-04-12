# Using the Ubuntu image (our OS)
FROM ubuntu:latest
# Update package manager (apt-get) 
# and install (with the yes flag `-y`)
# Python and Pip

RUN apt-get update && apt-get install -y gnupg2 ca-certificates wget software-properties-common curl

RUN apt-get install -y \
    python3.11 \
    python3-pip \
    git \
    cmake \
    ninja-build

RUN mkdir /root/.ssh

RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

ENV NODE_VERSION=19.5.0
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

RUN npm install -g quicktype
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt install -y gcc-11 g++-11
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 10
RUN apt-get install -y libboost-all-dev libeigen3-dev

RUN mkdir -p /home/openmagnetics
WORKDIR /home/openmagnetics

RUN git clone https://github.com/OpenMagnetics/.github.git OpenMagnetics

WORKDIR /home/openmagnetics/OpenMagnetics
RUN rm -rf MVB && mkdir -p MVB && git clone https://github.com/OpenMagnetics/MVB.git
RUN rm -rf MKF && mkdir -p MKF && git clone https://github.com/OpenMagnetics/MKF.git
RUN rm -rf MAS && mkdir -p MAS && git clone https://github.com/OpenMagnetics/MAS.git

WORKDIR /home/openmagnetics/OpenMagnetics/MAS
RUN mkdir build && cd build
WORKDIR /home/openmagnetics/OpenMagnetics/MAS/build
RUN cmake .. -G "Ninja"
RUN cmake --build .

WORKDIR /home/openmagnetics/OpenMagnetics/MKF
RUN mkdir build && cd build
WORKDIR /home/openmagnetics/OpenMagnetics/MKF/build
RUN cmake .. -G "Ninja"
RUN python3 -m pip install -e ../ -vvv
RUN cmake --build .

RUN add-apt-repository ppa:freecad-maintainers/freecad-daily
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y -qq freecad-daily

WORKDIR /home/openmagnetics/OpenMagnetics/MVB
RUN python3 -m pip install -r requirements.txt
