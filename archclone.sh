#!/bin/bash

repo=$(pacman --color=never -Ss ^"$1"$ | grep -v testing | grep ".*/$1 " | cut -d'/' -f1)

case $repo in
    core | extra) repo="packages";;
    community) ;;
    *) echo Error: Exact match "$1" not found && exit 1 ;;
esac

git clone --branch packages/"$1" --single-branch https://github.com/archlinux/svntogit-"$repo"
mv svntogit-"$repo"/trunk "$1" && rm -rf svntogit-"$repo"
