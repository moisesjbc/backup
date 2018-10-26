#!/bin/bash

# Load util functions.
source utils/log_utils.sh

# Load configuration file.
CONFIG_FILEPATH=$1
if [ ! -f "$CONFIG_FILEPATH" ]; then
    log_error "No config filepath given or config filepath [$CONFIG_FILEPATH] is not a file"
    exit 1  
fi
source $CONFIG_FILEPATH

# Compress and backup home directories.
DATE=`date +%Y_%m_%d`

if [ ! -d "${HOME_ZIP_DIRPATH}" ]; then
    log_error "HOME_ZIP_DIRPATH [$HOME_ZIP_DIRPATH] is not a valid directory"
    exit 1
fi

ZIP_FILEPATH="${HOME_ZIP_DIRPATH}/${ZIP_FILENAME}_${DATE}"
log_info "Compressing ${HOME_DIRNAMES} to $ZIP_FILEPATH ..."
for home_dirname in "${HOME_DIRNAMES[@]}"
do
    zip -r "$ZIP_FILEPATH" "$HOME"/$home_dirname
done
log_info "Compressing $HOME_DIRNAMES to $ZIP_FILEPATH ...OK"


