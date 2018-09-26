#!/bin/bash

#
# C64 Maze
#

time_sleep=0.01
col_counter=0
# Fetch terminalsize or arg1
let row_max_size=${1:-$(tput cols)-2}

title='[ Be aMAZEd!! ]'
end_title='[ END ]'

# Send stderr to null incase of ctrl+c breaks in if/while statement.
exec 2> /dev/null

# Trap sighup etc and make clean exit.
trap 'echo -e "\b\b  \n\e[0m${bottom_header}\nIts a TRAP!";exit 0' 1 2 3 5 15

# Function area
function create_header {
	# Calculate header lentgh based on inputvalue
	let ch=($row_max_size-${#1})/2
	# Create empty var with nN of space(s)
	ch=$(printf "%${ch}s")
	# Subst space(s) with dash(es)
	ch=${ch// /-}
	# Return built string
	echo "+"${ch}${1}${ch}"+"
}

function col_limiter {
	# Check whether the actual printed number of columns is equal to max amount of colums
	# If not equal, increase column counter and proceed to next iteration.
	if [ $col_counter -eq $(expr ${#bottom_header} \- 1 ) ];then
		echo '';col_counter=0
	else
		let col_counter=$col_counter+1
	fi
}

function set_color {
echo -ne "\e[0;3$(shuf -i 1-7 -n1);40m"
}


###############################################################
# MAIN SCRIPT
###############################################################
bottom_header=$(create_header "$end_title")

if [ ${1} -lt 15 ];then
	echo "ERR: Arg(1) to low, please set 15 or more."
	exit 1
fi

echo -e "\e[0m"$(create_header "$title")

while true :
do
	if [ "$(( ${RANDOM:0:1} % 2))" -ne 0 ]; then
		echo -ne $(set_color)'/';col_limiter
		sleep $time_sleep
	else
		echo -ne $(set_color)'\';col_limiter
		sleep $time_sleep
	fi
done

echo -e "\n${bottom_header}\n$Done!"

exit 0
