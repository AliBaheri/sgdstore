#!/bin/bash

if [ $# -ne 1 ]; then
  echo 'Usage: to_matlab.sh <log.txt>' >&2
  exit 1
fi

filename=$(basename "$1")
varname=${filename%.txt}

yvalues=$(cat "$1" | grep 'validation=[0-9]' |
  sed -E 's/^.*validation=([0-9\.]*).*$/    \1/g')
numlines=$(echo "$yvalues" | wc -l | sed -E 's/ //g')

echo "${varname}_x = [1:256:${numlines}*256];"
echo "${varname}_y = ["
echo "$yvalues"
echo "];"