FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive
ENV IDF_EXPORT_QUIET=true

RUN apt-get update && apt-get install -y \
    git \
    cmake \
    nano \
    python3.12-venv \
    libhidapi-libusb0

WORKDIR /root/esp

RUN git clone --recursive https://github.com/espressif/esp-idf.git

WORKDIR /root/esp/esp-idf

RUN ./install.sh
RUN echo "source /root/esp/esp-idf/export.sh" >> ~/.bashrc

WORKDIR /mnt/cwd

ENTRYPOINT ["/bin/bash"]
