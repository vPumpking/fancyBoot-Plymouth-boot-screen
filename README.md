# FancyBoot Plymouth theme
### About FancyBoot
FancyBoot is a beautiful Plymouth boot screen for Ubuntu, featuring a progress bar, a live boot log, and a colorful animated background.

### How to use
#### Download
Use the official page's download button or open a terminal window and run the following command (ensure that `git` command is installed first):
```bash
git clone https://github.com/vPumpking/fancyBoot-Plymouth-boot-screen.git
```
#### Install
Open a terminal in the theme folder (called `fancyBoot`) and type the following commands:
```bash
chmod +x install.sh
```
Then:
```bash
./install.sh
```
This command will ask you some important questions. You will have to answer __carefully__. You also will have to enter your password at least one time when asked.
The program will then show the plymouth for 10s and quit.
#### Uninstall
Open a terminal in the theme folder (called `fancyBoot`) and type the following commands:
```bash
chmod +x uninstall.sh
```
Then:
```bash
./uninstall.sh
```
The program will ask you to choose between two options. Once again, answer carefully. If you don't know what to choose, use option `1`.
The program will remove the theme and set back the default one, and do a 10s test.
#### Update
If you want to edit this theme and then update it, edit the copy in the downloaded folder, then open a terminal in this same folder (called `fancyBoot`) and type the following commands:
```bash
chmod +x update.sh
```
Then:
```bash
./update.sh
```
This will update the theme and show you a 10s test.
#### Test
To test the Plymouth theme, open a terminal in the theme folder (called `fancyBoot`) and type the following commands:
```bash
chmod +x test.sh
```
Then:
```bash
./test.sh
```
### Warning
Do __never__:
* Delete the `/usr/share/plymouth/themes/fancyboot/installed` file.
* Delete the `/usr/share/initramfs-tools/scripts/functions.backup` file.

---

You can __open__ an issue on https://github.com/vPumpking/fancyBoot-Plymouth-boot-screen if you have any question.
