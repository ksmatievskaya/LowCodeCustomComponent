#!/bin/bash

while getopts e: flag
do
    case "${flag}" in
        e) environ=${OPTARG};;
    esac
done

for f in $(find ./settings/examples -name '*.example.*'); do
    IFS=
    basefile=$(basename ${f})
    IFS="."
    read -a filearray <<< $basefile
    newfilesettings=".${filearray[1]}.${environ}.${filearray[3]}"
    IFS=
    echo "${f} copied to ${newfilesettings}";
    cp -n $f ./settings/${newfilesettings}
done

cp -n .env.example.settings .env.settings
