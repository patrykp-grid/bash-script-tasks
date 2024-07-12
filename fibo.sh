#!/bin/bash

#program for executing fibonacci sequence function

#function declarations

#fibonacci function
function fibo(){
	n=$1

	#decide what action to take based on fibonacci sequence algorithm 
	if [ "$n" -eq "0" ]; then
		echo "0"
	elif [ "$n" -eq "1" ]; then
		echo "1"
	elif [ "$n" -gt "1" ]; then
		echo "$(( $(fibo $(($n - 1))) + $(fibo $(($n - 2))) ))"
	fi
}

#main code execution

#test for correct number of parameters (1 = n)
if [ ! $# -eq "1" ]; then
        echo "Fibonacci function requires 1 parameter"
        exit 1
fi

#test for correct value of n parameter
if [ $1 -lt "0" ]; then
	echo "Wrong value for n, has to be >=0"
	exit 1
fi

#function invocation
fibo "$1"
	
