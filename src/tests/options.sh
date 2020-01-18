result="$(eval "$(@options 'new:-n|-N' 'path:-p|--path:true' 'foo:-f')")"
@@assert.noOut "${result}"

testFunc() {
  eval "$(@options 'new:-n|-N' 'path:-p|--path:true' 'foo:-f')"
  echo $1
}

@@assert.equal '' "$(testFunc -n)"
@@assert.equal 'asd' "$(testFunc -n asd)"
@@assert.equal 'n' "$(testFunc n one)"
@@assert.equal 'asd' "$(testFunc asd)"
@@assert.equal 'asd' "$(testFunc -f asd)"
@@assert.equal 'asd' "$(testFunc -p 123 asd)"
@@assert.equal 'asd' "$(testFunc -p 123 --path querty asd)"
@@assert.equal '' "$(testFunc --path asd)"
@@assert.equal '' "$(testFunc --path asd -N)"
@@assert.equal 'asd' "$(testFunc --path asd -N asd)"

testFuncResult() {
  eval "$(@options 'new:-n|-N' 'path:-p|--path:true' 'foo:-f')"
  eval "echo \${$1}"
}

@@assert.equal 'true' "$(testFuncResult -n @options.new)"
@@assert.equal 'true' "$(testFuncResult -N @options.new)"
@@assert.equal 'false' "$(testFuncResult @options.new)"
@@assert.equal 'false' "$(testFuncResult -f @options.new)"
@@assert.equal 'false' "$(testFuncResult -p asd @options.new)"

@@assert.equal 'false' "$(testFuncResult foo)"
@@assert.equal 'true' "$(testFuncResult -f foo)"
@@assert.equal 'false' "$(testFuncResult -p asd foo)"

@@assert.equal '' "$(testFuncResult '@options.path[@]')"
@@assert.equal 'aaa' "$(testFuncResult -p aaa '@options.path[@]')"
@@assert.equal '1' "$(testFuncResult -p aaa '#@options.path[@]')"
@@assert.equal 'aaa bbb ccc' "$(testFuncResult -p aaa -p bbb --path ccc -n '@options.path[@]')"
@@assert.equal '3' "$(testFuncResult -p aaa -p bbb -N --path ccc '#@options.path[@]')"

@app.error() {
  echo 'ERROR-OK'
  exit 1
}
@@assert.equal "$(@app.error)" "$(testFunc -invalid)"
