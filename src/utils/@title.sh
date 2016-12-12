# Show title.
#
# *: {String} Message.

# Start
local t=" $@ "
local l=$(@str-len "${t}")
l="+-$(@str-repeat $l '-')-+"

@e "${l}"
@e "| ${t} $(@style default)|"
@e "${l}"
@e
