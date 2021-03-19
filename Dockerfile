FROM ubuntu:trusty-20180112

MAINTAINER Erwin "m9207216@gmail.com"

#RUN linux32 sed -i 's/archive.ubuntu.com/tw.archive.ubuntu.com/g' /etc/apt/sources.list
#RUN linux32 sed -i 's/archive.ubuntu.com/ubuntu.stu.edu.tw/g' /etc/apt/sources.list
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y make \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y git \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y vim.tiny \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y curl \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y python \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y bison \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y g++-multilib gcc-multilib\
 && DEBIAN_FRONTEND=noninteractive apt-get install -y flex\
 && DEBIAN_FRONTEND=noninteractive apt-get install -y zip unzip\
 && DEBIAN_FRONTEND=noninteractive apt-get install -y libxml2-utils\
 && DEBIAN_FRONTEND=noninteractive apt-get install -y bsdiff\
 && DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg gperf lib32ncurses5-dev\
 && DEBIAN_FRONTEND=noninteractive apt-get install -y libswitch-perl\
#for zlib.so.1
 && DEBIAN_FRONTEND=noninteractive apt-get install -y lib32z1 libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5\
#kernel mkimage
 && DEBIAN_FRONTEND=noninteractive apt-get install -y u-boot-tools \
#external/mtd-utils
 && DEBIAN_FRONTEND=noninteractive apt-get install -y uuid-dev zlib1g-dev liblzo2-dev \
#fix build jht3 uboot ,/bin/sh: bc: command not found
 && DEBIAN_FRONTEND=noninteractive apt-get install -y bc \
#for sp8388
 && DEBIAN_FRONTEND=noninteractive apt-get install -y ccache \
 && rm -rf /var/lib/apt/lists/*

#fix zconf.h error
RUN ln -s /usr/include/x86_64-linux-gnu/zconf.h /usr/include

# All builds will be done by user aosp
COPY gitconfig /root/.gitconfig
COPY ssh_config /root/.ssh/config

#bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

WORKDIR /mnt/aosp

COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
COPY utils/aosp_bashrc.sh /root/aosp_bashrc.sh
RUN chmod +x /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]
