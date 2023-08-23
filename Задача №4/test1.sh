#!/usr/bin/env bash
hosts=(192.168.0.251 173.194.222.113 87.250.250.242)
while :
do

for h in ${hosts[@]}
do
  curl -s --connect-timeout 2 http://$h:80 > /dev/null

    if (($? != 0))
    then
      echo $(date +"%H:%M %D") $$ Error $h недоступен по порту 80  >> error
      exit
    else
      echo "все IP доступны"
    fi
 done
done
