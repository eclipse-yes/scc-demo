#!/bin/bash

make clean
make grammar
make parser
make build
cd build
make all
