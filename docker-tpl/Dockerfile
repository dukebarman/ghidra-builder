FROM ubuntu:20.04

MAINTAINER @dukebarman

ARG gradle_version=7.3
ARG jdk_version=17

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
        wget \
		xvfb

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository ppa:openjdk-r/ppa -y
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openjdk-$jdk_version-jdk \        
    && rm -r /var/lib/apt/lists/*

RUN groupadd -g 1000 dockerbot && useradd -g 1000 -u 1000 -m dockerbot
USER dockerbot

# Build tools are part of the builder image; project code is mounted
RUN mkdir -p $HOME/.gradle/init.d/

RUN wget https://services.gradle.org/distributions/gradle-$gradle_version-bin.zip -P /tmp
RUN unzip -d $HOME/gradle /tmp/gradle-*.zip

ENV GRADLE_HOME=/home/dockerbot/gradle/gradle-$gradle_version
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
