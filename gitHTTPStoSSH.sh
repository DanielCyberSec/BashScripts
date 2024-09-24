#!/bin/bash
rojoNegrita="\e[1;31m"
verde="\e[1;32m"
azul="\e[1;34m"
sinColor="\e[0m"
amNeg="\e[1;33m"

echo -e "${amNeg}######################################"
echo -e "##           DanielCyberSec         ##"
echo -e "######################################$sinColor"

# Directorio base donde buscar los repositorios Git
base_dir="/home/daniel/Documentos"
urls=()
rutas=()

# Recorre todos los directorios en el directorio base
for dir in "$base_dir"/*; do
    if [ -d "$dir/.git" ]; then
        cd "$dir" || exit
        # Obtener la URL del repositorio
        url=$(git remote get-url origin)
        protocol=$(echo "$url" | awk -F'://' '{print $1}')
        
        if [ "$protocol" = "git" ]; then
            echo -e "$verde SSH $sinColor en $dir"
        elif [ "$protocol" = "https" ]; then
            echo -e "$azul HTTPS $sinColor en $dir"
            urls+=("$url")
            rutas+=("$dir")
        else
            echo "Protocolo inesperado en $dir"
        fi
        git remote -v
        # Volver al directorio base
        cd "$base_dir"
    fi
done

# Preguntar si se quiere cambiar las URLs
echo -e "\n${amNeg}Se identificó por lo menos una URL configurada con ${azul}HTTPS $sinColor"
for url in "${urls[@]}"; do
    echo "$url"
done

echo -e "\n${amNeg}¿Configurar las URLs de HTTPS a SSH? (si/no): $sinColor"
read -p "" respuesta

if [ "$respuesta" = "si" ]; then
    for i in "${!rutas[@]}"; do
        cd "${rutas[i]}" || exit
        # Obtener la URL HTTPS actual
        url_https="${urls[i]}"
        # Convertir la URL de HTTPS a SSH
        url_ssh=$(echo "$url_https" | sed -e 's/^https:\/\/github.com\//git@github.com:/')
        
        # Establecer la nueva URL SSH
        git remote set-url origin "$url_ssh"
        
        echo -e "${verde}URL cambiada a: $url_ssh $sinColor en ${rutas[i]}"
    done
    echo -e "${verde}¡Listo!$sinColor"
else
    echo "No se realizaron cambios."
fi
