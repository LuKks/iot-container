FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive
ENV IDF_EXPORT_QUIET=true

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    make \
    cmake \
    nano \
    python3.12-venv \
    libhidapi-libusb0 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone -b v5.2.1 --recursive https://github.com/espressif/esp-idf.git

WORKDIR /root/esp-idf

RUN ./install.sh

# Precomputing saves ~1 second when spawning the shell
# RUN echo "source /root/esp-idf/export.sh" >> ~/.bashrc

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
