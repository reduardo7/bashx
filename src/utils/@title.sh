# Show title.
#
# *: {String} Message.

# Start
local t=" $@ "
local l="+-$(@str_repeat $(@str_len "${t}") "-")-+"

@e "${l}"
@e "| ${t} |"
@e ${l}
