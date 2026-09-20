LOCAL_PATH := $(call my-dir)

PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.device=OP6505L1 \
    ro.product.model="OnePlus Nord CE 6"
