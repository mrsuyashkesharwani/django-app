#!/bin/bash
<< readme

testing my linux if i can write it or not

readme

function usage_display {
	echo "Usage: Either the source path is missing or the destination path is missing"
}

if [ $# -eq 0 ]; then
	usage_display
fi

source_dir=$1
backup_dir=$2
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

function create_backup {
	zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null
	echo "Backup generated successfully"
}

function perform_rotation {
	backups=($(ls -t "${backup_dir}/backup_"*.zip))
	echo "${backups[@]}"

	if [ "${#backups[@]}" -gt 5 ]; then
		backup_to_remove=("${backups[@]:5}")
	fi

	for backup in "${backup_to_remove[@]}";
	do
		rm -f ${backup}
	done
}

create_backup
perform_rotation

