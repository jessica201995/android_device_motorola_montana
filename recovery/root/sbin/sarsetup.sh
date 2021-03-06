mkdir /s
mount -o ro /dev/block/bootdevice/by-name/system /s
build_prop_path="/s/system/build.prop"
if [ -f "${build_prop_path}" ]; then
    system_version=$(grep -i 'ro.build.version.release' "${build_prop_path}"  | cut -f2 -d'=')
    if [ "${system_version}" == "9" ]; then
        mount -o bind /etc/twrp_sar.fstab /etc/twrp.fstab
        setprop ro.build.system_root_image true
    else
        setprop ro.build.system_root_image false
    fi
else
    setprop ro.build.system_root_image false
fi
umount /s
rm -rf /s
