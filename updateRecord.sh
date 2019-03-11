#!/bin/bash

function updateRecord(){
    
    DBName=$1
    tableName=$2

    PKValIndex=$(($#))
    PKVal=${!PKValIndex}
    PKNameIndex=$(($#-1))
    PKName=${!PKNameIndex}

    noOfArgs=$(($#-2))
    fieldsArray=()
    intRegex='^[0-9]+$'
    textRegex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
    
    if [ -e ./DBs/$DBName/$tableName ]
    then 
        tableMeta=$(head -n 1 ./DBs/$DBName/$tableName)
        IFS=':' read -ra tableMetaArray <<< $tableMeta
        if [ ${tableMetaArray[0]} == $PKName ]
        then
            if [[ $(cut -d":" -f 2 ./DBs/$DBName/$tableName | grep $PKVal) == $PKVal ]] 
            then
                if [ ${tableMetaArray[-1]} -eq $noOfArgs ]
                then 
                    for ((i=0;i<$noOfArgs;i+=2))
                    do
                    j=3
                for ((;j<=$#;j++)) {
                    if [[ ${tableMetaArray[i]} == ${!j} ]]; 
                    then
                
                        fieldsArray=("${fieldsArray[@]}" "${!j}")
                        if [ ${tableMetaArray[$(($i+1))]} == "int" ]
                        then
                            let j=$j+1
                            if [[ ${!j} =~ $intRegex ]]
                            then  
                                fieldsArray=("${fieldsArray[@]}" "${!j}")
                                break
                            else 
                                echo "Error: Not a valid AGO sql syntax, value entered for ${tableMetaArray[i]} must be int!"
                                return 0
                            fi

                        elif [ ${tableMetaArray[$(($i+1))]} == "text" ]
                        then
                            let j=$j+1
                            if [[ ${!j} =~ $textRegex ]]
                            then 
                                fieldsArray=("${fieldsArray[@]}" "${!j}")
                                break
                            else 
                                echo "Error: Not a valid AGO sql syntax, value entered for ${tableMetaArray[i]} must be text!"
                                return 0
                            fi
                        fi
                    
                    fi
                } 
                
                if [ $j -gt $# ]
                then
                    echo "Error: Not a valid AGO sql syntax, field "${tableMetaArray[i]}" was NOT supplied!"
                    return 0
                fi

                done 
                oldRecord=$(awk -F: -v pk=$PKVal '{if(pk==$2) print $0}' ./DBs/$DBName/$tableName)
                record=$(printf "%s:" ${fieldsArray[@]})
                recordNum=$(awk -v target=$oldRecord '{if(target==$0) print NR}' ./DBs/$DBName/$tableName)

                sed -i "${recordNum}s/.*/$record/" ./DBs/$DBName/$tableName
                echo "Recored updated successfully!"

            else    
                echo 'Error: Not a valid AGO sql syntax, no. of parameters entered is not matching no. of table fields!'
            fi 
                
            else
                echo "Sorry, primary key value $PKVal supplied does not exist in table!"
            fi
        else 
            echo "Sorry, primary key $PKName supplied is not matching the table primary key field!"
        fi
    else
        echo "Sorry, there's no table with $tableName in $DBName DB!"
    fi  
    
}
updateRecord $@