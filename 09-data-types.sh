#!/bin/bash

#everything in shell is consider as string
NUMBER1=100
NUMBER2=200
NAME=Devops

SUM=$(($NUMBER1+$NUMBER2+$NAME))

echo "SUM is: ${SUM}"

LEADERS=("Modi" "Putin" "Trump")

echo "All leaders: ${LEADERS}[@]