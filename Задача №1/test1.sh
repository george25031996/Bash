#!/bin/bash
mkdir /opt/test/
cd /opt/test/
touch info_1.txt info_2.txt info_3.txt
echo "тест_1" > /opt/test/info_1.txt  
echo "тест_1" >/opt/test/info_2.txt
echo "тест_1" > /opt/test/info_3.txt

tean="тест_1"
tean_dir="/opt/test/*"
finish_dir="/opt/test_copy"

for host in b3-iws-2 b3-serv-m b3-serv-oto; do
    echo "копирую файл в $host..."
    ssh $host "mkdir -p $finish_dir"
    scp $(find $tean_dir -type f -exec grep -l $tean {} \;) $host:$finish_dir
done
