#! /bin/bash
##### CONTROL DE ERRORES #####
if [[ -z $1 || -z $2 || $# > 2 ]] #esto solo verifica si un string es vacío no si este existe, 
				  #pero a menos que se pongan de trolls, sirve, también mata dos de un tiro verificando la cantidad de argumentos
then
	>&1 echo "USO: [archivo_lista] [Nombre]"
	exit
fi

if [ -f $1 ]
then
	>&1 echo "El archivo referenciado existe" #imprime mensaje en stdout
else
	>&2 echo "El archivo referenciado no existe" #imprime error en stderr
	exit
fi

if [[ $2 =~ ^[A-Z]([a-z])+$ ]] #expresión de regex para ver si el string comienza con mayúscula
then
	>&1 echo "El nombre comienza con MAYÚSCULA"
else
	>&2 echo "El nombre no comienza exclusivamente con sólo un carácter de MAYÚSCULA"
	exit
fi

##### BUSCAR NOMBRE #####
if  [[ "$(grep "\b$2\b" $1)" ]] #si grep no retorna nada la expresión condicional retorna algo que no es true, por lo que eso basta para que se vaya al else. 
then				#\b es para decile a grep que sea estricto con la palabra, ej, solo Alice y no Alice y Alicea. Digamos que es un abuso pero sirve
				#se acuerdan de lo que les dije de que pueden usar el output de un comando directamente usando algo como $(cat archivito) ?
	>&1 echo "El nombre $2 está en la lista"
else
	>&2 echo "El nombre $2 no está en la lista. El incidente será reportado."
fi

echo "Presione cualquier botón para finalizar y limpiar la consola"

read -n 1 -s #espera una entrada para finalizar
clear

#pude haber usado elif en vez de varios if pero medio pereza
