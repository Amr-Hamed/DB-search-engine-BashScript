#!/bin/bash
function createTable(){

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
        let noOfCols=$(($#-2))
        printf "$noOfCols\n">> ./DBs/$DBName/$tableName
        echo "table $tableName created successfully and saved to $DBName DB!"
    else
        echo "Sorry, table name $tableName already exists in $DBName DB, please insert a new name!"
    fi
}
createTable $@ 
