function log {
    log_level=$1
    message=$2

    echo -e "[${1}] ${2}"
}

function log_info {
    message=$1
    log "INFO" "$1"
}

function log_error {
    message=$1
    log "ERROR" "$1"
}
