#!/usr/bin/env bash


echo "Starting system maintenance..."

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

if [ $? -eq 0  ]; then
	echo "System maintenance successful..."
else
	echo "System maintenance failed, something went wrong..."
fi
