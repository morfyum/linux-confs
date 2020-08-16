function function_array_read_test {
PATH="../shared-confs/global-bashrc"
echo "array_read test..."
	if [ -f $PATH ];
	then
		echo "  OK"
	else
		echo "  File not found on path: ${array_read[$i]}"
		exit
	fi
}

function_array_read_test
