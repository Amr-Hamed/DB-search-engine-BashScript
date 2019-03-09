#!/bin/bash

function createTable(){
    i=3
while [ $i -le $# ]
do
    echo ${!i}
    let i=$i+1
done

}

createTable $@