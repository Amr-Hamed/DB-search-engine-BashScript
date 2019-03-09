#!/bin/bash

function createTable(){
    clear
    echo "Welcome to create table menu"
    sleep 2

    DBName=$1
    tableName=$2

    if [ ! -e ./DBs/$DBName/.DBMetaData ]
    then 
        touch ./DBs/$DBName/.DBMetaData
    fi

    if [ ! -e ./DBs/$DBName/$tableName ]
    then 
        touch ./DBs/$DBName/$tableName
        echo $@ >> ./DBs/$DBName/.DBMetaData
        echo
        echo $@ >> ./DBs/$DBName/$tableName
        echo 
    else
        echo "Sorry, table name $tableName already exists in $DBName DB, please insert a new name!"
    fi
}
createTable $@ 