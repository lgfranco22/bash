#!/bin/bash
# Script para conexao de rede wifi (SOMENTE PARA REDE (FRANCOS_AP40))
# Autor..: Luiz Gonzaga Franco Michelmann
# Versao.: 1.4
# Data de criação: 22/06/2019
# Anexo do arquivo wifi.conf
echo "##############################"
echo "# Inet Automatic v1.4        #"
echo "# Franco's Informática       #"
echo "# -------------------------- #"
echo "# fb.com/francosinformatica  #"
echo "# Contact:19997119811        #"
echo "##############################"
echo -e "Iniciando as configurações"
ifconfig wlan0 up
ping -c2 -w1 127.0.0.1 > nul
wpa_supplicant -Dwext -i wlan0 -c /root/wifi-conecta/wifi_cel.conf -B > nul
echo "Atribuindo endereço via dhcp"
ping -c2 -w1 127.0.0.1 > nul
dhclient -r > nul
echo "Finalizando as configurações"
dhclient wlan0 > nul
netrede=$(ping -c1 -w1 192.168.45.1 | grep "64 bytes" | cut -d " " -f1)
net=$(ping -c1 -w1 8.8.8.8 | grep "64 bytes" | cut -d " " -f1)
ip=$(ifconfig wlan0 | grep "broadcast" | cut -d " " -f10)

if [ $netrede == "64" ]
then
echo -e "\nConexao estabelhecida com a rede!"
echo -e "Endereço IP Local:$ip"
echo -e "Verificando conexão com a internet..."
if [ $net == "64" ]
then
echo -e "\nConexão realizada com sucesso"
else
echo -e "\nConexão com a internet falhou"
exit
fi
else
echo -e "\nConexao Falhou"
fi
