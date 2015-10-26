#!/bin/bash

# ################### #
#                     #
# Application Manager #
#                     #
# ################### #

# Load
. "$(dirname "$0")/src/bashx.sh"
# Run
e "a b c\n123\n\nd e f"
run "$@"
