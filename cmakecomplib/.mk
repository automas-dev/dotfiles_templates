#!/bin/bash

mkdir build
cd build

BUILD_SYSTEM=""

if command -v ninja; then
	BUILD_SYSTEM="-GNinja"
fi

cmake .. $BUILD_SYSTEM -DCMAKE_INSTALL_PREFIX=install

