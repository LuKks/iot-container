FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive
ENV IDF_EXPORT_QUIET=true

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    nano \
    python3.12-venv \
    libhidapi-libusb0

WORKDIR /root

RUN git clone -b v5.2.1 --recursive https://github.com/espressif/esp-idf.git

WORKDIR /root/esp-idf

RUN ./install.sh

# Precomputing saves ~1 second when spawning the shell
# RUN echo "source /root/esp-idf/export.sh" >> ~/.bashrc

COPY ./env-precompute.sh /tmp/env-precompute.sh
RUN chmod +x /tmp/env-precompute.sh && \
    /tmp/env-precompute.sh

WORKDIR /mnt/cwd

ENTRYPOINT ["/bin/bash"]
