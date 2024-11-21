#!/bin/bash



fox_dir=$(pwd)
inject_self_repacker(){
    file="$fox_dir/bootable/recovery/twrpRepacker.cpp"
    # Проверка, существует ли файл
    if [ ! -f "$file" ]; then
        echo "Файл не найден: $file"
        exit 1
    fi
    if grep -q "bool twrpRepacker::Flash_Current_Twrp()" "$file"; then
        echo "Функция twrpRepacker::Flash_Current_Twrp() найдена в файле"
        if ! grep -q "if (TWFunc::Path_Exists(\"/system/bin/reflash_twrp.sh\"))" "$file"; then
            echo "Вставляем код в функцию twrpRepacker::Flash_Current_Twrp()"
            sed -i '/bool twrpRepacker::Flash_Current_Twrp() {/a \
    if (TWFunc::Path_Exists("/system/bin/reflash_twrp.sh")) {\
        gui_print("- Starting suctom reflash recovery script\\n");\
        int pipe_fd[2];\
        if (pipe(pipe_fd) == -1) {\
            LOGERR("Failed to create pipe");\
            return false;\
        }\
        if (TWFunc::Path_Exists("/system/bin/reflash_twrp.sh")) {\
            std::string command = "/system/bin/reflash_twrp.sh " + std::to_string(pipe_fd[1]) + " " + std::to_string(pipe_fd[0]);\
            gui_print("- Reflashing recovery\\n");\
            int result = TWFunc::Exec_Cmd(command);\
            if (result != 0) {\
                LOGERR("Script reflash_twrp.sh failed with error code: %d", result);\
                gui_print_color("error", "Script reflash_twrp.sh failed with error code: %d\\n", result);\
                return false;\
            }\
            gui_print_color("green", "- Successfully flashed recovery to both slots\\n");\
            close(pipe_fd[0]);\
            close(pipe_fd[1]);\
            return true;\
        }\
        return false;\
    }' "$file"
            echo "Код успешно вставлен."
        else
            echo "Код уже присутствует в функции twrpRepacker::Flash_Current_Twrp()."
        fi
    else
        echo "Функция twrpRepacker::Flash_Current_Twrp() не найдена в файле."
        exit 1
    fi
}


inject_self_repacker 

sed -i 's/ || defined(RECOVERY_ABGR)//g' $fox_dir/bootable/recovery/minuitwrp/graphics.cpp
sed -i 's/ || defined(RECOVERY_ABGR)//g' $fox_dir//bootable/recovery/minuitwrp/resources.cpp

# export LC_ALL="C.UTF-8"
export ALLOW_MISSING_DEPENDENCIES=true

#OFR build settings & info
export FOX_VERSION="R12.1"
export FOX_VANILLA_BUILD=1
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export TARGET_DEVICE_ALT="Pixel8Pro, Pixel8, GooglePixel8Pro, GooglePixel8, husky, Husky, shiba, Shiba, shusky, Shusky"
export FOX_TARGET_DEVICES="Pixel8Pro, Pixel8, GooglePixel8Pro, GooglePixel8, husky, Husky, shiba, Shiba, shusky, Shusky"
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
export FOX_DELETE_INITD_ADDON=1
# export FOX_SETTINGS_ROOT_DIRECTORY="/persist/OFRP"
export FOX_USE_SPECIFIC_MAGISK_ZIP=$fox_dir/device/google/shusky/included-stuff/Magisk/Magisk-v28.0.zip

#OFR binary files
export FOX_REPLACE_BUSYBOX_PS=1
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_REPLACE_TOOLBOX_GETPROP=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_SED_BINARY=1
export FOX_USE_NANO_EDITOR=0

#OTA
export FOX_VIRTUAL_AB_DEVICE=1
export FOX_DELETE_AROMAFM=1
export FOX_ENABLE_APP_MANAGER=1
export TW_THEME='portrait_hdpi'


lunch twrp_shusky-eng
echo "FUCK"
export | grep FOX
export | grep OF_
export | grep TARGET_
export | grep TW_