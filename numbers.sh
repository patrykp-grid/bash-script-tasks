#!/bin/bash

for ((i = 1; i < 101; i++)); do
    if [ $((i % 3)) -eq 0 ]; then
        if [ $((i % 5)) -eq 0 ]; then
            echo "FizzBuzz"
        else
            echo "Fizz"
        fi
    elif [ $((i % 5)) -eq 0 ]; then
        echo "Buzz"
    else
        echo "$i"
    fi
done
