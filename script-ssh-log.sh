#!/bin/bash
#

logfile="/var/log/sshscript.log"
ctrl=0
while [ $ctrl -eq 0 ]
do
#
clear
if [ $(id -u) -ne 0 ]; then
	echo "Privilégios insuficientes!"

else
	if [ ! -e $logfile ]; then touch $logfile; fi
	echo -e "... SSH LOG....\n"
	echo "
	Opcoes:
	1. Verificar Status do Servico SSH
	2. Inverter o estado do servico SSH
	3. Verificar Logs SSH
	*. Sair"
	read -p "----> " opt
#
	case $opt in
	1) systemctl status ssh | grep -o "running" > /dev/null
		if [ $? -eq 0]; then
			echo "Serico em EXECUCAO" ; sleep 2
		else
			echo "Servico Parado" ; sleep 2
		fi
		;;

	2) systemctl status ssh | grep -o "running" > /dev/null
                if [ $? -eq 0 ]; then
                        systemctl stop ssh
			echo "$(date) ... servico parado" >> $logfile
			echo "Servico Parado" ; sleep 2
                else
			systemctl start ssh
			echo "$(date) ... servico inicializado" >> $logfile
                        echo "Servico Iniciado" ; sleep 2
                fi
		;;

		3) echo -e  "Log File \n" ; cat $logfile
		;;
		
		*) clear
			echo "Fim! " ; break
	esac
#
fi
done

