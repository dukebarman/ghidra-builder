# About

Common docker image for building software reverse engineering (SRE) framework [Ghidra](https://www.ghidra-sre.org/) from github's source.

# Using

Create an image and compile Ghidra for the first time:

```
git clone https://github.com/dukebarman/ghidra-builder
cd ghidra-builder
docker build -t="dukebarman/ghidra-builder" .
```

At the next time, update from git, compile new release and copy to current host directory (it mounts current directory as `/opt` for image): 

```
docker run -v `pwd`:/opt dukebarman/ghidra-builder /bin/bash -c 'cd /root/git/ghidra && git pull && gradle yajswDevUnpack && gradle buildGhidra && cp /root/git/ghidra/build/dist/*.zip /opt'
```
