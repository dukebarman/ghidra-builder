FROM ubuntu:18.04

MAINTAINER @dukebarman

RUN apt-get update \
	&& apt-get install -y \
		gcc \
		bison \
		flex \
		make \
		unzip \
		curl \
		wget \
		git \
		g++ \
		build-essential \
		software-properties-common 

RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get update \
	&& apt-get install -y \
		openjdk-11-jdk \ 		
	&& rm -r /var/lib/apt/lists/*

RUN mkdir /root/git
WORKDIR /root/git
RUN git clone https://github.com/NationalSecurityAgency/ghidra
RUN mkdir -p ~/.gradle/init.d/

RUN wget https://services.gradle.org/distributions/gradle-5.0-bin.zip -P /tmp
RUN unzip -d /root/gradle /tmp/gradle-*.zip

ENV GRADLE_HOME=/root/gradle/gradle-5.0
ENV PATH $GRADLE_HOME/bin:$PATH

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
" > ~/.gradle/init.d/repos.gradle


RUN mkdir ~/flatRepo
WORKDIR /tmp
RUN curl -OL https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip && \
	unzip dex-tools-2.0.zip && \
	cp dex2jar-2.0/lib/dex-*.jar ~/flatRepo/

RUN curl -OL https://sourceforge.net/projects/catacombae/files/HFSExplorer/0.21/hfsexplorer-0_21-bin.zip && \
	mkdir hfsx

RUN	curl -OL https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-12.12/yajsw-stable-12.12.zip && \
	mkdir -p ~/git/ghidra.bin/Ghidra/Features/GhidraServer/ && \
	cp /tmp/yajsw-stable-12.12.zip ~/git/ghidra.bin/Ghidra/Features/GhidraServer/

WORKDIR /tmp/hfsx
RUN	unzip ../hfsexplorer-0_21-bin.zip && \
	cp lib/csframework.jar lib/hfsx_dmglib.jar lib/hfsx.jar lib/iharder-base64.jar ~/flatRepo/

WORKDIR /root/flatRepo 
RUN curl -OL https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar

WORKDIR /root/git/ghidra
RUN gradle yajswDevUnpack
RUN gradle buildGhidra
RUN cp build/dist/*.zip /opt

WORKDIR /opt
