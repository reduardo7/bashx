result="$(eval "$(@args 'new:-n|-N' 'path:-p|--path:true' 'foo:-f')")"
@@assert.noOut "${result}"

testFunc() {
  eval "$(@args 'new:-n|-N' 'path:-p|--path:true' 'foo:-f')"
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
  eval "$(@args 'new:-n|-N' 'path:-p|--path:true' 'foo:-f')"
  eval "echo \${$1}"
}

@@assert.equal 'true' "$(testFuncResult -n args_new)"
@@assert.equal 'true' "$(testFuncResult -N args_new)"
@@assert.equal 'false' "$(testFuncResult args_new)"
@@assert.equal 'false' "$(testFuncResult -f args_new)"
@@assert.equal 'false' "$(testFuncResult -p asd args_new)"

@@assert.equal 'false' "$(testFuncResult args_foo)"
@@assert.equal 'true' "$(testFuncResult -f args_foo)"
@@assert.equal 'false' "$(testFuncResult -p asd args_foo)"

@@assert.equal '' "$(testFuncResult 'args_path[@]')"
@@assert.equal 'aaa' "$(testFuncResult -p aaa 'args_path[@]')"
@@assert.equal '1' "$(testFuncResult -p aaa '#args_path[@]')"
@@assert.equal 'aaa bbb ccc' "$(testFuncResult -p aaa -p bbb --path ccc -n 'args_path[@]')"
@@assert.equal '3' "$(testFuncResult -p aaa -p bbb -N --path ccc '#args_path[@]')"

@app.error() {
  echo 'ERROR-OK'
  exit 1
}
@@assert.equal "$(@app.error)" "$(testFunc -invalid)"
