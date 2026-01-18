FROM i386/debian:bookworm-slim

LABEL description="Cadabra Container (32-bit)"

# Configure Mirrors
# You may remove it if you can connect to the official mirrors

RUN rm -f /etc/apt/sources.list.d/* && \
    echo \
    "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware\n\
    deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware\n\
    deb http://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware\n\
    deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware" \
    > /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cadabra2 libgmpxx4ldbl python3-sympy \
    && rm -rf /var/lib/apt/lists/*
    
RUN mkdir -p /usr/lib/python3.11/dist-packages && \
    ln -s /usr/lib/python3/dist-packages/cadabra2_defaults.py /usr/lib/python3.11/dist-packages/cadabra2_defaults.py

WORKDIR /workspace
ENTRYPOINT ["cadabra2"]
