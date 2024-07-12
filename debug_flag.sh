#!/bin/bash

#function definitions

#perform operations function

perform_operation() {
  nums=("$@")
  result=${nums[1]}

  for ((i = 2; i < ${#nums[@]}; i++)); do
    case $operation in
      +)
        result=$(($result + ${nums[i]}))
        ;;
      -)
        result=$(($result - ${nums[i]}))
        ;;
      \\*) 
        result=$(($result * ${nums[i]}))
        ;;
      %)
        result=$(($result % ${nums[i]}))
        ;;
      *)
        echo "Invalid operation: $op"
        exit 1
        ;;
    esac
  done

  echo "$result"
}

#code execution

operation=""
numbers=()
debug=false

#assigning opearations, numbers and debug using a loop over parameters
while [[ $# -gt 0 ]]; do
  case "$1" in
    -o)
      if [[ "$2" == "*" ]]; then
        operation="\*"
      else
        operation=$2 
      fi
      shift 2
      ;;
    -n)
      shift
      while [[ $# -gt 0 && ! "$1" =~ ^- ]]; do
        numbers+=("$1")
        shift
      done

      if [[ ${#numbers[@]} -lt 2 ]]; then
        echo "Error: At least two numbers are required after -n."
        exit 1
      fi
      ;;
    -d)
      debug=true
      shift
      ;;
    *)
      echo "Error: Wrong parameters"
      exit 1
  esac
done

# debug mode option
if $debug; then
  echo "User: $(whoami)"
  echo "Script: $0"
  echo "Operation: $operation"
  echo "Numbers: ${numbers[@]}"
fi

# return result
result=$(perform_operation $operation "${numbers[@]}")
echo "Result: $result"





