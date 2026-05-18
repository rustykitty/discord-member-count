#!/usr/bin/env bash

set -e

# https://stackoverflow.com/a/49671326
function nodupe() {
    if [[ -e "$1" ]]
    then
        echo "$(printf "%s\n" "${1}"* | wc -l)"
    else
        echo "$1"
    fi
}

cd "$(dirname "$0")"

LOGDIR="./log"

time=$(date +"%Y-%m-%d_%H:%M:%S")
errlog="$LOGDIR/errlog_$time.log"
errlog="$(nodupe "$errlog")"

exec 2>> >(tee "$errlog") 1> /dev/null

mkdir -p log

uv run retrieve.py
