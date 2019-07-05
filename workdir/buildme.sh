#!/bin/bash
set -ex

START_DIR=$(pwd)
GRADLE_VERSION=5.0
OUTPUT_DIR=$START_DIR/out

rm -rf $OUTPUT_DIR || true
mkdir -p $OUTPUT_DIR

if [ ! -d "ghidra" ]; then
    git clone --depth=1 https://github.com/NationalSecurityAgency/ghidra
fi

ln -s $HOME/ghidra.bin ghidra.bin

cd $START_DIR/ghidra
gradle yajswDevUnpack
gradle buildGhidra
cp build/dist/*.zip $OUTPUT_DIR
