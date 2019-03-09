#!/bin/bash

function useDB(){
    echo "Welcome to useDB menu"
    sleep 1
    
    DBName=$1

    if [ -e ./DBs/$DBName ]
    then
        echo "DB changed to $DBName!"
        . ./dbOperations.sh
    
    else
        echo "Sorry, there's no DB under $DBName name!"
      
    fi
}

useDB $1