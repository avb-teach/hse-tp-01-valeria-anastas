#!/bin/bash

input_dir=$1
output_dir=$2

declare -i count

for f in $(find $input_dir -type f); do
  basename=${f##*/}
  name=$basename
  count=0
  while [[ -e $output_dir/$name ]]; do
    count+=1
    name=${basename/./$count.}
  done
  cp $f $output_dir/$name
done
