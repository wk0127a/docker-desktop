FROM debian:stable

ARG DEBIAN_FRONTEND="noninteractive"

# workdir
WORKDIR /root

RUN \
  echo "*** install package ***" && \
  apt-get update && apt-get install -y apt-utils && apt-get upgrade -y  && \
  apt-get -y install --fix-missing \
    openssh-server \
    openssh-client \
    dnsutils \
    restic \ 
    whois \
    borgbackup \
    vim \
    gnupg \
    gzip \
    iptables \
    kpcli \
    mailutils \
    make \
    mosh \
    rsync \
    screen \
    mtr-tiny \
    traceroute \
    python3 \
    rclone \
    wget \
    less \
    podget \
    cron \
    dialog \
    zip \
    unzip \
    ffmpeg \
    wireguard \
    openresolv \
    transmission-daemon \
    locales \
    tzdata \
    git \
    cron-apt \
    telnet \
    curl \
    rename \
    man \
    file \
    dict \
    gcc \
    nmap \
    libpurple-dev \
    libjson-glib-dev \
    libglib2.0-dev \
    libprotobuf-c-dev \
    protobuf-c-compiler \
    finch \
    libjson-perl \
    iproute2 \
    iputils-ping \
    dbus-x11 \
    terminator \
    task-xfce-desktop \ 
    tigervnc-standalone-server \
    xrdp \
    purple-discord \
    python3-pip \
    golang \ 
    azure-cli \
    gpg \
    apt-transport-https \
    tmux

RUN \
  echo " *** compile hangout ***" && \
  git clone https://github.com/EionRobb/purple-hangouts && cd purple-hangouts && make && make install && \
  echo " *** configure x ***" && \
  echo "startxfce4" > /etc/skel/.xsession && \
  echo " *** generate locale ***" && \
  locale-gen en_US.UTF-8  
#  echo " *** add dotnet sdk source *** " && \
#  wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
#  dpkg -i packages-microsoft-prod.deb && \
#  rm packages-microsoft-prod.deb && \
#  echo " *** add vscode source *** " && \
#  curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - && \
#  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
#  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list && \
#  rm -f packages.microsoft.gpg && \
#  echo " *** install dotnetsdk and code ***" && \
#  apt-get update && \
#  apt-get install -y code dotnet-sdk-6.0
  

RUN \ 
  echo " *** set locales ***" && \
  rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8 && \
  echo 'LANG=en_US.UTF-8; export LANG' >> /etc/profile  && \
  echo "**** cleanup ****" && \
  apt-get remove -y patch && \
  apt-get autoremove -y && \
  apt-get clean -y && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /etc/cron.d/anacron \
    /etc/cron.daily/0anacron

# environment
ENV HOME="/root" \
LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8" \
LC_CTYPE="en_US.UTF-8" \
TERM="xterm"


COPY ./build/startup.sh /usr/bin/startup.sh

ENTRYPOINT "/usr/bin/startup.sh"

# ports and volumes
EXPOSE 3389 22
