#!/bin/bash
safe_removal() {
    echo Uninstalling the fancyboot plymouth theme...
    sudo update-alternatives --quiet --remove default.plymouth /usr/share/plymouth/themes/fancyboot/fancyboot.plymouth
    sudo rm -rf /usr/share/plymouth/themes/fancyboot
    sudo update-alternatives --quiet --auto default.plymouth
    sudo update-initramfs -u
    echo Done!
    echo Testing...
    sudo plymouthd
    sudo plymouth --show-splash
    sleep 10
    sudo plymouth quit
    echo Done. Report to author if a problem happens.
    sleep 1
}
complete_removal() {
    echo "COMPLETE REMOVAL"
    if test -f "/usr/share/initramfs-tools/scripts/functions.backup"; then
        echo Backup file exists.
    else
        echo
        echo ERROR
        echo "File '/usr/share/initramfs-tools/scripts/functions.backup' does not exist. Emergency option is: Safe removal"
        echo Aborting Complete removal and starting Safe removal...
        echo SAFE REMOVAL
        safe_removal
    fi
    read -p "Do you want to continue ? [y/N] "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo Replacing initramfs functions by backup...
        sudo cp /usr/share/initramfs-tools/scripts/functions.backup /usr/share/initramfs-tools/scripts/functions
        echo Done!
        safe_removal
    else
        echo Exiting... \(1s left\)
        sleep 1
        exit
    fi
}
echo Please enter your sudo password if you are prompted to do so.
echo
echo
echo WARNING
echo There are __two__ existing uninstalling modes for FancyBoot:
echo "    1 - Safe removal : FancyBoot is deleted and the default theme is set back. Most recommanded option."
echo "    2 - Complete removal : FancyBoot is deleted, the default theme is set back and the initramfs functions file is set back from backup. Read warning below.*"
echo
echo "*Warning: Complete removal can cause serious problems in the filesystem if the '/usr/share/initramfs-tools/scripts/functions.backup' doesn't exist. Those problems can be fatal to your computer."
echo
read -p "Type the number of the chosen option. Default option is 1. Type 'q' to quit. "
echo
if [[ $REPLY =~ ^[1]$ ]]; then
    echo "SAFE REMOVAL"
    safe_removal
else
    if [[ $REPLY =~ ^[2]$ ]]; then
        complete_removal
    else
        if [[ $REPLY =~ ^[q]$ ]]; then
            echo "Exiting..."
            sleep 1 && exit  
        fi
    fi
fi