result="$(eval "$(@options 'new:-n|-N' 'path:-p|--path:true' 'foo:-f' 'bar:q:false')")"
@@assert.noOut "${result}"

testFunc() {
  eval "$(@options 'new:-n|-N' 'path:-p|--path:true' 'foo:-f' 'bar:q:false')"
  echo $1
}

@@assert.equal '' "$(testFunc -n)"
@@assert.equal 'asd' "$(testFunc -n asd)"
@@assert.equal 'qnone' "$(testFunc qnone)"
@@assert.equal 'asd' "$(testFunc asd)"
@@assert.equal 'asd' "$(testFunc q asd)"
@@assert.equal 'asd' "$(testFunc -f asd)"
@@assert.equal 'asd' "$(testFunc -p 123 asd)"
@@assert.equal 'asd' "$(testFunc -p 123 --path querty asd)"
@@assert.equal '' "$(testFunc --path asd)"
@@assert.equal '' "$(testFunc --path asd -N)"
@@assert.equal 'asd' "$(testFunc --path asd -N asd)"

testFuncResult() {
  eval "$(@options 'new:-n|-N' 'path:-p|--path:true' 'foo:-f' 'bar:q:false')"
  eval "echo \${$1}"
}

@@assert.equal 'true' "$(testFuncResult -n new)"
@@assert.equal 'true' "$(testFuncResult -N new)"
@@assert.equal 'false' "$(testFuncResult new)"
@@assert.equal 'false' "$(testFuncResult -f new)"
@@assert.equal 'false' "$(testFuncResult -p asd new)"

@@assert.equal 'true' "$(testFuncResult q bar)"
@@assert.equal 'false' "$(testFuncResult bar)"
@@assert.equal 'false' "$(testFuncResult -f bar)"
@@assert.equal 'false' "$(testFuncResult -p asd bar)"

@@assert.equal '' "$(testFuncResult q 'path[@]')"
@@assert.equal '' "$(testFuncResult 'path[@]')"
@@assert.equal 'aaa' "$(testFuncResult -p aaa 'path[@]')"
@@assert.equal '1' "$(testFuncResult -p aaa '#path[@]')"
@@assert.equal 'aaa bbb ccc' "$(testFuncResult q -p aaa -p bbb --path ccc -n 'path[@]')"
@@assert.equal '3' "$(testFuncResult -p aaa -p bbb -N --path ccc q '#path[@]')"

@error() {
  echo 'ERROR-OK'
  exit 1
}
@@assert.equal "$(@error)" "$(testFunc -invalid)"
