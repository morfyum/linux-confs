#!/bin/bash

function function_01 {

    echo "Function 01"
}

function function_02 {

    echo "Function 02"
}

called_function=function_01

data_file=`cat ../shared-data/root-bashrc`

echo "DATA FILE:"
echo "=========="
echo "$data_file"
echo ""

echo "$data_file" >> 01.txt
echo " "	>> 01.txt
echo "CALLED: "
$called_function
