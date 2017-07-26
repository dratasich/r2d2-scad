#!/bin/bash

# variables
archive="CSR - CAD.zip"

# extract archive from astromech.net to ./tmp/
mkdir -p tmp
unzip "$archive" -d tmp

# extract all inner archives
unzip "tmp/*.zip" -d tmp
rm tmp/*.zip

# convert each .igs file
files=$(ls -1 tmp/*.igs)
saveifs=$IFS
IFS=$(echo -en "\n\b")
for f in $files; do
    oname=$(echo "$f" | sed -e "s/.igs$/.stl/g")
    ./convert.py "$f" "$oname"
done
IFS=$saveifs
