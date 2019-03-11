#!/bin/bash

function useDB(){    
    DBName=$1

    if [ -e ./DBs/$DBName ]
    then
        echo "DB changed to $DBName!"
        sleep 2    
        . ./dbOperations.sh
    else
        echo "Sorry, there's no DB under $DBName name!"
      
    fi
}

useDB $1