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

if [ $# -ne 2 ]; then
    echo "Expected exactly 2 arguments: <writefile> <writestr>. But received $#."
    exit 1
fi

write_file=$1
write_file_dir=$(dirname $write_file)
write_str=$2

debug "===================================="
debug "\$write_file     = $write_file"
debug "\$write_file_dir = $write_file_dir"
debug "\$write_str      = $write_str"
debug "===================================="

if [ -e $write_file ]; then
    verbose "Destination file - $write_file - already exisits. Overriding..."
elif [ ! -d $write_file_dir ]; then
    verbose "Creating parent directory: $write_file_dir/ ..."
    mkdir -p $write_file_dir
fi

verbose "Writing \"$write_str\" to $write_file ..."

echo $write_str > $write_file
verbose "Done."

debug "===================================="
if [ -n "$DEBUG" ]; then
    ls -la $write_file
    cat $write_file
fi
debug "===================================="
