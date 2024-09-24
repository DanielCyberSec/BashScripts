#!/bin/bash
#https://github.com/DanielCyberSec/BashScripts.git
rojoNegrita="\e[1;31m"
verde="\e[32m"
azul="\e[1;34m"
sinColor="\e[0m"
amNeg="\e[1;33m"
echo -e "${amNeg}######################################"
echo -e "##           DanielCyberSec         ##"
echo -e "######################################"
echo -e "nota: ejecutar al nivel de los repositorios git (apoyate del comando pwd)"
echo -e "se recomienda tener activado el agente ssh para la ejecución de este script, posteriormente puede volver a deshabilitarlo."
echo -e "comando para activarlo: https://github.com/DanielCyberSec/Protocols/blob/main/ssh/activateSSHagent.txt$sinColor"
echo "Este es tu directorio actual: $(pwd)" 
read -p "Ingresa el directorio base: " base_dir
# Recorre todos los directorios en el directorio base
for dir in "$base_dir"/*; do
	if [ -d "$dir/.git" ]; then
        	echo -e "\nEntrando en el directorio: $azul$dir$sinColor"
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
