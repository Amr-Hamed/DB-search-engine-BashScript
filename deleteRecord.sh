#!/bin/bash

function deleteRecord(){
    
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
            if [[ $(awk -F: -v pk=$PKVal '{if(pk==$2&&NR>1) print $0}' ./DBs/$DBName/$tableName) ]]
            then 
            
                targetRecord=$(awk -F: -v pk=$PKVal '{if(pk==$2) print $0}' ./DBs/$DBName/$tableName)
                sed -i "/^$targetRecord$/d" ./DBs/$DBName/$tableName
                echo "Record deleted successfully from table $tableName!"
                
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
deleteRecord $@