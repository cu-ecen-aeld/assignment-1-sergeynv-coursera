#!/bin/sh

#VERBOSE=1

set -e # Exit immediately if a command exits with a non-zero status.
# set -u # Treat unset variables as an error when substituting.

# function verbose { 
# The above would work in bash, but is not POSIX/dash-friendly.
# Thus:
verbose () {  
  if [ -n "$VERBOSE" ]; then
    echo "writer.sh - INFO: $@"
  fi
}

# Accepts the following arguments: 
# - the first argument is a full path to a file (including filename) on the filesystem, 
# referred to below as writefile; 
# - the second argument is a text string which will be written within this file,
# referred to below as writestr.

# Exits with value 1 error and print statements if any of the arguments above were 
# not specified.

if [ $# -ne 2 ]; then
    echo "Expected 2 arguments: <writefile> <writestr>. But received $#."
    exit 1
fi

write_file=$1
write_str=$2
write_file_dir=$(dirname $write_file)

verbose "writefile: $write_file"
verbose "writestr : $write_str"

# Creates a new file with name and path writefile with content writestr, 
# overwriting any existing file and creating the path if it doesn’t exist. 
#
# Exits with value 1 and error print statement if the file could not be created.

if [ -e $write_file ]; then
    verbose "Destination file - $write_file - already exisits. Overriding..."
elif [ ! -d $write_file_dir ]; then
    verbose "Creating parent directory: $write_file_dir/ ..."
    mkdir -p $write_file_dir
fi

verbose "Writing \"$write_str\" to $write_file ..."

echo $write_str > $write_file
verbose "Done writing."
