#!/bin/bash

taskFile=$1
hordeFile=$3

function function_print_help {
		echo "=============="
		echo "HOW TO USE IT:"
		echo "=============="
		echo "EXAMPLES"
		echo "  Execute definitions on 1 local or remote computer"
		echo "    parameters.sh ./file_with_parameters"
		echo ""
		echo "  Execute definitions on 2 or more remote computer"
		echo "    parameters.sh ./file_with_parameters --horde ./horde_file"
		echo ""
		echo "SWITCHES:"
		echo "  --help"
		echo "    List this menu"
		echo "  --horde, -h "
		echo "    If you allow exectution 2 or more remote machine, you need to create"
		echo "    a description file about of your machines"
}

case "$1" in
	"")
		echo "Type --help for more arguments"
		exit 1
	;;
	--help)
		function_print_help
	;;
	--*)
		echo "No argument exist, show help: --help"
	;;
	*)
		#echo "OK"
		if [ -f $1 ];
		then
			echo "[ OK ] task file exist"
			source $taskFile
			# TODO check array file
		else
			echo "file not exist"
			exit 2
		fi
	;;
esac

case "$2" in
	"")
		# nothing
	;;
	--horde|-h)
		echo "Horde"
		if [ -f "$3" ]; #-n
		then
			echo "[ OK ] horde file exist"
			source $hordeFile
		else
			echo "No horde file... exit"
			exit 3
		fi
	;;
	*)
		echo "Hmmm? exit.."
		exit 4
	;;
esac
