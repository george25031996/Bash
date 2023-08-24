#!/bin/bash

tg="/root/telegram.sh"

# Получаем статус веб-сервера systemd  записываем его в переменную.

nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed")

           if [[ $nginxstatus = 'running' ]]
              then
                 echo "Веб сервер работает"
              else
                 $tg "Nginx не работает" > /dev/null
                 systemctl restart nginx # Перезапуск nginx
                 sleep 1 # Ожидаем 1 секунду, чтобы сервер точно запустился.
                 $tg "Статус Nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed") !!" > /dev/null
                 echo $(curl -I | grep OK) # Проверяем отдаёт ли веб-сервер http код 200
           fi

phpfpmstatus=$(systemctl status php8.1-fpm.service | grep -Eo "running|dead|failed")

            if [[ $phpfpmstatus = 'running' ]]
               then
                  echo "php8.1-fpm работает"
               else
                  $tg "Php8.1-fpm не работает" > /dev/null
                  $tg "Статус php8.1-fprm $phpfpmstatus   Пробуем перезапустить..." > /dev/null
                  systemctl restart php8.1-fpm.service # Перезапускаем php8.1-fpm
                  sleep 1 # Ожидаем 1 секунду, чтобы php8.1-fpm точно запустился.
                 
                 $tg "Статус php8.1-fpm после перезапуска $(systemctl status php8.1-fpm | grep -Eo "running|dead|failed") !!" > /dev/null
            fi

             
