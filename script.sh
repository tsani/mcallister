#!/bin/bash

PIN=/sys/class/gpio/gpio4/value

while true ; do
    val=$(cat $PIN)
    echo $val
    sleep 2
done
