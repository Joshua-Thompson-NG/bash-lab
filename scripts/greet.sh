#!/usr/bin/env bash
name="$1"
host_name=$(hostname)
date=$(date +%F)
echo "Hello $name, welcome to my VM $host_name"
echo "Today is $date"
exit 0
