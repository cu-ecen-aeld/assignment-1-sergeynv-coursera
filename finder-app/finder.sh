#!/bin/sh

#VERBOSE=1

set -e # Exit immediately if a command exits with a non-zero status.
# set -u # Treat unset variables as an error when substituting.

# function verbose { 
# The above would work in bash, but is not POSIX/dash-friendly.
# Thus:
verbose () {  
  if [ -n "$VERBOSE" ]; then
    echo "finder.sh - INFO: $@"
  fi
}

# Accepts the following runtime arguments:
# - the first argument is a path to a directory on the filesystem,
#   referred to below as filesdir; 
# - the second argument is a text string which will be searched within these files,
#   referred to below as searchstr

# Exits with return value 1 error and print statements if any of the parameters above were 
# not specified.

if [ $# -ne 2 ]; then
    echo "Expected 2 arguments: <filesdir> <searchstr>. But received $#."
    exit 1
fi

files_dir=$1
search_str=$2

verbose "filesdir : $files_dir"
verbose "searchstr: $search_str"

# Exits with return value 1 error and print statements if filesdir does not represent 
# a directory on the filesystem.

if [ ! -d $files_dir ]; then
    echo "Target directory - $files_dir - does not exist."
    exit 1
fi

# Prints a message "The number of files are X and the number of matching lines are Y" where 
# X is the number of files in the directory and all subdirectories and 
# Y is the number of matching lines found in respective files,
# where a matching line refers to a line which contains searchstr (and may also contain additional content).

verbose
verbose "Counting files..."

num_files=$(find $files_dir -type f | wc -l)

verbose "Found $num_files files." 
verbose
verbose "Searching for \"$search_str\" in $files_dir ..."

num_match_lines=$(grep -r $search_str $files_dir | wc -l)

verbose "Found $num_match_lines matching lines."
verbose

echo "The number of files are $num_files and the number of matching lines are $num_match_lines"
