#!/bin/bash

cat DPA_contest2_public_base_diff_vcc_a128_2009_12_23.tar.bz2.part* > DPA_contest2_public_base_diff_vcc_a128_2009_12_23.tar.bz2

bunzip2 DPA_contest2_public_base_diff_vcc_a128_2009_12_23.tar.bz2

tar xvf DPA_contest2_public_base_diff_vcc_a128_2009_12_23.tar

let i=0
let n= # Total number of DPAv2 / 4


all_traces=$(pwd)'/' #INSERT the folder name


for filename in $all_traces/*.csv;
do
    dir='part'$((i/n))
    mv $filename $dir
    i=$((i+1))
done
