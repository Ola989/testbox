#!/bin/bash


# midterm challenge

ACTION=${1}

VERSION=2.0

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


function show_config() {
	touch awscli.txt
	aws ec2 describe-instances --filters Name=instance.group-name,Values=midterm > awscli.txt
	aws ec2 describe-security-groups --filters Name=group-name,Values=midterm >> awscli.txt
}


function create_backup() {
		ls ./*.txt
		for file in ./*.txt;
do cp "$file" "$file".bak;
done
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
	-a|--aws)
		show_config
		;;
	-b|--backup)
		create_backup
		;;
	*)
	echo "Usage ${0} {-b|--backup|-v|--version|-m|--metadata}"
	exit 1
esac
fi
