FROM ubuntu:noble

ARG ESP_IDF_VERSION=5.2.2

ENV DEBIAN_FRONTEND=noninteractive
ENV IDF_EXPORT_QUIET=true
ENV IDF_CCACHE_ENABLE=true

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    make \
    cmake \
    nano \
    python3.12-venv \
    libhidapi-libusb0 \
    ccache && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone -b v${ESP_IDF_VERSION} --depth=1 https://github.com/espressif/esp-idf.git && \
    cd esp-idf && \
    git submodule update --init --recursive --depth=1

WORKDIR /root/esp-idf

RUN ./install.sh esp32

COPY ./env-precompute.sh /tmp/env-precompute.sh
RUN chmod +x /tmp/env-precompute.sh && \
    /tmp/env-precompute.sh && \
    rm /tmp/env-precompute.sh

WORKDIR /root

RUN apt-get update && apt-get install -y \
    curl && \
    curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN npm i -g iot-dev

WORKDIR /mnt/cwd

ENTRYPOINT ["/bin/bash"]
