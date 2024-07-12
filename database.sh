#!/bin/bash

# database file format constants
ROW_LENGTH=39
COLUMN_LENGTH=8

# create Database
create_db() {
  local db_name="$1"
  touch "${db_name}.txt"
  echo "Database '${db_name}' created."
}

# create Table
create_table() {
  local db_name="$1"
  shift
  local table_name="$1"
  shift
  local columns=("$@")
  
  echo "* $(printf $table_name) *" >> "${db_name}.txt"
  
  for col in "${columns[@]}"; do
    printf "* $col *" >> "${db_name}.txt"
  done
  echo >> "${db_name}.txt"
  
  echo "Table '${table_name}' with columns '${columns[*]}' created in database '${db_name}'."
}

# insert Data
insert_data() {
  local db_name="$1"
  local table_name="$2"
  shift 2
  local data=("$@")
  
  echo "* $(printf $table_name) *" >> "${db_name}.txt"
  
  for value in "${data[@]}"; do
    printf "* $value *" >> "${db_name}.txt"
  done
  echo >> "${db_name}.txt"
  
  echo "Data inserted into table '${table_name}' in database '${db_name}'."
}

# select Data
select_data() {
  local db_name="$1"
  local table_name="$2"
  
  grep -n "\* ${table_name} \*" "baza.txt" | awk -F: '{print $1}' | while read -r line; do sed -n "$((line+1))p" baza.txt; done
}

# delete Data
# delete_data() {
#   local db_name="$1"
#   local table_name="$2"
#   local criteria="$3"
#   local column
#   local value
  
#   IFS='=' read -r column value <<< "$criteria"
  
#   sed -i.bak "/^* ${table_name} */,/^\*$/ {/ $column $value /d;}" "${db_name}.txt"
#   echo "Data matching criteria '${criteria}' deleted from table '${table_name}' in database '${db_name}'."
# }

if [ $# -lt 2 ]; then
  echo "Usage: $0 {create_db|create_table|insert_data|select_data|delete_data} <arguments>"
  exit 1
fi

# command-line argument parsing
command="$1"
shift

case "$command" in
  create_db)
    create_db "$@"
    ;;
  create_table)
    create_table "$@"
    ;;
  insert_data)
    insert_data "$@"
    ;;
  select_data)
    select_data "$@"
    ;;
  delete_data)
    delete_data "$@"
    ;;
  *)
    echo "Invalid command: $command"
    exit 1
    ;;
esac
