#!/bin/bash

function showDBs(){
    
    if [ -e ./DBs ]
    then 
        if [ "$(ls -A ./DBs)" ]
        then
            echo "Your DBs are : "
            ls ./DBs
        else
            echo "Sorry, you don't have any DBs yet, try creating one first!"
        fi
    else
        echo "Sorry, you don't have any DBs yet, try creating one first!"
    fi
}
showDBs