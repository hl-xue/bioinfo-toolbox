#!/bin/bash

out_path=$1
jf_dir=$2
query_path=$3
jf_bin=$4

for jf_file in $jf_dir; do
    sample_name=$(basename jf_file .jf)
    $jf_bin query -s $query_path -o $out_path/$sample_name.tsv $jf_file
done
