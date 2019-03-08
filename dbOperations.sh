#!/bin/bash
clear
validate='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
dbName=$1
tableFields=($dbName)

echo "                      |----------------------------------|"
echo "               -------|    Start using $dbName Database  |-------"
echo "                      |----------------------------------|"
echo "" 
echo "" 
echo ""
printf "AGO SQL [$dbName] > "

read input

while [[ $input != "exit" ]]
do
    commands=("${my_array[@]}" $input)
    
  
    if [ ${commands[0]} == 'create' ] && [ ${commands[1]} == 'table' ] && [ ${commands[2]} =~ $validate ] && [ ${commands[3]} == '(' ] && [ ${#commands[@]} -eq 4 ] 
    then
        
        tableFields[1] = ${commands[2]}
        i = 2
        read fields
        while [[ $fields != ")" ]]
        do
            field=("${my_array[@]}" $fields)
            if [[ ${field[1]} == "int" || ${field[1]} == "text" ]] && [ ${field[0]} =~ $validate ]  && [ ${#field[@]} -eq 2 ]
            then
                tableFields[$i]=${field[0]}
                let $i = $i + 1
                tableFields[$i]=${field[1]}
                let $i = $i + 1
            else
                echo "Error: Not a valid AGO sql syntax"
                break
            fi

            read fields
        done

        if [ $fields == ")" ]
        then
            . ./createTable.sh "${tableFields[@]}"
        fi

    else
        echo "Error: Not a valid sql syntax"
        echo "here"
    
    fi
    
    printf "AGO SQL [$dbName] > "
    read 

done