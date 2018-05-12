@@assert.noErrOut '@remove-format "asd"'

@@assert.equal "$(echo -e "\t foo\nbar \t")" "$(@remove-format "$(echo -e "\t foo\nbar \t")")"
@@assert.equal " yellow red " "$(@remove-format " $(@style color:yellow)yellow $(@style color:red)red ")"
