#!/usr/bin/env bash

hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
for h in ${hosts[@]}
do
    for i in {1..5}
    do
       curl -s --connect-timeout 4 http://$h:80 > /dev/null
       if (($? !=0 ))
       then
        echo " Host $h не доступен по порту 80 " >> available.log
       else
        echo " Host $h доступен по порту 80" >> available.log
       fi
    done
done
