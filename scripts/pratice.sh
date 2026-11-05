#!/usr/bin/env bash

greet_user() {
	local name="$1"
	local role="$2"
	echo "Name: $name, Role:$role"
}

greet_user "Thompson" "Cloud Enginner"

