## *
## Show title.
##
## Params:
##   *: {String} Message.

# Start
local t=" $@ "
local l=$(@str-len "${t}")

@print-line $l '-' '+-' '-+'
@print "| ${t} $(@style default)|"
@print-line $l '-' '+-' '-+'
@print
