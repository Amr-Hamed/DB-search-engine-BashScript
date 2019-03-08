#!user/bin/bash

function useDB(){
    echo "Wlecome to useDB menu"
    sleep 2
    
    DBName=$1

    if [ -e ./DBs/$DBName]
    then
        echo "DB changed to $DBName"
    else
        echo "Sorry, there's no DB under $DBName name"
    fi
}
useDB $1