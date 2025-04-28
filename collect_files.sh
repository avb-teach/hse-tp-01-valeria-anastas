#!/bin/bash

input_dir=$1
output_dir=$2
if [[ $3 == --max_depth && -n $4 && $4 -ge 0]]; then
  extra_args="-maxdepth $4"
fi
declare -i count

for f in $(find $input_dir $extra_args -type f); do
  basename=${f##*/}
  name=$basename
  count=0
  while [[ -e $output_dir/$name ]]; do
    count+=1
    name=${basename/./$count.}
  done
  cp $f $output_dir/$name
done
