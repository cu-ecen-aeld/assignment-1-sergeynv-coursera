#!/bin/sh

#DEBUG=1
#VERBOSE=1

set -e # Exit immediately if a command exits with a non-zero status.
# set -u # Treat unset variables as an error when substituting.

function verbose {
  if [ -n "$VERBOSE" ]; then
    echo "INFO : $@" 
  fi
}

function debug {
  if [ -n "$DEBUG" ]; then
    echo "DEBUG: $@" 
  fi
}

debug "===================================="
for i in $( seq 0 $#); do
    debug "\$$i = ${!i}"
done
debug "===================================="

# Exits with return value 1 error and print statements if any of the parameters above were not specified.
if [ $# -ne 2 ]; then
    echo "Expected 2 arguments: <filesdir> <searchstr>. But received $#."
    exit 1
fi

files_dir=$1
search_str=$2

debug "===================================="
debug "\$files_dir  = $files_dir"
debug "\$search_str = $search_str"
debug "===================================="

# Exits with return value 1 error and print statements if filesdir does not represent a directory on the filesystem.
if [ ! -d $files_dir ]; then
    echo "Target directory - $files_dir - does not exist."
    exit 1
fi

# Prints a message "The number of files are X and the number of matching lines are Y" 
# where X is the number of files in the directory and all subdirectories and Y is the 
# number of matching lines found in respective files, where a matching line refers to 
# a line which contains searchstr (and may also contain additional content).

verbose
verbose "Counting files..."

num_files=$(find $files_dir -type f | wc -l)

verbose "Found $num_files files." 
verbose
verbose "Searching for \"$search_str\" in $files_dir ..."


# -o - Print only the matched (non-empty) parts of a matching line, 
#      with each such part on a separate output line.
num_str_matches=$(grep -r -o $search_str $files_dir | wc -l)

verbose "Found $num_str_matches matches." 
verbose

echo "The number of files are $num_files and the number of matching lines are $num_str_matches"
