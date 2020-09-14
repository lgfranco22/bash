#!/bin/bash
clear
if [ "$1" == "" ]
then
echo -e " \033[1;35m#######################################\033[0m"
echo -e " \033[5;32m Buscando Hosts\033[0m"
echo -e " \033[0;32m Desec Security - Luiz Gonzaga Franco\033[0m"
echo -e " \033[0;32m $0 www.alvo.com.br\033[0m"
echo -e " \033[1;35m#######################################\033[0m"
else
echo -e "\033[1;35m#####################################\033[0m"
echo -e "\033[5;32mBuscando Hosts....\033[0m"
echo -e "\033[1;35m#####################################\033[0m "
wget -q "$1"
cat index.html | grep "<a" | grep "href" | grep "http" | cut -d '"' -f2 | grep "http" | cut -d "/" -f3 | grep -v ":" > lista
# "old" grep href index.html | cut -d "/" -f3 | grep "\." | cut -d '"' -f1 | sort -u | grep -v "return"  | grep -v "<a" | grep -v "<li" | grep -v "#" | grep ".gif" > lista
cat lista
echo -e "\033[1;35m#####################################\033[0m"
echo -e "\033[5;32mResolvendo Hosts....\033[0m"
echo -e "\033[1;35m#####################################\033[0m"
for url in $(cat lista);do host $url;done | grep "has address"
rm lista
rm index.html
fi
