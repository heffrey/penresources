#!/bin/bash

PROTOCOLS=$(cat lab-tcp-ports.txt)
 
for protocol in $PROTOCOLS; do
	cat lab-common.txt | grep $protocol | cut -d" " -f2,4 > lab-$protocol-open.txt
done
