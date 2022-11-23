# About

Common docker image for building software reverse engineering (SRE) framework [Ghidra](https://www.ghidra-sre.org/) from Github's or private fork's source.

# Using

Clone the repository:

```
git clone https://github.com/dukebarman/ghidra-builder
cd ghidra-builder
```

Create a docker image (if your user is in docker group, you may execute commands without sudo):

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
cd workdir/ghidra
git pull
```

And for testing other branches, for example, with new debugger feature, you may make `checkout`:

```
cd workdir/ghidra # if you didn't make it earlier
git checkout debugger
```

# Errors

## Building process doesn't finish properly with gradle or jdk versions errors

In `docker-tpl/Dockerfile` you can find versions for gradle and jdk:

```
ARG gradle_version=7.3
ARG jdk_version=17
```

You can change manually with your favorite editor or run docker building with `--build-arg` 

## Some files without executable flag

After building a few files sometimes don't have executable flag:

```
chmod +x ./GPL/DemanglerGnu/os/linux64/demangler_gnu
chmod +x ./GPL/CabExtract/os/linux64/cabextract
chmod +x ./Ghidra/Features/Decompiler/os/linux64/decompile
chmod +x ./support/launch.sh
chmod +x ghidraRun
```

Or copy and use `set_exec_flag.sh` script to unzipped ghidra folder.

# Testing

The Developers've added scripts for testing so you may uncomment `Tests` section in `build_ghidra.sh`.
