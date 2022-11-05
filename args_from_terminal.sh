#!/bin/bash
echo 'args one by one:' $1 $2 $3

# args=("$@")
args=$@
echo 'arg list elements:' ${args[0]} ${args[1]} ${args[2]}

echo 'all args:' $@

echo Number of arguments passed: 'number of args:' $#