#!/bin/bash
#https://github.com/DanielCyberSec/BashScripts.git
rojoNegrita="\e[1;31m"
verde="\e[32m"
sinColor="\e[0m"
amNeg="\e[1;33m"
echo -e "${amNeg}######################################"
echo -e "##           DanielCyberSec         ##"
echo -e "######################################"
echo -e "nota: ejecutar al nivel de los directorios clonados $sinColor"
# Cambia a tu directorio de trabajo donde deseas buscar repositorios Git
base_dir="/home/daniel/Documentos/"
# Recorre todos los directorios en el directorio base
for dir in "$base_dir"/*; do
	if [ -d "$dir/.git" ]; then
        	echo "Entrando en el directorio: $dir"
       		cd "$dir" || exit
        	# Aquí puedes realizar operaciones dentro del repositorio Git
	        # Por ejemplo, hacer un git status
		echo -e "$verde git fetch: $sinColor"
		git fetch
		echo -e "$verde git status: $sinColor"
		git status
       		# Regresa al directorio base
        	cd "$base_dir"
	fi
done
: << 'FIN'
elif [$respuesta == "no" ] 2>/dev/null; then
	# Recorre todos los directorios en el directorio base
        for dir in "$base_dir"/*; do
		if [ -d "$dir/.git" ]; then
                	echo "Entrando en el directorio: $dir"
	                cd "$dir" || exit
       		        # Aquí puedes realizar operaciones dentro del repositorio Git
               		# Por ejemplo, hacer un git status
                	echo -e "$verde git fetch: $sinColor"
        	        git fetch
       	        	echo -e "$verde git status: $sinColor"
        	        git status
       	        	# Regresa al directorio base
                	cd "$base_dir"
		fi
       	done
else
       	echo "Respuesta no válida. Por favor, ingresa 'si' o 'no'."
fi
FIN
