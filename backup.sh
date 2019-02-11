#!/bin/bash

BACKUP=/mnt/hgfs/shared/backup$(date +%m%d%y); 
mkdir $BACKUP; 
rsync -r * $BACKUP/.
