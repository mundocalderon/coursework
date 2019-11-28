#!/usr/bin/env bash


function super_copy { 
	if [[ -e $1 ]]
	then
		echo "$1"
		scp $1 $DO_ROOT_USER:/root/textfiles/ 
	else
		echo "$1 : File not found"
	fi

}

echo "This utility expects a file as an argument: '$1' was given. It also expects you to use the super_copy function."
