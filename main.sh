#!/bin/bash

#uname1=test1
#uname2=test2
#upwd=test147
#db1=testdb1
#db2=testdb2
#rpwd=test852

#install or update required softfare
sudo apt update
sudo apt install -y mariadb-server mariadb-client docker docker-compose

#add way of working directory to variables file
echo "udir=$(pwd)" >> ./variables.env
sourse ./variables.env

#create mysql directory
#if ls ./mysql/ &> /dev/null; then
#   echo "MYSQL DIRECTORY HAS ALREADY CREATED"
#   echo $PWD
#else mkdir mysql
#   echo "MYSQL DIRECTORY HAS BEEN CREATED"
#   echo $PWD
#fi

#set root password for DB
sudo mysql -e "SET PASSWORD FOR root@localhost = PASSWORD '${rpwd}';FLUSH PRIVILEGES;"
printf "$rpwd'\n n\n n\n n\n y\n y\n y\n" | sudo mysql_secure_installation

#add DB for site1
sudo mysql -uroot -p$rpwd -e "CREATE DATABASE ${db1} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
sudo mysql -uroot -p$rpwd -e "CREATE USER ${uname1} IDENTIFIED BY '${upwd}';"
sudo mysql -uroot -p$rpwd -e "GRANT ALL PRIVILEGES ON ${db1}.* TO '${uname1}';"
sudo mysql -uroot -p$rpwd -e "FLUSH PRIVILEGES;"
echo -e "\n\n\033[32m Database for site1 has succesful created\033[0m\n"

#add DB for site2
sudo mysql -uroot -p$rpwd -e "CREATE DATABASE ${db2} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
sudo mysql -uroot -p$rpwd -e "CREATE USER ${uname2} IDENTIFIED BY '${upwd}';"
sudo mysql -uroot -p$rpwd -e "GRANT ALL PRIVILEGES ON ${db2}.* TO '${uname2}';"
sudo mysql -uroot -p$rpwd -e "FLUSH PRIVILEGES;"
echo -e "\n\n\033[32m Database for site2 has succesful created\033[0m\n"

#revome old containers if required
#if docker stop $(docker ps -aq)&> /dev/null; then
#   docker rm $(docker ps -aq)
#   echo "CONTAINERS REMOVED"
#else echo "NO CONTAINERS"
#fi

#start docker-compose
#docker-compose up -d
