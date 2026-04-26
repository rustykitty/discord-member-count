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
errlog="$LOGDIR/log_$time.log"
errlog="$(nodupe "$errlog")"
stdoutlog="$LOGDIR/log_$time.log"
stdoutlog="$(nodupe "$stdoutlog")"

exec 2> >(tee "$errlog") 1> >(tee "$stdoutlog")

echo "Current time is $time"

mkdir -p log

uv run retrieve.py