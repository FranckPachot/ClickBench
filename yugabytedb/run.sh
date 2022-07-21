#!/bin/bash

set | grep ^PG

TRIES=3

cat queries.sql | while read query; do
    echo "$query";
    for i in $(seq 1 $TRIES); do
        psql -t -c 'set work_mem=2147483647' -c 'set yb_enable_expression_pushdown=on' -c '\timing' -c "$query" | grep 'Time'
    done;
done;
