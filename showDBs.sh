#!/bin/bash

function showDBs(){
    echo "Welcome to show DBs menu"
    sleep 2
    if [ -e ./DBs ]
    then 
        echo "Your DBs are : "
        ls ./DBs
    else
        echo "Sorry, you don't have any DBs yet, try creating one first!"
    fi
}
showDBs