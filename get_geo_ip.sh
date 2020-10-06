#!/bin/bash

WKFILE=$(read a < /dev/urandom; echo $a$a | md5 | cut -c1-5).wk

curl 'https://www.ultratools.com/tools/geoIpResult' \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Origin: https://www.ultratools.com' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://www.ultratools.com/tools/geoIpResult' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cookie: cp_ga_li=LO; JSESSIONID=node01l592cu5l2mro5xs1bdqdu3ey16555713' \
  -H 'dnt: 1' \
  --data-raw "ipAddress=$1" \
  --compressed > $WKFILE  2> /dev/null

COUNTRY=$(grep Country: --context=2 $WKFILE | grep value | cut -d">" -f2 | cut -d"<" -f1) 
STATE=$(grep State: --context=2 $WKFILE | grep value | cut -d">" -f2 | cut -d"<" -f1) 
CITY=$(grep City: --context=2 $WKFILE | grep value | cut -d">" -f2 | cut -d"<" -f1) 

echo $COUNTRY,$STATE,$CITY
