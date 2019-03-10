#!/bin/bash

function displayRecord(){
    
    DBName=$1
    tableName=$2
    PKName=$3
    PKVal=$4

    intRegex='^[0-9]+$'
    textRegex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
    
    if [ -e ./DBs/$DBName/$tableName ]
    then 
        tableMeta=$(head -n 1 ./DBs/$DBName/$tableName)
        IFS=':' read -ra tableMetaArray <<< $tableMeta
        if [[ ${tableMetaArray[0]} == $PKName ]]
        then
            if [[ $(cut -d":" -f 2 ./DBs/$DBName/$tableName | grep $PKVal) == $PKVal ]]
            then 
                targetRecord=$(awk -F: -v pk=$PKVal '{if(pk==$2) print $0}' ./DBs/$DBName/$tableName)
                echo "The target record: " $targetRecord
            else
                echo "Sorry, there's no record with the value of primary key passed!"
            fi
        else
            echo "Sorry, primary key passed doesn't exist in table!"
        fi
    else
        echo "Sorry, table $tableName doesn't exist in $DBName DB!"
    fi
}
displayRecord $@