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

# Initialize zip file.
DATE=`date +%Y_%m_%d`

if [ ! -d "${HOME_ZIP_DIRPATH}" ]; then
    log_error "HOME_ZIP_DIRPATH [$HOME_ZIP_DIRPATH] is not a valid directory"
    exit 1
fi

ZIP_FILEPATH="${HOME_ZIP_DIRPATH}/${ZIP_FILENAME}_${DATE}"

# If defined, clone all the PUBLIC repositories of the given username.
if [ ! -z "${GITHUB_USERNAME}" ]; then
    log_info "Making backup of ${GITHUB_USERNAME}'s PUBLIC directories ..."
    (cd /tmp/ && github-backup.sh "${GITHUB_USERNAME}")
    zip -r "$ZIP_FILEPATH" "/tmp/github_repositories_backup_${GITHUB_USERNAME}"*
    log_info "Making backup of ${GITHUB_USERNAME}'s PUBLIC directories ...OK"
fi

# Compress and backup home directories.
log_info "Compressing ${HOME_DIRNAMES} to $ZIP_FILEPATH ..."
for home_dirname in "${HOME_DIRNAMES[@]}"
do
    zip -r "$ZIP_FILEPATH" "$HOME"/$home_dirname
done
log_info "Compressing $HOME_DIRNAMES to $ZIP_FILEPATH ...OK"

# Remove old backups
log_info "Removing backups older than $OLD_BACKUPS_N_DAYS in '$HOME_ZIP_DIRPATH' ..."
utils/remove_old_files.sh "$HOME_ZIP_DIRPATH" $OLD_BACKUPS_N_DAYS
log_info "Removing backups older than $OLD_BACKUPS_N_DAYS in '$HOME_ZIP_DIRPATH' ...OK"s
