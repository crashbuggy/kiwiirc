#!/bin/sh

if git status | grep -q 'modified:'; then
    echo "modified files detected, commit or stash and rerun"
    exit 1
fi 

DATE=`date +%y.%m.%d.1`

sed -i "s/ENV GITASOF .*/ENV GITASOF $DATE/" Dockerfile 
git stage Dockerfile
git commit -m bump
git tag gitasof-"$DATE"
git push
git push origin gitasof-"$DATE"

