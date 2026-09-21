$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, device/oneplus/OP6505L1/device.mk)

PRODUCT_DEVICE := OP6505L1
PRODUCT_NAME := twrp_OP6505L1
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := OnePlus Nord CE 6
PRODUCT_MANUFACTURER := oneplus
