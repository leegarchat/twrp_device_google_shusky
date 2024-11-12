

# mkdir /tmp/test_sh

[ -f /system/bin/magiskboot_28 ] || exit 24
MG="/system/bin/magiskboot_28"
FD=50

print(){
    echo -e "ui_print $1\nui_print" >>"/proc/self/fd/$FD"
}
print "- Starting reflash current recovery"

if [ -f "/dev/current_vendor_boot_backup/current_vendor_boot.img" ] ; then
    print "- Detected a backup image of the current recovery; this will be quick!"
    mkdir -pv /dev/repack_vboot/fox
    cd /dev/repack_vboot/fox
    $MG unpack /dev/current_vendor_boot_backup/current_vendor_boot.img
    [ -f /dev/repack_vboot/fox/vendor_ramdisk/recovery.cpio ] || {
        print "- Backup of ofox is missing recovery.cpio"
        exit 22
    }
    [ -f /dev/repack_vboot/fox/vendor_ramdisk/ramdisk.cpio ] || {
        print "- Backup of ofox is missing ramdisk.cpio"
        exit 22
    }
    rm -f /dev/repack_vboot/fox/dtb
    cd /dev/repack_vboot/fox/
    $MG repack /dev/current_vendor_boot_backup/current_vendor_boot.img
    for slot in _a _b ; do
        cat /dev/repack_vboot/fox/new-boot.img > /dev/block/by-name/vendor_boot$slot
        print "- Successfully flashed recovery to slot $slot."
        # print "- Unpacking vendor_boot$slot!"
        # mkdir -pv /dev/repack_vboot/vboot$slot
        # cd /dev/repack_vboot/vboot$slot
        # $MG unpack /dev/block/by-name/vendor_boot$slot
        # if [ ! -f vendor_ramdisk/recovery.cpio ] && [ -f vendor_ramdisk/ramdisk.cpio ]; then
        #     cp /dev/repack_vboot/fox/vendor_ramdisk/recovery.cpio vendor_ramdisk/recovery.cpio
        #     for f in $($MG cpio vendor_ramdisk/ramdisk.cpio ls | grep -v first_stage_ramdisk | awk '{print $7}') ; do 
        #         $MG cpio vendor_ramdisk/ramdisk.cpio "rm $f" 
        #     done
        #     $MG repack /dev/block/by-name/vendor_boot$slot
        #     cat new-boot.img > /dev/block/by-name/vendor_boot$slot
        #     print "- Successfully flashed recovery to slot $slot."
        # elif [ -f vendor_ramdisk/recovery.cpio ] && [ ! -f vendor_ramdisk/ramdisk.cpio ]; then
        #     mv vendor_ramdisk/recovery.cpio vendor_ramdisk/ramdisk.cpio
        #     cp /dev/repack_vboot/fox/vendor_ramdisk/recovery.cpio vendor_ramdisk/recovery.cpio
        #     for f in $($MG cpio vendor_ramdisk/ramdisk.cpio ls | grep -v first_stage_ramdisk | awk '{print $7}') ; do 
        #         $MG cpio vendor_ramdisk/ramdisk.cpio "rm $f" 
        #     done
        #     $MG repack /dev/block/by-name/vendor_boot$slot
        #     cat new-boot.img > /dev/block/by-name/vendor_boot$slot
        #     print "- Successfully flashed recovery to slot $slot."
        # elif [ -f vendor_ramdisk/recovery.cpio ] && [ -f vendor_ramdisk/ramdisk.cpio ]; then
        #     cp -f /dev/repack_vboot/fox/vendor_ramdisk/recovery.cpio vendor_ramdisk/recovery.cpio
        #     for f in $($MG cpio vendor_ramdisk/ramdisk.cpio ls | grep -v first_stage_ramdisk | awk '{print $7}') ; do 
        #         $MG cpio vendor_ramdisk/ramdisk.cpio "rm $f" 
        #     done
        #     $MG repack /dev/block/by-name/vendor_boot$slot
        #     cat new-boot.img > /dev/block/by-name/vendor_boot$slot
        #     print "- Successfully flashed recovery to slot $slot."
        # elif [ ! -f vendor_ramdisk/ramdisk.cpio ] && [ ! -f vendor_ramdisk/recovery.cpio ]; then
        #     print "- Vendor_boot$slot missing ramdisk.cpio & recovery.cpio"
        #     exit 22
        # fi
        
    done
else
    exit 25
fi

exit 0