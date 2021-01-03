#!/bin/bash

#find ./ -type f -size -70c -printf "\n%p>" -exec cat {} \; > ./smallfiles.txt
inputFile="./smallfiles.txt"

while IFS="" read -r p || [ -n "$p" ]
do
  printf '%s\n' "$p"
  
  line=$p
  orgfile=$(echo $line | grep -Po "(?<=\>)\K(.+)")
  symfile=$(echo $line | grep -Po "\K(.+)(?=\>)")
  folder="$(dirname "${symfile}")"
  srcfile="$folder/$orgfile"
  
  echo "$srcfile > $symfile"
  cp $srcfile $symfile
  
done < $inputFile
