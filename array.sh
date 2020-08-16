#!/bin/bash
# Exit when fails
set -o errexit
# Exit when use Undeclared variable
set -o nounset
# Set debuggin mod
#set -x

# array_execute parameters: yes = Execute! | no = No execution | test or testing = Write output without execution
array_execute=(
	'yes'		# 01
	'yes'		# 02
	'yes'		# 03
	'test'		# 04
	'no'		# 05
)
array_machine=(
	'local'
	'local'
	'local'
	'local'
	'192.168.1.200'
)
array_remote_user=(
	''
	''
	''
	'username'
	'username'
	
)
array_path=(
	'/etc/bashrc'
	'/root/.bashrc'
	'/etc/vimrc'
	'/ddd/'
	'/eee/'
)
array_read=(
	'./shared/global-bashrc'
	'./shared/root-bashrc'
	'./shared/etc-vimrc'
	'ddd_read'
	'eee_read'
)
array_start=(
	'# 000_GLOBAL_BASHRC_ETC_BASHRC'
	'# 000_ROOT_BASHRC_ROOT_BASHRC'
	'" 000_VIMRC_CONF'
	'ddd_start'
	'eee_start'
)
array_end=(
	'# 000_GLOBAL_BASHRC_ETC_BASHRC_END'
	'# 000_ROOT_BASHRC_ROOT_BASHRC_END'
	'" 000_VIMRC_CONF_END'
	'ddd_end'
	'eee_end'
)

function function_error_test {
	if [ $? -eq 0 ];
	then
		echo "OK"
	else
		echo "FAIL"
	fi
}

function function_case_test {

	echo "  FUNCTION CASE TEST..."
	case `grep -Fx "${array_start[$i]}" "${array_path[$i]}" >/dev/null; echo $?` in
		0)
			echo "    array_start: $(function_error_test)"
			
			case `grep -Fx "${array_end[$i]}" "${array_path[$i]}" >/dev/null; echo $?` in
			0)
				echo "    array_end: $(function_error_test)"
				echo "    Lines exist!"
				echo "    Clearing rows..."
				sed -i "/${array_start[$i]}/,/${array_end[$i]}/d" ${array_path[$i]}
				echo "      $(function_error_test)"
				
				#echo -e "    MODIFY LINES\n    FROM: [ ${array_read[$i]} ]\n    TO: [ ${array_path[$i]} ]"
				echo "    Modify lines..."
				cat ${array_read[$i]} >> ${array_path[$i]}
				echo "      $(function_error_test)"
			;;
			1)
				echo "    array_end FAILED: ${array_end[$i]}"
				echo "    Skip task..."
			;;
			*)
				echo "    Something went wrong!"
				echo "    Skip task..."
			;;
			esac
					
		;;
		1)
			echo "    Add new lines... (or array_start not matched with file in 'shared' folder )"
			#echo -e "    ADD NEW LINES\n    FROM: [ ${array_read[$i]} ]\n    TO: [ ${array_path[$i]} ]"
			cat ${array_read[$i]} >> ${array_path[$i]}
			echo "      $(function_error_test)"
		;;
		*)
			echo "    Something went wrong!"
			echo "    Task omitted!"
		;;
	esac

}


## get length of $array
length=${#array_execute[@]}
 
## Use loop 
for (( i=0; i<$length; i++ )); do
echo "==================="
echo -e "TASK: $((i+1))"
echo "==================="

	if [ ${array_execute[$i]} = "yes" ];
	then
		echo "  Ready to Execute"
		
		if [ ${array_machine[$i]} = "local" ];
		then
			echo "  EXECUTE: ${array_execute[$i]}"
			echo "  MACHINE: ${array_machine[$i]}"
			echo "  PATH_FL: ${array_path[$i]}"
			echo "  READ_FL: ${array_read[$i]}"
			echo "  FILE_ST: ${array_start[$i]}"
			echo "  FILE_EN: ${array_end[$i]}"
			function_case_test
		else
			echo "  Remote execute: TODO"
			echo "  EXECUTE: ${array_execute[$i]}"
			echo "  MACHINE: ${array_machine[$i]}"
			echo "  PATH_FL: ${array_path[$i]}"
			echo "  READ_FL: ${array_read[$i]}"
			echo "  FILE_ST: ${array_start[$i]}"
			echo "  FILE_EN: ${array_end[$i]}"
			# TODO
		fi
		sleep 1.5
	elif [ ${array_execute[$i]} = "test" ] || [ ${array_execute[$i]} = "testing" ];
	then
		echo "  !!! TEST MODE !!!"
		echo "  EXECUTE: ${array_execute[$i]}"
		echo "  MACHINE: ${array_machine[$i]}"
		echo "  PATH_FL: ${array_path[$i]}"
		echo "  READ_FL: ${array_read[$i]}"
		echo "  FILE_ST: ${array_start[$i]}"
		echo "  FILE_EN: ${array_end[$i]}"
	else
		echo "  Not ready to execute"
	fi
	echo ""
done
