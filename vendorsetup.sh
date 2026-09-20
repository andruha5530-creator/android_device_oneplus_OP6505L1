#!/bin/bash

FDEVICE="OP6505L1"

fox_get_target_device() {
    local chkdev=$(echo "$BASH_SOURCE" | grep -w "$FDEVICE")
    if [ -n "$chkdev" ]; then
        FOX_BUILD_DEVICE="$FDEVICE"
    else
        chkdev=$(set | grep BASH_ARGV | grep -w "$FDEVICE")
        [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
    fox_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [ "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export FOX_BUILD_DEVICE="$FDEVICE"
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
fi

add_lunch_combo omni_OP6505L1-eng
