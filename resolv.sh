#!/bin/bash
#JOEL SALVADOR MARCOS

if [ $EUID -ne 0 ]
then
	echo "This script must be run as root"
	exit 1
fi

echo "En quina carpeta vols crear guardar la copia del fitxer resolv.conf?"
echo -n "Nom de la Carpeta: "
read Nom_Carpeta

if [[ ! -d /root/$Nom_Carpeta ]]
then
	echo "La carpeta escollida no existeix. ¿Voleu crear-la?"
	echo -n "Resposta (Si o No): "
	read Resposta
	case "$Resposta" in
		'Si')
			mkdir /root/"$Nom_Carpeta"
			date=`date +20%y%m%d%H%M`
			cp /etc/resolv.conf /root/"$Nom_Carpeta"/resolv.conf.backup."$date"
			gzip -9 /root/"$Nom_Carpeta"/resolv.conf.backup."$date"
			#rm /root/"$Nom_Carpeta"/resolv.conf.backup."$date"
			;;
		'No')
			echo "D'acord. El programa deixa d'executar-se."
			echo "Que tingui un bon dia"
			exit 1
			;;
		*)
			echo "COMANDA NO ACCEPTADA".
			echo "Les opcions han de les anteriorment mencionades, i han de estar escrites de la mateixa forma."
			echo "Tancant Programa"
			exit 2
			;;
	esac
else
	date=`date +20%y%m%d%H%M`
	cp /etc/resolv.conf /root/"$Nom_Carpeta"/resolv.conf.backup."$date"
	gzip -9 /root/"$Nom_Carpeta"/resolv.conf.backup."$date"
	#rm /root/"$Nom_Carpeta"/resolv.conf.backup."$date"
fi
exit 0
