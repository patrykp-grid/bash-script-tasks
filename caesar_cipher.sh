#!/bin/bash

# function definitions

# caesar cipher encription function
caesar_cipher() {
    text="$1"
    shift="$2"
    result=""

    for (( i=0; i<${#text}; i++ )); do
        char="${text:$i:1}"
        if [[ $char =~ [A-Za-z] ]]; then
            ascii_val=$(printf '%d' "'$char")
            if [[ $char =~ [A-Z] ]]; then
                base=65
            else
                base=97
            fi
            new_ascii_val=$(( (ascii_val - base + shift) % 26 + base ))
            result+="$(printf \\$(printf '%03o' "$new_ascii_val"))"
        else
            result+="$char"
        fi
    done

    echo "$result"
}


# read parameters
input_file=""
shift_n=0
output_file=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s)
      shift_n="$2"
      shift 2
      ;;
    -i)
      input_file="$2"
      shift 2
      ;;
    -o)
      output_file="$2"
      shift 2
      ;;
    *)
      echo "Error: Wrong parameters"
      exit 1
  esac
done

# main code execution
input_text=$(<"$input_file")
result=$(caesar_cipher "$input_text" "$shift_n")
echo "$result" > "$output_file"
