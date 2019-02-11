#!/bin/bash

TARGETS=$1;
FLAG=$2;

if [ -z $TARGETS ]; then
	echo "usage: $0 <targets in ciDR> [options]"
	echo "            -c common only"
	echo "            -s smb only"
	exit;
fi

if [ "$FLAG" != "-c" ]; then
	# target SMB
	echo -e "\e[42m******* smb for $TARGETS *******                    \e[49m"
	nmap -vvv $TARGETS -p445 -sS -sV -O -oG lab-smb.txt --open -T4 
	cat lab-smb.txt | grep open | cut -d" " -f2 > lab-smb-open.txt

    # find vulnerable SMB 
    mkdir smb-open
    split -l3 lab-smb-open.txt
    mv x* smb-open/.
    cd smb-open

    for file in $(ls); do
	    echo -e "\e[43m******* vulnscanning smb for $TARGETS *******                    \e[49m"
	    ../smb-vul-scan.sh $file & > $file-scan.txt
    done

    cd ..
fi

if [ "$FLAG" != "-s" ]; then 
	echo -e "\e[42m******* common ports for $TARGETS *******                    \e[49m"
	# target common TCP 
	nmap -vvv $TARGETS -p20,21,22,23,25,80,110,113,123,135,137,139,142,161,443,500,1089,1433,1434,1443,3306,8080,8888,2222,4444,5432,5500,6129,10000 -sS -sV -O -oG lab-common.txt --open -T4 
	cat lab-common.txt | cut -d" " -f2|sort -u > lab-open.txt
	cat lab-common.txt | grep -oh -e 'tcp/[a-z]*/[a-z]*' | sort -u | cut -d/ -f3> lab-tcp-ports.txt

	PROTOCOLS=$(cat lab-tcp-ports.txt)

	for protocol in $PROTOCOLS; do
		cat lab-common.txt | grep $protocol | cut -d" " -f2 > lab-$protocol-open.txt
	done
fi

