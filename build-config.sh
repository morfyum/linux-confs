#!/bin/bash

### TODO ###
# - Test file exists > OK: 1/1
# - Test file syntax > OK: 1/6
# - Fill arrays > OK: 1/1
# - Output to file > OK: 1/1
# - Test Output file > TODO
############

font_color_red="\e[1;31m"
font_color_green="\e[1;32m"
font_color_reset="\e[0;0m"
result_ok="${font_color_green}OK${font_color_reset}"
result_fail="${font_color_red}FAIL${font_color_reset}"

string_tail_array=" )"
# Function
string_head_function="array_function=("
string_body_function=""
string_array_function=""
array_function=()
# Execute
string_head_execute="array_execute=("
string_body_execute=""
string_array_execute=""
array_execute=()
# Path
string_head_path="array_path=("
string_body_path=""
string_array_path=""
array_path=()
# Read
string_head_read="array_read=("
string_body_read=""
string_array_read=""
array_read=()
# Start
string_head_start="array_start=("
string_body_start=""
string_array_start=""
array_start=()
# End
string_head_end="array_end=("
string_body_end=""
string_array_end=""
array_end=()

function test_path() {
    if [ -f "$FARG" ]; then
        echo -e "[ $result_ok ] path exists: $FARG "
    else
        if [ "${FARG}" = "--outfile" ]; then
            echo "Skip: ${FARG}"
            #ARG=$((ARG+1))

            filename=$((ARG+1))
            ARG=$((ARG+1))

            if [ -f ./${!filename} ]; then
                echo -e "[ $result_fail ] [ ${!filename} ] name is exists! Please, choose other name. Exit..."
                exit
            else
                ARG=$((ARG+1))
                outfile_filename=${!filename}
                echo " Outfile: ${!filename}"
            fi


        else
            # counter+2
            echo -e "[ $result_fail ] No-such-file: [ $FARG ] [ ${!ARG}th ] Parameter. Exit... "
            #exit
        fi
    fi
}


function read_var_syntax () {
    if [ "$function"  = "rewrite_data" ]; then

        echo -e "[ $result_ok ] ( ${ARG}th ) Function: ${font_color_green}ReWrite_Data${font_color_reset}"
        string_body_function="${string_body_function} '$function'"
        string_body_execute="${string_body_execute} '$execute'"
        string_body_path="${string_body_path} '$path'"
        string_body_read="${string_body_read} '$read'"
        string_body_start="${string_body_start} '$start'"
        string_body_end="${string_body_end} '$end'"

        # Build array paraneter
        array_function[${#array_function[@]}]="$function"
        array_execute[${#array_execute[@]}]="$execute"
        array_path[${#array_path[@]}]="$path"
        array_read[${#array_read[@]}]="$read"
        array_start[${#array_start[@]}]="$start"
        array_end[${#array_end[@]}]="$end"
        # TEST
        echo "  add to array func: [ ${array_function[$counter]} ]"
        echo "  add to array exec: [ ${array_execute[$counter]} ]"
        echo "  add to array path: [ ${array_path[$counter]} ]"
        echo "  add to array read: [ ${array_read[$counter]} ]"
        echo "  add to array strt: [ ${array_start[$counter]} ]"
        echo -e "  add to array end:  [ ${array_end[$counter]} ]\n"


    elif [ "$function"  = "put_file" ]; then

        echo -e "[ $result_ok ] [ ${counter}th ] Function: ${font_color_green}Put_File${font_color_reset}"

    elif [ "$function"  = "do_something" ]; then

        echo -e "[ $result_ok ] [ ${counter}th ] Function: ${font_color_green}Do_Something${font_color_reset}"

    else

        echo -e "[ $result_fail ] [ ${counter}th ] Unknown function: [ $function ] Please check this file: [ $ARG ], Line: [ execute ]"
        exit

    fi
}


# Read arguments what we add to the result string_array # !!! NOT Counting input values!
counter=0

# ${!ARG} is count Input values
for (( ARG=1; ARG<=$#; ARG++ )); do

    #FARG=${!ARG}

    if [ "${!ARG}" = "--outfile" ]; then
        #echo "FOUND --outfile!"

        #echo "Found: --outfile"
        filename=$((ARG+1))
        FARG=$((ARG+1))
        ARG=$((ARG+1))

        # TEST FOLLOWING VALUE
        #echo "TEST Filename: ${!filename}"
        if [ -f ./${!filename} ]; then
            echo -e "[ $result_fail ] [ ${!ARG} ] name is exists! Please, choose other name. Exit..."
            exit
        elif [ "${!filename}" = "" ]; then
            echo -e "[ $result_fail ] Missing argument: Filename after --outfile"
            exit
        else
            #echo "[ OK ] Name is not exist"
            outfile_filename=${!ARG}
            #echo " Outfile: ${!ARG}"
            #echo " Out Value: ${ARG}"
            #echo "--"
            #echo " Outfile: ${!ARG}"
            #echo " Out Value: ${ARG}"
            #echo "Counter: $counter"

        fi

    else
        #echo "Arg: ${!ARG}"

        # TEST file exist
        #test_path ## FUNCTION DOESNT WORK AS CALLED BEACAUS FOR CYCLE SHIT THIS
        # SO PUT FULL FUNCTION BELOW

        # Test path
        if [ -f "${!ARG}" ]; then
            echo -e "[ $result_ok ] path exists: ${!ARG} "
        else
            # If path not exist, test --output switch
            if [ "${!ARG}" = "--outfile" ]; then
                # When this is --outfile, skip this, filemane = ARG and ARG = ARG+1
                #echo "[ Skip ] ${!ARG}, Increase: $counter, ${!ARG}, "
                filename=$((ARG+1))
                #ARG=$((ARG+1))

                # Test the --outfile parameter, the nem if outfile.
                # If name is exsist, you not add filename, an existing name is a config-file
                if [ -f ./${!filename} ]; then
                    echo -e "[ $result_fail ] [ ${!filename} ] name is exists! Please, choose other name. Exit..."
                    exit
                else
                    # If everything is OK, skip, and continue
                    outfile_filename=${!filename}
                    #echo "[ SKIP ] Outfile name: ${!filename}"
                fi

                # Skip --outfile, and now skip filename
                #ARG=$((ARG+1))
                #counter=$((counter+1))

                # test the ARG+2 path. if ok, continue
                #if [ -f "./${!filename}" ]; then
                #    echo -e "[ $result_ok ] path exists: ${!ARG} "
                #else
                #    echo -e "[ $result_fail ] No such file2: [ ${!ARG} ] [ ${counter}th ] Parameter. Exit... "
                #    exit
                #fi

            else
                echo -e "[ $result_fail ] No such file 1: [ ${!ARG} ] [ ${ARG}th ] Parameter. Exit... "
                exit
            fi
        fi

        # Get variables from file ($ARG)
        #echo "Source check: ${!ARG}"

        if [ "${!ARG}" != "" ]; then
            source ${!ARG}
            # 1. Check Syntack, and get parameters from $ARG file
            # 2. Build array parameters
            read_var_syntax
        #else
        #    echo "No more argument. Finis!"
        fi

        counter=$((counter+1))
    fi

done

if [ "$outfile_filename" != "" ]; then
    echo -e " Outfile name: >>> $outfile_filename <<<"
else
    echo -e "[ $result_fail ] No Outfile! Please use the following argument: --outfile <filename>"
    exit
fi

# Build array string
echo -e "\nBuilt array string..."
string_array_function=$string_head_function$string_body_function$string_tail_array
string_array_execute=$string_head_execute$string_body_execute$string_tail_array
string_array_path=$string_head_path$string_body_path$string_tail_array
string_array_read=$string_head_read$string_body_read$string_tail_array
string_array_start=$string_head_start$string_body_start$string_tail_array
string_array_end=$string_head_end$string_body_end$string_tail_array

# Show Results
echo -e "[ Build String: array_func ] : $string_array_function"
echo -e "[ Build String: array_exec ] : $string_array_execute"
echo -e "[ Build String: array_path ] : $string_array_path"
echo -e "[ Build String: array_read ] : $string_array_read"
echo -e "[ Build String: array_strt ] : $string_array_start"
echo -e "[ Build String: array_end  ] : $string_array_end"

# Write Array to file
echo $string_array_function > ./test_build_file
echo $string_array_execute >> ./test_build_file
echo $string_array_path >> ./test_build_file
echo $string_array_read >> ./test_build_file
echo $string_array_start >> ./test_build_file
echo $string_array_end >> ./test_build_file

echo -e "\nUnit test Results:"
if [ ${#array_function[@]} -eq ${#array_execute[@]} ]; then function_test_var="$result_ok"; else function_test_var="$result_fail"; fi
if [ ${#array_function[@]} -eq ${#array_execute[@]} ]; then execute_test_var="$result_ok"; else execute_test_var="$result_fail"; fi
if [ ${#array_function[@]} -eq ${#array_path[@]} ]; then path_test_var="$result_ok"; else path_test_var="$result_fail"; fi
if [ ${#array_function[@]} -eq ${#array_read[@]} ]; then read_test_var="$result_ok"; else read_test_var="$result_fail"; fi
if [ ${#array_function[@]} -eq ${#array_start[@]} ]; then start_test_var="$result_ok"; else start_test_var="$result_fail"; fi
if [ ${#array_function[@]} -eq ${#array_end[@]} ]; then end_test_var="$result_ok"; else end_test_var="$result_fail"; fi

echo -e "[ array_function ] : ${function_test_var} : ${#array_function[@]} : ${array_function[*]}"
echo -e "[ array_execute  ] : $execute_test_var : ${#array_execute[@]} : ${array_execute[*]}"
echo -e "[ array_path     ] : $path_test_var : ${#array_path[@]} : ${array_path[*]}"
echo -e "[ array_read     ] : $read_test_var : ${#array_read[@]} : ${array_read[*]}"
echo -e "[ array_start    ] : $start_test_var : ${#array_start[@]} : ${array_start[*]}"
echo -e "[ array_end      ] : $end_test_var : ${#array_end[@]} : ${array_end[*]}"
