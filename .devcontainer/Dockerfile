# Forza l’architettura x86 anche su Mac ARM
FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:noble

ARG LIBCE_VERSION="4.3"
ARG QEMU_VERSION="9.2.2-3"

ENV HOME=/home/vscode/

# Strumenti di base + dipendenze

RUN apt-get update && apt-get install -y \
    build-essential python3 python3-venv zlib1g-dev \
    libgtk-3-dev libpulse-dev libpixman-1-dev libjson-xs-perl \
    ninja-build ncurses-dev git wget curl unzip \
    gcc-multilib g++-multilib gdb gdb-multiarch nasm iverilog gtkwave \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Cartella di lavoro temporanea per build
WORKDIR /tmp/build-staging

# Installazione libce e QEMU custom (per Calcolatori Elettronici)
RUN wget https://calcolatori.iet.unipi.it/resources/libce-${LIBCE_VERSION}.tar.gz && \
    wget https://calcolatori.iet.unipi.it/resources/qemu-ce-${QEMU_VERSION}.tar.gz && \
    tar -xzvf libce-${LIBCE_VERSION}.tar.gz && \
    tar -xzvf qemu-ce-${QEMU_VERSION}.tar.gz && \
    cd libce-${LIBCE_VERSION} && \
    make CE_QEMU_AUDIO=none && make install && \
    cd ../qemu-ce-${QEMU_VERSION} && \
    sh ./install

# Aggiorna il PATH per usare CE
RUN echo 'PATH=$HOME/CE/bin:$PATH' >> /home/vscode/.bashrc

# Pulizia
RUN rm -rf /tmp/build-staging

# Torna all’utente vscode
USER vscode

WORKDIR /workspace