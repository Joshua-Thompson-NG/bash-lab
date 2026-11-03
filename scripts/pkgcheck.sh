#!/usr/bin/env bash


PKG_NAME="$1"

if [[ -z "$PKG_NAME" ]]; then
    echo "Error: Please provide a package name."
    echo "Usage: $0 <package_name>"
    exit 1
fi

# Check if pkg is already installed
if dpkg -s "$PKG_NAME" &> /dev/null; then
        echo "Package already installed"
        exit 0
else
        echo "Package is missing"
        read -r -p "Would you like to install '$PKG_NAME' now? (y/n)" CHOICE
	case "$CHOICE" in 
		yes|y|Y|YES)
			echo "Installing '$PKG_NAME'..."
			sudo apt update && sudo apt install -y "$PKG_NAME"
			;;
		n|N|no|NO|"")
			echo "Skipping installation..."
			exit 0
			;;
		*)
			echo "Invalid Choice.."
			exit 1
			;;
	esac
fi
				 
