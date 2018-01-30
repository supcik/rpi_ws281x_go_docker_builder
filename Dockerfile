FROM golang

LABEL maintainer="jacques@supcik.net"

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    git \
    scons \
    binutils-arm-linux-gnueabihf \
    gcc-arm-linux-gnueabihf

RUN cd /usr/local/src; \
  git clone https://github.com/jgarff/rpi_ws281x.git; \
  cd rpi_ws281x; \
  scons TOOLCHAIN=arm-linux-gnueabihf; \
  cp *.a /usr/local/lib; \
  cp *.h /usr/local/include; \
  scons TOOLCHAIN=arm-linux-gnueabihf --clean

ENV GOOS=linux
ENV GOARCH=arm
ENV CGO_ENABLED=1
ENV CC=arm-linux-gnueabihf-gcc
ENV CC_FOR_TARGET=arm-linux-gnueabihf-gcc
ENV CXX_FOR_TARGET=arm-linux-gnueabihf-g++
ENV CPATH=/usr/local/include
ENV LIBRARY_PATH=/usr/local/lib
