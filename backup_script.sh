#!/bin/bash
# Script for backup

# Color for output
WHITE="\e[0m"
GREEN="\e[32m"

#Greeting
figure(){
echo -e "$GREEN\
        ***********************
        -----------------------
        |       BACKUP       |
        |       SCRIPT       |
        |                    |
        -----------------------
        ***********************
"
}


# Name with backup date
date=$(date +"%Y-%m-%d_%H-%M-%S")
backup_archive="backup_$date.tar.gz"


figure
# Checking the existence of a directory
while true; do
echo -e "$GREEN ---- Write the source directory for the backup ---- $WHITE"
read source_dir
        if [ -d $source_dir ]; then
         echo "Ok!"
         break
        else
         echo "There is no such directory. Try again!"
        fi
done


# Checking the backup storage directory
while true; do
echo -e "$GREEN ---- Write the directory where the backup will be ---- $WHITE"
read backup_dir
	if [ -d $backup_dir ]; then
	 echo "Ok!"
	 break
	else
	 echo "There is no such directory. Try again!"
	fi
done

# Creating a backup
tar -czf "$backup_dir/$backup_archive" -C "$source_dir" .
echo -e "$GREEN >>>> Backup has been created!"

