#!/user/bin/bash

function createDB(){
echo "Wlecome to Create DB menu"
sleep 2
newDB=$1; 

if [ ! -e "./DBs/$newDB" ]
then 
    mkdir ./DBs/$newDB
    echo "DB $newDB created successfully!"
    sleep 2
else 
    echo "Sorry, name there's a DB already existing under the name $newDB, please select a new name!"
    sleep 2
fi
}
createDB $1
