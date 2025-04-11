#!/bin/bash

read -p "enter the source dir " sordir 
backdir="/home/tuhin/90days/day9/backup"

ts=$(date +"%y-%m-%d_%H-%M-%S")
bacfil="${backdir}/backup_${ts}.tar.gz"

tar -czf "$bacfil"  "$sordir"
echo "Backup created"
 
backup_list=$(ls -t "$backdir"/backup_*.tar.gz)
backup_count=$(echo "$backup_list" | wc -l)

# Check if backups exceed 3
if [ "$backup_count" -gt 3 ]; then
    # Get backups to delete (4th and older)
    backups_to_delete=$(echo "$backup_list" | tail -n +4)
    
    # Delete extra backups
    echo "$backups_to_delete" | xargs rm -f
    echo "🗑️ Deleted old backups, only last 3 retained!"
fi

