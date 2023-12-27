#!/usr/bin/bash
ostr=".cou"
for file in ../design_files/*.cin
do
    echo ${file/.cin/}${ostr}
done
