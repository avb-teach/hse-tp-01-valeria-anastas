#!/bin/bash

input_dir=$1
output_dir=$2
max_depth=1
if [[ $3 == --max_depth && $4 -ge 1 ]]; then
  max_depth=$4
fi
declare -i count

for f in $(find $input_dir -type f); do
  basename=${f##*/}
  dir=${f%$basename}
  dir=${dir#$input_dir/}
  for ((i = 1; i < $max_depth; i++)); do
    if [[ -n $dir ]]; then
      dir=${dir%/}
      p=${dir##*/}
      basename=$p/$basename
      dir=${dir%$p}
    fi
  done
  name=$basename
  count=0
  while [[ -e $output_dir/$name ]]; do
    count+=1
    name=${basename/./$count.}
  done
  dest=$output_dir/$name
  mkdir -p ${dest%${dest##*/}}
  cp $f $dest
done
