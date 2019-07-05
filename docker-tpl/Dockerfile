FROM ubuntu:18.04

MAINTAINER @dukebarman

RUN echo Europe/London > /etc/timezone
RUN echo tzdata tzdata/Areas select Europe | debconf-set-selections
RUN echo tzdata tzdata/Zones/Europe select London | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        bison \
        build-essential \
        curl \
        flex \
        g++ \
        gcc \
        git \
        make \
        software-properties-common \
        unzip \
        wget

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:openjdk-r/ppa -y
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openjdk-11-jdk \        
    && rm -r /var/lib/apt/lists/*

RUN groupadd -g 1000 dockerbot && useradd -g 1000 -u 1000 -m dockerbot
USER dockerbot

# Build tools are part of the builder image; project code is mounted
RUN mkdir -p $HOME/.gradle/init.d/

RUN wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp
RUN unzip -d $HOME/gradle /tmp/gradle-*.zip

ENV GRADLE_HOME=/home/dockerbot/gradle/gradle-5.0
ENV PATH=$GRADLE_HOME/bin:$PATH

RUN echo "\
ext.HOME = System.getProperty('user.home')\n\
\n\
allprojects {\n\
    repositories {\n\
        mavenCentral()\n\
        jcenter()\n\
        flatDir name:'flat', dirs:[\"$HOME/flatRepo\"]\n\
    }\n\
}\n\
" > $HOME/.gradle/init.d/repos.gradle

RUN mkdir $HOME/flatRepo
WORKDIR /tmp
RUN curl -OL https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip && \
    unzip dex-tools-2.0.zip && \
    cp dex2jar-2.0/lib/dex-*.jar $HOME/flatRepo/

RUN curl -OL https://sourceforge.net/projects/catacombae/files/HFSExplorer/0.21/hfsexplorer-0_21-bin.zip && \
    mkdir hfsx

RUN curl -OL https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-12.12/yajsw-stable-12.12.zip && \
mkdir -p $HOME/ghidra.bin/Ghidra/Features/GhidraServer/ && \
cp /tmp/yajsw-stable-12.12.zip $HOME/ghidra.bin/Ghidra/Features/GhidraServer/

WORKDIR /tmp/hfsx
RUN unzip ../hfsexplorer-0_21-bin.zip && \
    cp lib/csframework.jar lib/hfsx_dmglib.jar lib/hfsx.jar lib/iharder-base64.jar $HOME/flatRepo/

WORKDIR /home/dockerbot/flatRepo 
RUN curl -OL https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar