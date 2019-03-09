#user/bin/bash

function deleteTable(){
    echo "Welcome to the delete table menu"
    sleep 2
    DBName=$1
    tableName=$2

    if [ -e ./DBs/$DBName/$tableName ]
    then 
        while true
        do
            echo "Are you sure you want to delete $DBName DB?![y/n]: "
            read ans
                case $ans in 
                [Yy])   rm ./DBs/$DBName/$tableName
                        sed -i "/$tableName/d" ./DBs/$DBName/.DBMetaData
                        echo "Table $tableName deleted successfully!"
                        break
                ;;
                [Nn])   break
                ;;
                *)      echo "Sorry, invalid option, please select Y or y for yes, N or n for no!"
                        sleep 2
                ;;
                esac 
        done
        
    else
        echo "Sorry, there's no $tableName table in $DBName DB!"
    fi
}
deleteTable $@