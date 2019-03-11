#!/bin/bash

function createDB(){
newDB=$1; 

if [ ! -e "./DBs/$newDB" ]
then 
    mkdir ./DBs/$newDB
    echo "DB $newDB created successfully!"
    
else 
    echo "Sorry, name there's a DB already existing under the name $newDB, please select a new name!"
fi
}
createDB $1
