#!/bin/bash
clear
validate='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'

if [ ! -e DBs ]
then
mkdir "./DBs"
fi

echo "                      |--------------------|"
echo "               -------| Welcome To AGO DBMS |-------"
echo "                      |--------------------|"
echo "" 
echo "" 
echo ""
printf "AGO SQL > "

read input

while [[ $input != "exit" ]]
do
    commands=("${my_array[@]}" $input)
    
    if [[ ${commands[2]} =~ $validate &&  ${#commands[@]} -eq 3 ]] 
    then 
    
        if [ ${commands[0]} == 'create' ] && [ ${commands[1]} == 'db' ]
        then
            . ./createDB.sh ${commands[2]}
                
        elif [ ${commands[0]} == 'delete' ] && [ ${commands[1]} == 'db' ]
        then
            . ./deleteDB.sh ${commands[2]}

        else
            echo "Error: Not a valid AGO sql syntax"

        fi

    elif [[ ${commands[1]} =~ $validate &&  ${#commands[@]} -eq 2 ]]
    then
        
        if [ ${commands[0]} == 'show' ] && [ ${commands[1]} == 'dbs' ]
        then
            . ./showDBs.sh

        elif [[ ${commands[0]} == 'use' ]]
        then
            . ./useDB.sh ${commands[1]}

        else
            echo "Error: Not a valid AGO sql syntax"

    fi

    else
        echo "Error: Not a valid AGO sql syntax"
    
    fi
    
    printf "AGO SQL > "
    read input

done