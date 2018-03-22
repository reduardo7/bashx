## *
## Show title.
##
## *: {String} Message.

# Start
local t=" $@ "
local l=$(@str-len "${t}")
l="+-$(@str-repeat $l '-')-+"

@print "${l}"
@print "| ${t} $(@style default)|"
@print "${l}"
@print
