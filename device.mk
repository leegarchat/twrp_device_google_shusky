#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#
DEVICE_PATH := device/google/shusky

TARGET_BOARD_KERNEL_HEADERS := device/google/shusky-kernel/kernel-headers


$(call soong_config_set,google_displaycolor,displaycolor_platform,zuma)

PRODUCT_SHIPPING_API_LEVEL := 34
PRODUCT_TARGET_VNDK_VERSION := 34
TARGET_VNDK_VERSION := 34
PRODUCT_PLATFORM := zuma
AB_OTA_UPDATER := true
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/included-stuff/manifest.xml
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_ENFORCE_VINTF_MANIFEST := true
ACTUATOR_MODEL := luxshare_ict_081545
ADAPTIVE_HAPTICS_FEATURE := adaptive_haptics_v1



PRODUCT_COPY_FILES += $(DEVICE_PATH)/pixel-stuff/mm/pixel-mm.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/init/pixel-mm.rc
PRODUCT_COPY_FILES += $(DEVICE_PATH)/pixel-stuff/conf/init.factory.rc:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/init/hw/init.factory.rc

PRODUCT_PACKAGES += linker.vendor_ramdisk
PRODUCT_PACKAGES += resize2fs.vendor_ramdisk
PRODUCT_PACKAGES += fsck.vendor_ramdisk
PRODUCT_PACKAGES += tune2fs.vendor_ramdisk
PRODUCT_PACKAGES += fstab.zuma.vendor_ramdisk
PRODUCT_PACKAGES += fstab.zuma-fips.vendor_ramdisk
# PRODUCT_PACKAGES += auditctl
# PRODUCT_PACKAGES += logd
# PRODUCT_PACKAGES += logcat
# PRODUCT_PACKAGES += resize2fs.vendor_ramdisk
PRODUCT_PACKAGES += resize.f2fs.vendor_ramdisk
PRODUCT_PACKAGES += linker_hwasan64.vendor_ramdisk
# PRODUCT_PACKAGES += fsck.f2fs.vendor_ramdisk
PRODUCT_PACKAGES += dump.f2fs.vendor_ramdisk
PRODUCT_PACKAGES += defrag.f2fs.vendor_ramdisk

PRODUCT_PACKAGES += libtrusty
PRODUCT_PACKAGES += update_engine_sideload
# PRODUCT_PACKAGES += servicemanager
# PRODUCT_PACKAGES += servicemanager.rc
# PRODUCT_PACKAGES += hwservicemanager.rc
PRODUCT_PACKAGES += vndservicemanager
PRODUCT_PACKAGES += vndservice
# PRODUCT_PACKAGES += vndservicemanager.rc
PRODUCT_PACKAGES += libhidltransport.vendor
PRODUCT_PACKAGES += libdisplaycolor
PRODUCT_PACKAGES += audioroute 
PRODUCT_PACKAGES += libaudioroutelite
# PRODUCT_PACKAGES += mm_logd
# PRODUCT_PACKAGES += libion
PRODUCT_PACKAGES += PixelLogger
PRODUCT_PACKAGES_DEBUG += PixelLogger

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so
# RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libion.so
# RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdmabufheap.so

# HAL bootctrl pixel
# PRODUCT_PACKAGES += android.hardware.vibrator-service.cs40l26
# PRODUCT_PACKAGES += android.hardware.vibrator-impl.cs40l26
# PRODUCT_PACKAGES += android.hardware.vibrator-service.cs40l26.recovery
# PRODUCT_PACKAGES += android.hardware.vibrator-impl.cs40l26.recovery
PRODUCT_PACKAGES += android.hardware.boot@1.2-service-pixel
PRODUCT_PACKAGES += android.hardware.boot@1.2-impl-pixel
PRODUCT_PACKAGES += bootctl
# PRODUCT_PACKAGES += android.hardware.boot-service.default_recovery-pixel
# PRODUCT_PACKAGES += android.hardware.boot-service.default-pixel
PRODUCT_PACKAGES += android.hardware.fastboot@1.1-impl-pixel \
	fastbootd

AB_OTA_POSTINSTALL_CONFIG += RUN_POSTINSTALL_system=true
AB_OTA_POSTINSTALL_CONFIG += POSTINSTALL_PATH_system=system/bin/otapreopt_script
AB_OTA_POSTINSTALL_CONFIG += POSTINSTALL_OPTIONAL_system=true
AB_OTA_POSTINSTALL_CONFIG += FILESYSTEM_TYPE_system=ext4


PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.0.brightness.dimming.usage?=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.support_kernel_idle_timer=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.lbe.supported=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.0.brightness.acl.default=0
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.display.primary.boot_config=1008x2244@120
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.preferred_mode=1008x2244@120
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_idle_timer_ms?=80
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_touch_timer_ms=200
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_display_power_timer_ms=1000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.use_content_detection_for_refresh_rate=true
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.0.brightness.dimming.usage=2

PRODUCT_VENDOR_PROPERTIES += vendor.primarydisplay.op.hs_hz=120 
PRODUCT_VENDOR_PROPERTIES += vendor.primarydisplay.op.ns_hz=120
PRODUCT_VENDOR_PROPERTIES += vendor.primarydisplay.op.ns_min_dbv=1172
PRODUCT_VENDOR_PROPERTIES += vendor.primarydisplay.min_idle_refresh_rate.default=1
PRODUCT_VENDOR_PROPERTIES += vendor.primarydisplay.min_idle_refresh_rate.blocking_zone_dbv=492
PRODUCT_VENDOR_PROPERTIES += vendor.primarydisplay.min_idle_refresh_rate.blocking_zone=10
PRODUCT_VENDOR_PROPERTIES += ro.support_hide_display_cutout=true
PRODUCT_VENDOR_PROPERTIES += persist.sys.fuse.passthrough.enable=true

PRODUCT_PROPERTY_OVERRIDES += vendor.audio.mic_break=true
PRODUCT_PROPERTY_OVERRIDES += debug.sf.disable_backpressure=0
PRODUCT_PROPERTY_OVERRIDES += debug.sf.enable_gl_backpressure=1
PRODUCT_PROPERTY_OVERRIDES += debug.sf.enable_sdr_dimming=1
PRODUCT_PROPERTY_OVERRIDES += debug.sf.dim_in_gamma_in_enhanced_screenshots=1
PRODUCT_PROPERTY_OVERRIDES += persist.sys.sf.native_mode=2
PRODUCT_PROPERTY_OVERRIDES += ro.zram.mark_idle_delay_mins=60
PRODUCT_PROPERTY_OVERRIDES += ro.zram.first_wb_delay_mins=1440
PRODUCT_PROPERTY_OVERRIDES += ro.zram.periodic_wb_delay_hours=24
PRODUCT_PROPERTY_OVERRIDES += service.adb.root=1
PRODUCT_PROPERTY_OVERRIDES += vendor.disable.thermal.control=1
PRODUCT_PROPERTY_OVERRIDES += ro.vendor.factory=1
PRODUCT_PROPERTY_OVERRIDES += debug.disable_screen_decorations=true
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.vendor.camera.fatp.enable=1
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += init.svc_debug.no_fatal.zygote=true
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += persist.device_config.configuration.disable_rescue_party=true
