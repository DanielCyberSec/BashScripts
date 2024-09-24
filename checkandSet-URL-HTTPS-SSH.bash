#!/bin/bash
#https://github.com/DanielCyberSec/BashScripts.git
rojoNegrita="\e[1;31m"
verde="\e[1;32m"
azul="\e[1;34m"
sinColor="\e[0m"
amNeg="\e[1;33m"
echo -e "${amNeg}######################################"
echo -e "##           DanielCyberSec         ##"
echo -e "######################################$sinColor"
echo -e "nota: ejecutar al nivel de los repositorios git (apoyate del comando pwd)"
echo "Este es tu directorio actual: $(pwd)" 
read -p "Ingresa el directorio base: " base_dir

urls=()
rutas=()
https=false
# Recorre todos los directorios en el directorio base_dir
for dir in "$base_dir"/*; do
        if [ -d "$dir/.git" ]; then
                cd "$dir" || exit
		url=$(git remote get-url origin)
	        protocol=$(echo "$url" | cut -d '@' -f 1 | cut -d ':' -f 1)
		#protocol=$(git remote -v | head -n 1 | awk '{print $2}' | cut -d '@' -f 1 | cut -d ':' -f 1)
		if [ "$protocol" = "git" ]; then
			echo -e "$verde SSH $sinColor"
		elif [ "$protocol" = "https" ]; then
			https=true
			echo -e "$azul HTTPS $sinColor"
			#urls+=($(git remote -v | head -n 1 | awk '{print $2}'))
			urls+=($url)
			rutas+=($dir)
		else
			echo "protocolo inesperado"
		fi
                git remote -v
                # Regresa al directorio base
                cd "$base_dir"
        fi
done
if [ $https = "true" ]; then
	echo -e "\n${amNeg}Se identificaron las siguientes URLs configuradas con ${azul}HTTPS$sinColor:"
	for url in "${urls[@]}"; do
	    echo "$urls"
	done
	echo -e "\n${amNeg}Configurar las URLs de HTTPS a SSH? (si/no): $sinColor"
	read -p "" respuesta
	if [ $respuesta = "si" ]; then
		for i in "${!rutas[@]}"; do
			#echo "${rutas[i]}"
			#echo "${urls[i]}"
			cd "${rutas[i]}" || exit
			pwd
			#git remote set-url origin "$urls[i]" | awk -F'//' '{print "git@" $2}' | sed 's/\//:/'
			url_https="${urls[i]}"
		        # Convertir la URL de HTTPS a SSH
		        url_ssh=$(echo "$url_https" | sed -e 's/^https:\/\/github.com\//git@github.com:/')
		        # Establecer la nueva URL SSH
		        git remote set-url origin "$url_ssh"
		done
		echo -e "${verde}\nRealizado!!$sinColor"
		echo -e "${amNeg}\nvolver a escanear? (si/no)$sinColor"
		read -p "" respuesta2
		if [ $respuesta2 = "si" ]; then 
			for dir in "$base_dir"/*; do
			        if [ -d "$dir/.git" ]; then
			                cd "$dir" || exit
			                url=$(git remote get-url origin)
			                protocol=$(echo "$url" | cut -d '@' -f 1 | cut -d ':' -f 1)
			                #protocol=$(git remote -v | head -n 1 | awk '{print $2}' | cut -d '@' -f 1 | cut -d ':' -f 1)
			                if [ "$protocol" = "git" ]; then
			                        echo -e "$verde SSH $sinColor"
			                elif [ "$protocol" = "https" ]; then
			                        #https=true
			                        echo -e "$azul HTTPS $sinColor"
			                        #urls+=($(git remote -v | head -n 1 | awk '{print $2}'))
			                        urls+=($url)
			                        rutas+=($dir)
			                else
			                        echo "protocolo inesperado"
			                fi
			                git remote -v
			                # Regresa al directorio base
			                cd "$base_dir"
			        fi
			done
		elif [ $respuesta2 = "no" ]; then
        		echo -e "\nFin fel programa"
		else
        		echo -e "\nOpción NO válida"
		fi
	elif [ $respuesta = "no" ]; then
		echo -e "\nFin del programa"
	else
		echo -e "\nOpción NO válida..."
	fi
else
	echo -e "\nFin del programa"
fi
