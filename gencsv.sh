#!/bin/bash
for ((i=$1;i<$2;i++))
do
    echo "$i, $((RANDOM%100))"
done > inputFile