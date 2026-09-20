#!/bin/bash

# OnePlus Nord CE 6 / OP6505L1
# OrangeFox build variables must be exported from a shell script.

export FOX_BUILD_DEVICE="OP6505L1"
export FOX_AB_DEVICE=1
export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1

export FOX_VANILLA_BUILD=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_DATE_BINARY=1
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1

export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
