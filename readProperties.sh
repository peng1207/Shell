#!/bin/bash
key=$1
#echo "key is ${key}"
properties_Path="../config.properties"

function readParameter() {

variable=$1
shift
parameter=$1
shift

eval $variable="\"$(sed '/^\#/d' $properties_Path | grep $parameter | tail -n 1 | cut -d '=' -f2- | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')\""
}

value='';readParameter value "${key}"
echo $value
