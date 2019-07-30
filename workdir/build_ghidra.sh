#!/bin/bash
set -ex

START_DIR=$(pwd)
OUTPUT_DIR=$START_DIR/out

rm -rf $OUTPUT_DIR || true
mkdir -p $OUTPUT_DIR

if [ ! -d "ghidra" ]; then
    git clone https://github.com/NationalSecurityAgency/ghidra
fi

ln -s $HOME/ghidra.bin ghidra.bin # hack

cd $START_DIR/ghidra
gradle yajswDevUnpack
gradle buildGhidra
cp build/dist/*.zip $OUTPUT_DIR
unlink $START_DIR/ghidra.bin
