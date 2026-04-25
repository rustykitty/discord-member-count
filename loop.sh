#!/usr/bin/env bash

## Because cron isn't working for some reason

cd "$(dirname "$0")"

while true
do
    ./run.sh
    sleep 300 # 5 minutes
done