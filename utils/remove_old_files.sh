#!/bin/bash

###############################################################################
# Remove all files older than N days in the given directory
#
# Usage:
#
#	remove_old_files.sh <dir-path> <n-days>
#
###############################################################################

source `dirname $0`/log_utils.sh

dirpath=$1
n_days=$2
if [ ! -d "$dirpath" ] ; then
	log_error "'$dirpath' is not a directory"
	exit 1
fi

if [ -z "$n_days" ] ; then
	log_Error "No n_days argument given to script"
	exit 1
fi

files=`find $dirpath -type f -mtime +$n_days #-exec rm {} \;`

if [ ! -z "$files" ] ; then
	log_info "The following files older than $n_days were found: \n\n$files\n\n"

	read -p "Remove? (y/n)? " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]] ; then
		rm $files
	fi
else
	log_info "No files older than $n_days found on '$dirpath'"
fi


###############################################################################
# Sources
###############################################################################
# - https://www.vionblog.com/linux-delete-files-older-than-x-days/
# - https://stackoverflow.com/a/1885534
###############################################################################
