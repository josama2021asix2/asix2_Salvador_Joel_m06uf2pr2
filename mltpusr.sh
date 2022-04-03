#!/bin/bash
#JOEL SALVADOR MARCOS

if ! command -v pwgen &> /dev/null
then
    echo "PWGEN no instalat, s'instalara amb aquest srcript"
    sudo apt update && sudo apt upgrade
    sudo apt-get install pwgen
    echo "PWGEN instalat correctament"
fi

echo "Numero d'usuaris a crear:"
read num
if   (( $num <= 30 ))&&(( $num >= 1 ))
then
    echo "Es un valor valid"
else
    echo "Nombre incorrecte d'usuaris"
    exit 1
fi

echo "Nom base per els usuaris:"
read nomb_base
echo "UID base per els usuaris:"
read uid_base

x=$num
uid=$uid_base
clot=".clot"



archivo="/root/${nomb_base}.txt"
if [[ -e $archivo ]]
then
	rm $archivo
	echo "borrar archivo"
fi



until (( $x <= 0 ))
do
	nom_fi="$nomb_base$x"
	nom_fi="${nom_fi}.clot"
	
    echo $x
    echo $nom_fi
    
    password=$(pwgen 10 1)
    home="/home/${nom_fi}"
    useradd  $nom_fi  -u  $uid  -g  users  -d  $home  -m  -s  /bin/bash  -p  $(pwgen 10 1) || echo "Error amb l'usuari" exit 2
    echo "${nom_fi} ; ${password}" >> $archivo
    uid=$(( ++uid ))
    x=$(( --x ))
done

exit 0
