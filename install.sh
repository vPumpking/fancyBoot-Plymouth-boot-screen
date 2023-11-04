#!/bin/bash
whereto='/_log_msg()/='
fromfile="/usr/share/initramfs-tools/scripts/functions"
tmpfile="./tmp"
echo Please enter your sudo password if you are prompted to do so.
echo
echo
echo WARNING
echo The FancyBoot plymouth theme requires a few script lines in ${fromfile} to display the bottom boot log.
echo "These 3 lines are followed by a '#FANCYBOOT' command. If you are encountering problems with the boot log,"
echo delete carefuly these lines __only__. A backup of ${fromfile} will be made at ${fromfile}.backup, use it to restore
echo "the original file in case of damage. FancyBoot and its author aren't responsible in any case for software/"
echo hardware damage or malfunction.
echo
echo
read -p "Do you want to continue ? (read above lines before) [Y/n] "
if [[ $REPLY =~ ^[Nn]$ ]]
then
    echo
    echo Exiting... \(1s left\)
    sleep 1
    exit
fi
if test -f "/usr/share/plymouth/themes/fancyboot/installed"; then
    echo Theme already installed. To update it after a modification, please use update.sh.
    sleep 1
    exit
else
    sudo touch "/usr/share/plymouth/themes/fancyboot/installed"
fi

echo Installing the fancyboot plymouth theme...
sed -n $whereto $fromfile >> $tmpfile
tmpval=$(head $tmpfile)
rm $tmpfile
line=$(($tmpval+2))
echo Backup $fromfile to ${fromfile}.backup
sudo cp $fromfile ${fromfile}.backup
echo Done!
echo Add plymouth update at line $line in file $fromfile
update=" 	if [ -x /bin/plymouth ]; then #FANCYBOOT - Remove this if block in case of problems in boot log"
printf '%s\n' H ${line}i "$update" . wq | sudo ed -s $fromfile
update=' 		/bin/plymouth update --status="$@" #FANCYBOOT'
line=$(($line+1))
printf '%s\n' H ${line}i "$update" . wq | sudo ed -s $fromfile
update=" 	fi #FANCYBOOT"
line=$(($line+1))
printf '%s\n' H ${line}i "$update" . wq | sudo ed -s $fromfile
echo Done!
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
