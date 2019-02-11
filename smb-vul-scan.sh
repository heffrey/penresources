#!/bin/bash

HOSTS=$1
FLAG=$2 

echo $HOSTS
echo $FLAG
if [ -z $HOSTS ]; then 
	echo "usage:$0 <hostfile> [options]";
	echo "      -Ur user search and RID cycling";
	echo "      -n use nmap enumeration scripts";
	echo "      -U user search"; 
	exit;
fi

for host in $(cat $HOSTS); do 
	echo -e "\e[42m******* $host *******                    \e[49m"
	if [ "$FLAG" == "-Ur" ]; then
		enum4linux $host -U -r -R500-550
	elif [ "$FLAG" == "-n" ]; then
		for enumscan in $(ls /usr/share/nmap/scripts/smb-enum* | cut -d"/" -f6); do
			echo -e "\e[104m - $enumscan              \e[49m"
			nmap $host -p445 --script $enumscan 
		done
		nmap $host -p445 --script smb-enum-users.nse
	elif [ "$FLAG" == "-U" ]; then
		echo -e "\e[104m - smb-enum-users          \e[49m"
		nmap $host -p445 --script smb-enum-users.nse
	#	enum4linux $host -U -v
	else
		enum4linux $host -a -v
		for vulnscan in $(ls /usr/share/nmap/scripts/smb-vuln* | cut -d"/" -f6); do
			echo -e "\e[104m - $vulnscan              \e[49m"
			nmap $host -p445 --script $vulnscan 
		done
	fi
done

