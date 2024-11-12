#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit device configuration

DEVICE_PATH := device/google/shusky


$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)
$(call inherit-product, $(DEVICE_PATH)/device.mk)

PRODUCT_DEVICE := shusky
PRODUCT_NAME := twrp_shusky
PRODUCT_BRAND := google
PRODUCT_MODEL := Pixel 8
PRODUCT_MANUFACTURER := google

PRODUCT_GMS_CLIENTID_BASE := android-google

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="shusky-user 15 AP3A.241005.015 12366759 release-keys" \
    BuildFingerprint=google/shusky/shusky:15/AP3A.241005.015/12366759:user/release-keys \
    DeviceProduct=shusky

PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

PRODUCT_SET_DEBUGFS_RESTRICTIONS := true





# DEVICE_PACKAGE_OVERLAYS += device/google/zuma/overlay-factory



