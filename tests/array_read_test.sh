function function_array_read_test {
PATH="./adat"
source $PATH
echo "array_read test..."
	if [ -f $PATH ];
	then
		echo "  OK"
		echo " ${array[0]}"
		array[0]="failed"
		echo " ${array[0]}"
	else
		echo "  File not found on path: ${array_read[$i]}"
		exit
	fi
}

function_array_read_test
