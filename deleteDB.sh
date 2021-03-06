#!/bin/bash

function deleteDB(){

    DBName=$1;
    if [ -e ./DBs/$DBName ]
    then 
        while true
        do
            echo "Are you sure you want to delete $DBName DB?![y/n]: "
            read ans
                case $ans in 
                [Yy])   rm -r ./DBs/$DBName
                        echo "DB $DBName deleted succcessfully!"
                        break
                ;;
                [Nn])   break
                ;;
                *)      echo "Sorry, invalid option, please select Y or y for yes, N or n for no!"
                ;;
                esac 
        done
    else
        echo "Sorry, no database under the given name $DBName!"
    fi
}
deleteDB $1