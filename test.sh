#!/bin/bash
clear

read line
while [[ -n "$line" ]]
do
    my_array=("${my_array[@]}" $line)
    read line
done

echo ${my_array[@]}