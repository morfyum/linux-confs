#!/bin/bash
# Exit when fails
set -o errexit
# Exit when use Undeclared variable
set -o nounset
# Set debuggin mod
#set -x

echo "========== TASK 001 =========="
echo "Do you want to enable rpmfusion-free repository for Fedora $(rpm -E %fedora)? (Recommened)"
echo "=============================="
echo "Recommended to add this repository, because contain useful tools."
read -n1 -p "[Y/n] " add_rpmfusion_free
case $add_rpmfusion_free in
	[yY])
		echo -e "\n  Add rpmfusion-free..."
		sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	;;
	*)
		echo -e "\n  SKIP!\n"
	;;
esac

echo "========== TASK 002 =========="
echo "Do you want to enable rpmfusion-nonfree repository for Fedora $(rpm -E %fedora)? (Optional)"
echo "=============================="
echo "Needed only special sitioations. Not recommended, just optional."
read -n1 -p "[Y/n] " add_rpmfusion_nonfree
case $add_rpmfusion_nonfree in
	[yY])
		echo -e "\n  Add rpmfusion-nonfree..."
		sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	;;
	*)
		echo -e "\n  SKIP!\n"
	;;
esac

echo "========== TASK 003 =========="
echo "Do you want to enable Flathub repository?"
echo "=============================="
echo "Recommended to add Flathub repo. I think third party packages betters as containered format on fedora. For Example: Blender"
read -n1 -p "[Y/n] " add_flathub
case $add_flathub in
	[yY])
		echo -e "\n  Add rpmfusion-nonfree..."
		flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	;;
	*)
		echo -e "\n  SKIP!\n"
	;;
esac


echo "========== TASK 004 =========="
echo "Do you want to install folliwing packages to the system?"
echo "=============================="
echo "Following packages:
  - vim >> Commandline text-editor (need setup)
  - tilix >> Best terminal emulator
  - htop >> system resource monitoring
  - at >> Manual time scheduler (marsleep)
  - smartmontools >> S.M.A.R.T
  - testdisk >> Data recovery tool
  - exfat-utils >> For using exfat filesystem on usb storages
"

read -n1 -p "[Y/n] " install_recommendeds_004
case $install_recommendeds_004 in
	[yY])
		echo -e "\n  Install recommened packages..."
		sudo dnf install vim tilix htop at smartmontools testdisk exfat-utils
	;;
	*)
		echo -e "\n  SKIP!\n"
	;;
esac

echo "========== TASK 005 =========="
echo "Setting up global bashrc (/etc/bashrc)"
echo "=============================="

readonly global_bashrc_path='/etc/bashrc'
readonly global_bashrc_read='./shared/global-bashrc'
readonly global_bashrc_start='# 000_GLOBAL_BASHRC_ETC_BASHRC'
readonly global_bashrc_end='# 000_GLOBAL_BASHRC_ETC_BASHRC_END'

#echo "Following aliases:"
#cat $global_bashrc_read
#echo ""

echo "CASE TEST"
case `grep -Fx "$global_bashrc_start" "$global_bashrc_path" >/dev/null; echo $?` in
	0)
		echo "  Lines exist"
		echo "  Clearing rows..."
		sudo sed -i "/$global_bashrc_start/,/$global_bashrc_end/d" $global_bashrc_path
		echo "  ERROR: $?"
		
		echo -e "  MODIFY LINES\n  FROM: [ $global_bashrc_read ]\n  TO: [ $global_bashrc_path ]\n"
		sudo cat $global_bashrc_read >> $global_bashrc_path
	;;
	1)
		echo "  Code not found or config is wrong"
		echo -e "ATTACH NEW LINES\n  FROM: [ $global_bashrc_read ]\n  TO: [ $global_bashrc_path ]\n"
		cat $global_bashrc_read >> $global_bashrc_path
	;;
	*)
		echo "  Something went wrong!"
	;;
esac

echo "========== TASK 006 =========="
echo "Do you want to set following aliases to root user? (/root/.bashrc)"
echo "=============================="

readonly root_bashrc_path='/root/.bashrc'
readonly root_bashrc_read='./shared/root-bashrc'
readonly root_bashrc_start='# 000_ROOT_BASHRC_ROOT_BASHRC'
readonly root_bashrc_end='# 000_ROOT_BASHRC_ROOT_BASHRC_END'

#echo "Following aliases:"
#cat $root_bashrc_read
#echo ""

echo "CASE TEST"
case `grep -Fx "$root_bashrc_start" "$root_bashrc_path" >/dev/null; echo $?` in
	0)
		echo "  Lines exist"
		echo "  Clearing rows..."
		sed -i "/$root_bashrc_start/,/$root_bashrc_end/d" $root_bashrc_path
		echo "  ERROR: $?"
		
		echo -e "  MODIFY LINES\n  FROM: [ $root_bashrc_read ]\n  TO: [ $root_bashrc_path ]\n"
		cat $root_bashrc_read >> $root_bashrc_path
	;;
	1)
		echo "  Code not found or config is wrong"
		echo -e "ATTACH NEW LINES\n  FROM: [ $root_bashrc_read ]\n  TO: [ $root_bashrc_path ]\n"
		cat $root_bashrc_read >> $root_bashrc_path
	;;
	*)
		echo "  Something went wrong!"
	;;
esac

echo "========== TASK 007 =========="
echo "Setting up vim (/etc/vimrc)"
echo "=============================="

readonly etc_vimrc_path='/etc/vimrc'
readonly etc_vimrc_read='./shared/etc-vimrc'
readonly etc_vimrc_start='" 000_VIMRC_CONF_END'
readonly etc_vimrc_end='" 000_VIMRC_CONF_END'

#echo "Following aliases:"
#cat $etc_vimrc_read
#echo ""

echo "CASE TEST"
case `grep -Fx "$etc_vimrc_start" "$etc_vimrc_path" >/dev/null; echo $?` in
	0)
		echo "  Lines exist"
		echo "  Clearing rows..."
		sed -i "/$etc_vimrc_start/,/$etc_vimrc_end/d" $etc_vimrc_path
		echo "  ERROR: $?"
		
		echo -e "  MODIFY LINES\n  FROM: [ $etc_vimrc_read ]\n  TO: [ $etc_vimrc_path ]\n"
		cat $etc_vimrc_read >> $etc_vimrc_path
	;;
	1)
		echo "  Code not found or config is wrong"
		echo -e "ATTACH NEW LINES\n  FROM: [ $etc_vimrc_read ]\n  TO: [ $etc_vimrc_path ]\n"
		cat $etc_vimrc_read >> $etc_vimrc_path
	;;
	*)
		echo "  Something went wrong!"
	;;
esac
