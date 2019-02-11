#!/bin/bash

DOMAIN=$1

if [ -z $DOMAIN ]; then
	echo "usage: zone.sh <domainname>"
	exit
fi

echo "Attempting zone transfers for $DOMAIN"

NS=$(host -t ns $DOMAIN | cut -d" " -f4) 

for server in $NS; do
	echo $server
	host -l $DOMAIN $server
done
