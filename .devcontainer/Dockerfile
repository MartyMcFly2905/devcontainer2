# Dockerfile aggiornato

FROM mcr.microsoft.com/devcontainers/base:noble

ARG LIBCE_VERSION="4.3"
ARG QEMU_VERSION="9.2.2-3"

ENV HOME=/home/vscode/

# Strumenti di base + dipendenze
RUN apt-get update && apt-get install -y \
    build-essential python3 python3-venv zlib1g-dev \
    libgtk-3-dev libpulse-dev libpixman-1-dev libjson-xs-perl \
    ninja-build ncurses-dev git wget curl unzip \
    gcc-multilib g++-multilib gdb nasm iverilog gtkwave \
    # Dipendenze per PowerShell
    libc6 libgcc1 libgssapi-krb5-2 libicu74 libssl3 libstdc++6 zlib1g \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# --- NUOVA SEZIONE: INSTALLAZIONE POWERSHELL ---
# Installa PowerShell per poter usare gli script .ps1 come all'esame
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/powershell_7.4.3-1.deb_amd64.deb && \
    dpkg -i powershell_7.4.3-1.deb_amd64.deb && \
    # Installa dipendenze mancanti se ce ne sono
    apt-get install -f && \
    # Pulisce il file scaricato
    rm powershell_7.4.3-1.deb_amd64.deb
# ---------------------------------------------

WORKDIR /tmp/build-staging

# ...ecc.

# Cartella di lavoro per il download e la compilazione
WORKDIR /tmp/build-staging

# Installazione libce e QEMU custom (Calcolatori Elettronici)
# Spostato in un unico RUN layer per una migliore gestione della cache e pulizia
RUN wget https://calcolatori.iet.unipi.it/resources/libce-${LIBCE_VERSION}.tar.gz && \
    wget https://calcolatori.iet.unipi.it/resources/qemu-ce-${QEMU_VERSION}.tar.gz && \
    tar -xzvf libce-${LIBCE_VERSION}.tar.gz && \
    tar -xzvf qemu-ce-${QEMU_VERSION}.tar.gz && \
    cd libce-${LIBCE_VERSION} && \
    make CE_QEMU_AUDIO=none && make install && \
    cd ../qemu-ce-${QEMU_VERSION} && \
    sh ./install

# Aggiunge il percorso di CE al PATH per l'utente vscode
RUN echo 'PATH=$HOME/CE/bin:$PATH' >> /home/vscode/.bashrc

# Pulisce i file sorgente dopo l'installazione
RUN rm -rf /tmp/build-staging

# Cambia all'utente non-root come ultima operazione prima dell'uso
USER vscode

# Imposta la cartella di lavoro per l'utente finale
WORKDIR /workspace

# Non serve più qui perché è nel devcontainer.json
# COPY ./bin/scarica-esame $HOME/CE/bin