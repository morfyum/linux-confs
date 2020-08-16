#!/bin/bash
# linux-confs welcome scirpt with examples
# Exit when fails
set -o errexit
# Exit when use Undeclared variable
set -o nounset
# Set debuggin mod
#set -x

########### EXAMPLE 01 ###########
echo "========== TASK 001 =========="
echo "Yes or No Example todo something?"
echo "=============================="

read -n1 -p "[Y/n] " welcome_test
case $welcome_test in
	[yY])
		echo -e "\n  It's Y - Do it!"
		echo -e "  Do something...\n"
	;;
	*)
		echo -e "\n  SKIP: do nothing \n"
	;;
esac
#################################


##### EXAMPLE 02 ################
echo "========== TASK 002 =========="
echo "Write shared/welcome to /opt"
echo "=============================="

# Path of file what you want to write
readonly welcome_file_path='/opt/welcome-linux-confs.txt'
#Read configs from this file
readonly welcome_000_read='./shared/000-welcome-linux-confs'
# Readed file first and last lines
readonly welcome_000_start='# 000_WELCOME_OPT'
readonly welcome_000_end='# 000_WELCOME_OPT_END'

echo "CASE TEST"
case `grep -Fx "$welcome_000_start" "$welcome_file_path" >/dev/null; echo $?` in
	0)
		echo "  Lines exist"
		echo "  Clearing rows..."
		# -i nélkül nem töröl, csak teszt outputot ad vissza.
		sed -i "/$welcome_000_start/,/$welcome_000_end/d" $welcome_file_path
		echo "  ERROR: $?"
		
		echo -e "  MODIFY LINES\n  FROM: [ $welcome_000_read ]\n  TO: [ $welcome_file_path ]\n"
		cat $welcome_000_read >> $welcome_file_path
	;;
	1)
		echo "  Code not found or config is wrong"
		echo -e "ATTACH NEW LINES\n  FROM: [ $welcome_000_read ]\n  TO: [ $welcome_file_path ]\n"
		cat $welcome_000_read >> $welcome_file_path
	;;
	*)
		echo "  Something went wrong"
	;;
esac

################################
