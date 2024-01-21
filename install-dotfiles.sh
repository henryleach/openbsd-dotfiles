#!/bin/sh

# Creates hidden symlinks to all regular files found in
# the dir given as first argument, or current dir
# if none is given. Hidden files from the source dir are ignored.
# WARNING: It will OVERWRITE files with matching names in the home dir.

# Get the name of the scrip itself
scriptName=$(basename "$0")

# Set current directory as dir to work from
# if no dir specified.
dotfileDir="${1:-.}"

dotfiles=$(find $dotfileDir -maxdepth 1 -type f -not -name '.*')

# Create an array of results
set -A allFiles $dotfiles

for i in ${dotfiles[@]}; do
    # Ensure we don't accidently included this script.
    if [ "$(basename $i)" != "$scriptName" ]; then
	ln -sf "$(realpath $i)" ~/."$(basename $i)" && \
	echo "Linked $(realpath $i) -> ~/.$(basename $i)";
    fi
done




