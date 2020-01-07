## *
## Show title.
##
## Params:
##   *: {String} Message.

# Start
local t=" $@ "
local l=$(@str.len "${t}")

@log.line $l '-' '+-' '-+'
@log "| ${t} $(@style)|"
@log.line $l '-' '+-' '-+'
@log
