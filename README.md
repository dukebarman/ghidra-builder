# About

Common docker image for building software reverse engineering (SRE) framework [Ghidra](https://www.ghidra-sre.org/) from github's source.

# Using

Create a docker image:

```
sudo docker-tpl/build
```

Run the build script from the working directory:

```
cd workdir
sudo ../docker-tpl/run buildme.sh
```

# Changes from Duke's version
1. Image builder and runner are separate scripts
2. Ghidra source code moved outside of docker image
3. Ghidra builder is a script outside of Dockerfile
