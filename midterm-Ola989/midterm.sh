#!/bin/bash


# midterm challenge

ACTION=${1}

VERSION=1.0

function system_update() {
			sudo yum update -y
			echo -e "\completed!"
}

function save_metadata() {
			touch metadata.txt
			curl -w "\n" http://169.254.169.254/latest/meta-data/ami-id > metadata.txt
			curl -w "\n" http://169.254.169.254/latest/meta-data/instance-id >> metadata.txt
			curl -w "\n" http://169.254.169.254/latest/meta-data/hostname >> metadata.txt
			curl -w "\n" http://169.254.169.254/latest/meta-data/security-groups >> metadata.txt
			curl -w "\n" http://169.254.169.254/latest/meta-data/public-hostname >> metadata.txt
}

function show_version() {
echo "$VERSION"
}


if [ -z "$1" ]; then
		system_update
else
case "$ACTION" in
	-v|--version)
		show_version
		;;
	-m|--metadata)
		save_metadata
		;;
	*)
	echo "Usage ${0} {-v|--version|-m|--metadata}"
	exit 1
esac
fi
