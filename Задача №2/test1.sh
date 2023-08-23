#!/usr/bin/env bash
while ((1==1))
do
  curl https://localhost:4757
    if (($? != 0))
    then
            date >> curl.log
            sleep 30
    fi
done
