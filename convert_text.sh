#!/bin/bash

# global variable definition
input=""
output=""
change_case=false
substitute=false
reverse=false
lower=false
upper=false
a_word=""
b_word=""

# process input flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    -i)
      input="$2"
      shift 2
      ;;
    -o)
      output="$2"
      shift 2
      ;;
    -v)
      change_case=true
      shift 1
      ;;
    -s)
      substitute=true
      shift
      a_word=$1
      shift
      b_word=$1
      shift
      ;;
    -r)
      reverse=true
      shift 1
      ;;
    -l)
      lower=true
      shift 1
      ;;
    -u)
      upper=true
      shift 1
      ;;
    *)
      echo "Error: Wrong parameters"
      exit 1
  esac
done

# main code execution

input_text=$(<"$input")

# toggle case if -v is passed
if [ "$change_case" = true ]; then
    input_text=$(echo "$input_text" | tr 'a-zA-Z' 'A-Za-z')
fi

# substitute words if -s is passed
if [ "$substitute" = true ]; then
    input_text=$(echo "$input_text" | sed "s/$a_word/$b_word/g")
fi

# reverse lines if -r is passed
if [ "$reverse" = true ]; then
    input_text=$(echo "$input_text" | tac)
fi

# convert to lower case if -l is passed
if [ "$lower" = true ]; then
    input_text=$(echo "$input_text" | tr 'A-Z' 'a-z')
fi

# convert to upper case if -u is passed
if [ "$upper" = true ]; then
    input_text=$(echo "$input_text" | tr 'a-z' 'A-Z')
fi

# write result to the output file
echo "$input_text" > "$output"