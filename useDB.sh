#!/bin/bash

function useDB(){
    echo "Wlecome to useDB menu"
    sleep 2
    
    DBName=$1

    if [ -e ./DBs/$DBName ]
    then
        echo "DB changed to $DBName!"
        return 1;
    else
        echo "Sorry, there's no DB under $DBName name!"
        return 0;
    fi
}
success=useDB $1
export $success