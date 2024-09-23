#!/bin/bash
#https://github.com/DanielCyberSec/BashScripts.git
rojoNegrita="\e[1;31m"
verde="\e[32m"
sinColor="\e[0m"
amNeg="\e[1;33m"
echo -e "${amNeg}######################################"
echo -e "##        ScanningTools             ##"
echo -e "##        by DanielCyberSec         ##"
echo -e "######################################$sinColor"
echo "git fetch: "
git fetch
echo "git status:"
git status
