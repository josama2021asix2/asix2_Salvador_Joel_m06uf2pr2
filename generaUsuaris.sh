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
vinic=$((vinic-1))

if [[ -e nousUsuaris.ldif ]]
then
    rm nousUsuaris.ldif
fi

NumUsr=$vinic
for (( i=1; i<=$qt; i++))
do
	vinic=$((vinic+i))
	idUsr=usr$NumUsr

	echo "dn: uid=$idUsr,cn=UsuarisDomini,ou=UsuarisGrups,dc=fjeclot,dc=net" >> nousUsuaris.ldif
	echo "objectClass: top"  >> nousUsuaris.ldif
	echo "objectClass: person" >> nousUsuaris.ldif
	echo "objectClass: organizationalPerson" >> nousUsuaris.ldif
	echo "objectClass: inetOrgPerson" >> nousUsuaris.ldif
	echo "objectClass: posixAccount" >> nousUsuaris.ldif
	echo "objectClass: shadowAccount" >> nousUsuaris.ldif
	echo "cn: " $idUsr >> nousUsuaris.ldif
	echo "sn: " $idUsr >> nousUsuaris.ldif
	echo "uidNumber: " $NumUsr >> nousUsuaris.ldif
	echo "gidNumber: 101" >> nousUsuaris.ldif
	echo "homeDirectory: /home/$idUsr" >> nousUsuaris.ldif
	echo "loginShell: /bin/bash" >> nousUsuaris.ldif
	echo "" >> nousUsuaris.ldif
	((NumUsr++))

done
ldapadd -h localhost -x -D "cn=admin,dc=fjeclot,dc=net" -W -f nousUsuaris.ldif

echo "s'ha creat amb exit!"
exit 0
