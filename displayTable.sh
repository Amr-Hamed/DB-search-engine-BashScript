#!/bin/bash

function displayTable(){
    
    DBName=$1
    tableName=$2

    if [ -e ./DBs/$DBName/$tableName ]
    then 

        lines=$(cat ./DBs/$DBName/$tableName | wc -l)
        if [[ $lines -gt 1 ]]
        then
            awk '{if(NR>1) print $0 "|";print "--------------------------------"}' ./DBs/$DBName/$tableName
        else
            echo "The table $tableName have no records yet!"
        fi

    else 
        echo "Sorry, there's no table with $tableName name in $DBName DB!"
    fi
}

displayTable $@