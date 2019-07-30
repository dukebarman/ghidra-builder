# About

Common docker image for building software reverse engineering (SRE) framework [Ghidra](https://www.ghidra-sre.org/) from Github's source.

# Using

Create a docker image:

```
sudo docker-tpl/build
```

Run the build script from the working directory:

```
cd workdir
sudo ../docker-tpl/run ./build_ghidra.sh
```

It will clone a ghidra repository to the current directory and copy build to `out` dir:

```
ls    
build_ghidra.sh  ghidra out
```

At the next time, update this ghidra repo, checkout needed commit or patch:

```
cd workdir
git pull
```
