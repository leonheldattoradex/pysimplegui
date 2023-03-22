ARG BASE_NAME=wayland-base-vivante
ARG IMAGE_ARCH=linux/arm64/v8
ARG IMAGE_TAG=3
ARG DOCKER_REGISTRY=torizon
ARG DEBIAN_FRONTEND=noninteractive

FROM --platform=$IMAGE_ARCH $DOCKER_REGISTRY/$BASE_NAME:$IMAGE_TAG

WORKDIR /home/torizon

#### Install GPU Drivers ####
RUN apt-get -y update && apt-get install -y --no-install-recommends \
    imx-gpu-viv-wayland-dev \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

#### Install Python and other utilities ####
RUN apt-get -y update && apt-get install -y --no-install-recommends \
    python3 python3-venv wget python3-pip python3-tk \
    && apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages --no-cache-dir pysimplegui

ENV NO_AT_BRIDGE 1

COPY pysimplegui-example.py .

ENTRYPOINT ["python3"]
CMD ["pysimplegui-example.py"]
