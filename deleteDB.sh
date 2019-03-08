#!/user/bin/bash

function deleteDB(){
    echo "Wlecome to delete DB menu"
    sleep 2

    DBName=$1;
    if [ -e ./DBs/$DBName ]
    then 
        echo "Are you sure you want to delete $DBName DB?![y/n]: "
        read ans

        case $ans in 
        [Yy])   rm -r ./DBs/$DBName
                echo "DB $DBName deleted succcessfully!"
        ;;
        [Nn]    break
        ;;
        


}