# Show title.
#
# *: {String} Message.

# Start
local t=" $@ "
local l="+-$(@str-repeat $(@str-len "${t}") "-")-+"

@e "${l}"
@e "| ${t} `@style default`|"
@e ${l}
