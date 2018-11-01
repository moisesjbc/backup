
###############################################################################
# backup_home configuration
###############################################################################

# Path to directory where home backups will be stored.
HOME_ZIP_DIRPATH=""

# Name of output compressed backup. Name will be ${ZIP_FILENAME}_${DATE}.
ZIP_FILENAME=""

# Array of dirnames inside home to be added to compressed file.
HOME_DIRNAMES=()

# Number of days for keeping backups. Backups older than this number of days
# will be deleted
OLD_BACKUPS_N_DAYS=30
