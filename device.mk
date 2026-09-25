LOCAL_PATH := $(call my-dir)

PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.device=OP6505L1 \
    ro.product.model="OnePlus Nord CE 6"


# Qualcomm / GKI recovery support, based on the matching SM7635 recovery
# trees and the stock OP6505L1 recovery service layout.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Boot control / slot switching.
PRODUCT_PACKAGES +=     android.hardware.boot-service.qti     android.hardware.boot-service.qti.recovery

PRODUCT_PACKAGES_DEBUG +=     bootctl

# FastbootD and OTA helpers used by modern A/B recovery trees.
PRODUCT_PACKAGES +=     fastbootd     update_engine     update_engine_sideload     update_verifier     checkpoint_gc     otapreopt_script

PRODUCT_PACKAGES_DEBUG +=     update_engine_client

# Qualcomm FBE recovery helpers.
PRODUCT_PACKAGES +=     qcom_decrypt     qcom_decrypt_fbe

# OrangeFox recovery-specific A/B and boot-control behavior.
OF_AB_DEVICE_WITH_RECOVERY_PARTITION := 1
OF_USE_AIDL_BOOT_CONTROL := 1

# Keep OrangeFox from replacing the Qualcomm USB setup supplied by stock init.
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_INCLUDE_OMAPI := true
