#!/bin/bash
clear
validate='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
dbName=$1
tableFields=($dbName)

echo "                      |----------------------------------|"
echo "                          Start using $dbName Database  "
echo "                      |----------------------------------|"
echo "" 
echo "" 
echo ""
printf "AGO SQL [$dbName] > "

read input

while [[ $input != "exit" ]]
do
    commands=("${my_array[@]}" $input)
    
  
    if [[ ${commands[0]} == 'create' && ${commands[1]} == 'table' && ${commands[2]} =~ $validate && ${commands[3]} == '(' && ${#commands[@]} -eq 4 ]]
    then
        
        tableFields[1]=${commands[2]}
        i=2
        read fields
        while [[ $fields != ")" ]]
        do
            field=("${my_array[@]}" $fields)
            if [[ ${field[1]} == "int" || ${field[1]} == "text" ]] &&  [[ ${field[0]} =~ $validate  && ${#field[@]} -eq 2 ]]
            then
                tableFields[$i]=${field[0]}
                i=$((i+1))
                tableFields[$i]=${field[1]}
                i=$((i+1))
                
            else
                echo "Error: Not a valid AGO sql syntax"
                break
            fi

            read fields
        done

        if [ $fields == ")" ]
        then
   
            . ./createTable.sh ${tableFields[*]}
   
        fi

    elif [[ ${commands[0]} == 'drop' && ${commands[1]} == 'table' && ${commands[2]} =~ $validate && ${#commands[@]} -eq 3 ]]
    then

        . ./deleteTable.sh $dbName ${commands[2]}
    
    elif [[ ${commands[0]} == 'insert' && ${commands[1]} == 'into' && ${commands[2]} =~ $validate && ${commands[3]} == "set" ]]
    then
        
        . ./insertRecord.sh $dbName ${commands[2]} ${commands[@]:4}
    
    elif [[ ${commands[0]} == 'update' && ${commands[1]} =~ $validate && ${commands[2]} == 'set' && ${commands[-3]} == 'where' && ${#commands[@]} -ge 8 ]]
    then

        let i=${#commands[@]}-6
        . ./updateRecordEnhanced.sh $dbName ${commands[1]} ${commands[-2]} ${commands[-1]} ${commands[@]:3:$i}

    elif [[ ${commands[0]} == 'delete' && ${commands[1]} == 'from' && ${commands[2]} =~ $validate && ${commands[3]} == 'where' && ${#commands[@]} -eq 6 ]]
    then
        
        . ./deleteRecord.sh $dbName ${commands[2]} ${commands[@]:4}

    elif [[ ${commands[0]} == 'select' && ${commands[1]} == 'all' && ${commands[2]} == 'from' && ${commands[3]} =~ $validate && ${commands[4]} == 'where' && ${#commands[@]} -eq 7 ]]
    then
        
        . ./displayRecord.sh $dbName ${commands[3]} ${commands[@]:5}

    elif [[ ${commands[0]} == 'select' && ${commands[1]} == 'all' && ${commands[2]} == 'from' && ${commands[3]} =~ $validate && ${#commands[@]} -eq 4 ]]
    then
        
        . ./displayTable.sh $dbName ${commands[3]}

    else
        echo "Error: Not a valid sql syntax"
    
    fi
    
    printf "AGO SQL [$dbName] > "
    read input

done