#!/bin/bash

function displayTable(){
    
    DBName=$1
    tableName=$2

    if [ -e ./DBs/$DBName/$tableName ]
    then 
        awk '{if(NR>1) print $0 "|";print "--------------------------------"}' ./DBs/$DBName/$tableName
    else 
        echo "Sorry, there's no table with $tableName name in $DBName DB!"
    fi
}

displayTable $@