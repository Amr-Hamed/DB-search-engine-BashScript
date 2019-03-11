#!/bin/bash

function updateRecordEnhanced(){
    
    DBName=$1
    tableName=$2

    PKName=$3
    PKVal=$4
    
    noOfArgs=$(($#-2))
    fieldsArray=()
    intRegex='^[0-9]+$'
    textRegex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
    
    if [ -e ./DBs/$DBName/$tableName ]
    then 
    
        tableMeta=$(head -n 1 ./DBs/$DBName/$tableName)
        IFS=':' read -ra tableMetaArray <<< $tableMeta

        if [[ $noOfArgs -gt ${tableMetaArray[-1]} ]]
        then
            echo "Error: Not a valid AGO sql syntax, no. of parameters entered is not matching no. of table fields!"
            return 0
        fi

        if [ ${tableMetaArray[0]} == $PKName ]
        then
            if [[ $(awk -F: -v pk=$PKVal '{if(pk==$2&&NR>1) print $0}' ./DBs/$DBName/$tableName) ]] 
            then
                oldRecord=$(awk -F: -v pk=$PKVal '{if(pk==$2) print $0}' ./DBs/$DBName/$tableName)
                IFS=':' read -ra oldRecordArray <<< $oldRecord

                for ((i=0;i<${tableMetaArray[-1]};i+=2))
                do
                    
                    j=3
                    for ((;j<=$#;j++)) {
                        flag=$(case "${tableMetaArray[@]}" in  ("${!j} "*|*" ${!j} "*|*" ${!j}") echo "${!j}" ;; esac)
                        
                        if [[ $flag ]] 
                        then
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
                            
                            else
                                let j=$j+1    
                            
                            fi
                        else
                            echo "Error: field ${!j} doesn't exist in database"
                            return 0
                        fi
                          
                    } 
                    
                    if [ $j -gt $# ]
                    then
                        fieldsArray=("${fieldsArray[@]}" "${oldRecordArray[i]}" "${oldRecordArray[$((i+1))]}")
        
                    fi

                done 
                
                record=$(printf "%s:" ${fieldsArray[@]})
                recordNum=$(awk -v target=$oldRecord '{if(target==$0) print NR}' ./DBs/$DBName/$tableName)

                sed -i "${recordNum}s/.*/$record/" ./DBs/$DBName/$tableName
                echo "Recored updated successfully!"
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
updateRecordEnhanced $@