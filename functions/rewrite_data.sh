#!/bin/bash
# Exit when fails
#set -o errexit
# Exit when use Undeclared variable
#set -o nounset
# Set debuggin mod
#set -x

# array_execute parameters: yes = Execute! | no = No execution | test or testing = Write output without execution
# DATA.SH ARRAYS HERE BEFORE CODE IS RESTRUCTURED! 

# SUB FUNCTION
function function_error_test {
	if [ $? -eq 0 ];
	then
		echo "OK"
	else
		echo "FAIL"
	fi
}

# SUB FUNCTION
# REWRITE_DATA FUNCTION 
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
				echo "    [ FAILED ] array_end: ${array_end[$i]}"
				echo "    Skip task..."
			;;
			*)
				echo "    [ FAILED ] Something went wrong!"
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

# SUB FUNCTION
function function_array_read_test {
	if [ -f ${array_read[$i]} ];
	then
		echo "    [ OK ] array_read"
	else
		echo "    [ FAILED ] File not found on path: ${array_read[$i]}"
		exit
	fi
}

function function_array_path_test {
	if [ -f ${array_path[$i]} ];
	then
		echo "    [ OK ] array_path"
	else
		echo "    [ FAILED ] File to operate, not available: ${array_path[$i]}"
		#exit
	fi
}

function function_array_start_test {
	grep -wq "${array_start[$i]}" ${array_read[$i]}
	if [ $? -eq 0 ];
	then
		echo "    [ OK ] array_start"
	else
		echo "    [ FAILED ] array_start not exist: ${array_start[$i]}"
	fi
}

function function_array_end_test {
	grep -wq "${array_end[$i]}" ${array_read[$i]}
	if [ $? -eq 0 ];
	then
		echo "    [ OK ] array_end"
	else
		echo "    [ FAILED ] array_end not exist: ${array_end[$i]}"
	fi
}

# MAIN FUNCTION
function function_rewrite_data_main {

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
		
		if [ ${array_function[$i]} = "rewrite_data" ];
		then
			echo "  CALL: Rewrite-data"
		elif [ ${array_function[$i]} = "user-question" ];
		then
			echo "  CALL: question"
		elif [ ${array_function[$i]} = "touch-file" ];
		then
			echo "  CALL: touch-file"
		else
			echo "  Undefined function... exit"
		fi
		
		if [ $machine = "local" ];
		then
			echo "  TESTS"
			function_array_read_test
			function_array_path_test
			function_array_start_test
			function_array_end_test

			echo "  EXECUTE: ${array_execute[$i]}"
			echo "  MACHINE: $machine"
			echo "  PATH_FL: ${array_path[$i]}"
			echo "  READ_FL: ${array_read[$i]}"
			echo "  FILE_ST: ${array_start[$i]}"
			echo "  FILE_EN: ${array_end[$i]}"
			#function_case_test
		else
			echo "  Remote execute: TODO" # TODO!
			echo "  TESTS" # REMOTE TESTS TODO!
			function_array_read_test
			function_array_path_test
			function_array_start_test
			function_array_end_test
			
			#ping -c 1 -W 3 $machine 2>&1 > /dev/null
			if [ $? -eq 0 ];
			then
				echo "  [ OK ] ping server"
			else
				echo "  [ FAIL ] Unreachable... SKIP"
			fi
			
			echo "  EXECUTE: ${array_execute[$i]}"
			echo "  MACHINE: $machine"
			echo "  REMOTE USER: $remote_user"
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
		echo "  Data only printed"
		echo "  EXECUTE: ${array_execute[$i]}"
		echo "  MACHINE: $machine"
		echo "  PATH_FL: ${array_path[$i]}"
		echo "  READ_FL: ${array_read[$i]}"
		echo "  FILE_ST: ${array_start[$i]}"
		echo "  FILE_EN: ${array_end[$i]}"
	else
		echo "  Not ready to execution"
	fi
	echo ""
done

}
