#!/bin/bash

source ./functions/rewrite_data.sh
#source ./functions/do-or-not-to-do.sh
#source ./functions/touch-file.sh

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
		if [ -f $1 ] && [[ $2 = "" ]];
		then
			echo "[ OK ] task file exist 1"
			source $taskFile
			function_main_control
		elif [ -f $1 ] && [[ $2 != "" ]];
		then

			case "$2" in
				"")
					# nothing
				;;
				--horde|-h)
					if [ -f "$3" ]; #-n
					then
						#echo "[ OK ] horde file exist"
						source $taskFile
						source $hordeFile

						hordeLen=${#serverList[@]}
						for (( horde=0; horde<$hordeLen; horde++ )); do
						#for horde in ${serverList[@]} do
							echo -e "-------------------------------------------------------------------------"
							echo -e "# REMOTE WORK: $((horde+1)) | HOST: ${serverList[$horde]} | USER: ${remoteUser[$horde]} | HOSTNAME: ${hostName[$horde]}"
							echo -e "-------------------------------------------------------------------------"
							ping -c 1 -W 3 ${serverList[$horde]} 2>&1 > /dev/null
							if [ $? -eq 0 ];
							then
								echo "[ OK ] host available."
								machine=${serverList[$horde]}
								remote_user=${remoteUser[$horde]}
								function_main_control
							else
								echo "[ FAIL ] Host Unreachable... skip"
							fi
						done

					else
						echo "No horde file... exit 3"
						exit 3
					fi
				;;
				--help)
					function_print_help
				;;
				*)
					echo "Wrong argument!"
					exit 4
				;;
			esac

		else
			echo "Argument file not exist... exit 5"
			exit 5
		fi
	;;
esac
