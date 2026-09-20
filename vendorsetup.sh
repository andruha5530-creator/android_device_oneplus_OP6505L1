#!/usr/bin/env bash

# OnePlus Nord CE 6 / OP6505L1
FDEVICE="OP6505L1"

fox_get_target_device() {
    local script_path
    script_path="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
    if echo "$script_path" | grep -qw "$FDEVICE"; then
        FOX_BUILD_DEVICE="$FDEVICE"
    elif echo "${BASH_ARGV[*]}" | grep -qw "$FDEVICE"; then
        FOX_BUILD_DEVICE="$FDEVICE"
    fi
}

if [ -z "${FOX_BUILD_DEVICE:-}" ]; then
    fox_get_target_device
fi

if [ "${FOX_BUILD_DEVICE:-}" = "$FDEVICE" ]; then
    export FOX_BUILD_DEVICE="$FDEVICE"
    export FOX_AB_DEVICE=1
    export FOX_VIRTUAL_AB_DEVICE=1
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
    echo "Detected OrangeFox build device: $FOX_BUILD_DEVICE"
else
    echo "I: vendorsetup.sh skipped; device mismatch or environment issue."
fi
