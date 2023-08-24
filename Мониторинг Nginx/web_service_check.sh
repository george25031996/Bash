#!/bin/bash

# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m'


# Цветом текста (жирным) (bold) :
WHITE='\033[1;37m'

# Цвет фона
BGRED='\033[41m'
BGGREEN='\033[42m'
BGBLUE='\033[44m'

# Получаем статус веб-сервера systemd  записываем его в переменную.

nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed")

           if [[ $nginxstatus = 'running' ]]
              then
                 echo -en "${WHITE} ${BGGREEN} Веб сервер работает ${NORMAL}\n"
              else
                 echo -en "${WHITE} ${BGRED} nginx не работает ${NORMAL}\n"
                 systemctl restart nginx # Перезапуск nginx
                 sleep 1 # Ожидаем 1 секунду, чтобы сервер точно запустился.
                 echo -en "${WHITE} ${BGGREEN} Статус Nginx после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed")${NORMAL}\n"
                 echo $(curl -I | grep OK) # Проверяем отдаёт ли веб-сервер http код 200
           fi

phpfpmstatus=$(systemctl status php8.1-fpm.service | grep -Eo "running|dead|failed")

            if [[ $phpfpmstatus = 'running' ]]
               then
                  echo -en "${WHITE} ${BGGREEN} php8.1-fpm работает ${NORMAL}\n"
               else
                  echo -en "${WHITE} ${BGRED} Статус php8.1-fpm работает ${NORMAL}\n"
                  systemctl restart php8.1-fpm.service # Перезапускаем php8.1-fpm
                  sleep 1 # Ожидаем 1 секунду, чтобы php8.1-fpm точно запустился.
                  
                 echo -en "${WHITE} Статус php8.1-fpm после перезапуска $(systemctl status php8.1-fpm | grep -Eo "running|dead|failed") ${NORMAL}\n"
            fi

             
