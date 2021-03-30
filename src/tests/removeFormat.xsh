@@assert.noErrOut '@style.clean "asd"'

@@assert.equal "$(echo -e "\t foo\nbar \t")" "$(@style.clean "$(echo -e "\t foo\nbar \t")")"
@@assert.equal " yellow red " "$(@style.clean " $(@style color:yellow)yellow $(@style color:red)red ")"

# vim: filetype=sh tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
