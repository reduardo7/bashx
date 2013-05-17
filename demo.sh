#!/bin/bash
. ./xbash.sh

APP_TITLE="Demo XBash"
APP_VERSION="0.1"

function info() { #ARG: See info
    # Info
    e "Script name: $(script_file_name)"
    e "Path: $(current_directory_name)"
    e "Date and time: $(now_date_time)"
    
    # Separator
    e
    
    # Check root
    if [ $(is_root) = $TRUE ] ; then
        e "ROOT user"
    else
        e "No ROOT user"
    fi
}

# Run
run $@
