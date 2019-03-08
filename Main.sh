#!/bin/bash
clear
validate='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'

if [ ! -e DBs ]
then
mkdir "./DBs"
fi

read input
while [[ $input != "e" ]]
do
    commands=("${my_array[@]}" $input)
    if [ ${commands[0]} == 'create' ] && [ ${commands[1]} == 'db' ] && [ ${#commands[@]} -eq 3 ]
        then
            if [[ ${commands[2]} =~ $validate ]]
                then
                echo "Valid sql syntax"
            else
                echo "Not valid sql syntax"
            fi
            
    fi
    
    read input

done