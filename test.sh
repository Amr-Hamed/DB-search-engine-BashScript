#!/bin/bash

function updateRecord(){
PKVal=11
recordNum=3
record="id:11:name:gomaa:address:menouf:"
nr=$(awk '/id:12:name:amr:address:fayoum/{ print NR; exit }' ./DBs/myDB/table)
oldRecord=$(awk -F: -v pk=$PKVal '{if(pk==$2) print $0}' ./DBs/myDB/table)
sed -i "${recordNum}s/.*/$record/" ./DBs/myDB/table
#  echo $oldRecord
}
updateRecord $@