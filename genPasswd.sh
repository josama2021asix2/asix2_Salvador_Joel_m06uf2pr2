#!/bin/bash
clear
#JOEL SALVADOR MARCOS

echo -n "Indica la quantitat d'usuaris [1-100]: "
read qt
if [[ $qt -lt 1 ]] || [[ $qt -gt 100 ]]
then
	echo "Valor incorrecte. Ha d'estar entre 1 i 100"
	exit 1
fi
echo -n "Indica el valor inicial de l'uidNumber: "
read vinic

echo -n "Introdueix la contrasenya admin del ldap: "  
read -s ctsAdm
echo

if [[ -e ctsUsuaris.txt ]]
then
    rm ctsUsuaris.txt
fi

NumUsr=$vinic
for (( i=1; i<=$qt; i++))

do
    idUsr=usr$NumUsr
    ctsnya_usr=$(pwgen 10 1)
    uo="UsuarisGrups"
    grp="UsuarisDomini"

    echo "$idUsr ------ $ctsnya_usr" >> ctsUsuaris.txt
    echo "objectClass: top"  >> ctsUsuaris.txt
	echo "objectClass: person" >> ctsUsuaris.txt
	echo "objectClass: organizationalPerson" >> ctsUsuaris.txt
	echo "objectClass: inetOrgPerson" >> ctsUsuaris.txt
	echo "objectClass: posixAccount" >> ctsUsuaris.txt
	echo "objectClass: shadowAccount" >> ctsUsuaris.txt
    echo "objectClass: userPassword" >> ctsUsuaris.txt
    ldappasswd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -w $ctsAdm -s "$ctsnya_usr" "uid=$idUsr,cn=$grp,ou=$uo,dc=fjeclot,dc=net"
    ((NumUsr++))
done

echo "Done!"
exit 0
