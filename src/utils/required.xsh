## cmd*
## Check for required software.
##
## Params:
##   cmd* {String} List of commands to check.
##
## Usage example:
##   @required docker docker-compose composer npm

local cmds=( $@ )
local cmd

for cmd in ${cmds[@]}; do
  if ! command -v ${cmd} >/dev/null 2>&1
    then
      @app.error "I require [${cmd}] but it's not installed. Aborting."
    fi
done

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
