#!/bin/bash

function createTable(){
    clear
    echo "Welcome to create table menu"
    sleep 2

    DBName=$1
    tableName=$2

    if [ ! -e ./DBs/$DBName/$tableName ]
    then 
        touch ./DBs/$DBName/$tableName
        i=3
        
        while [ $i -le $# ]
        do
        printf "%s:" ${!i} >> ./DBs/$DBName/$tableName
        let i=$i+1
        done
        echo >> ./DBs/$DBName/$tableName
    else
        echo "Sorry, table name $tableName already exists in $DBName DB, please insert a new name!"
    fi
}
createTable $@