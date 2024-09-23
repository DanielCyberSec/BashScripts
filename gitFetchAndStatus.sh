#!/bin/bash
#https://github.com/DanielCyberSec/BashScripts.git
rojoNegrita="\e[1;31m"
verde="\e[32m"
sinColor="\e[0m"
amNeg="\e[1;33m"
echo -e "${amNeg}######################################"
echo -e "##           DanielCyberSec         ##"
echo -e "######################################"
echo -e "nota: ejecutar dentro del directorio correspondiente $sinColor"
echo -e "$verde git fetch: $sinColor"
git fetch
echo -e "$verde git status: $sinColor"
git status
