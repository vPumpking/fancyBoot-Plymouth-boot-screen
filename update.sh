#!/bin/bash
sudo mkdir /usr/share/plymouth/themes/fancyboot
sudo cp -rf ./ /usr/share/plymouth/themes/fancyboot
sudo update-alternatives --quiet --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/fancyboot/fancyboot.plymouth 100
sudo update-alternatives --quiet --set default.plymouth /usr/share/plymouth/themes/fancyboot/fancyboot.plymouth
sudo update-initramfs -u
echo Done!
echo Testing for 10s...
sudo plymouthd
sudo plymouth --show-splash
sleep 10
sudo plymouth quit
echo Everything seems to work!
sleep 1