#!/bin/bash

JAVA_VER=$(java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1)

if [[ $EUID -ne 0 ]]; then
   echo "[!] This script must be run as root." 
   exit 1
elif [ "$JAVA_VER" != "11" ]; then
    echo "[!] OpenJDK 11 not installed."
    exit 1
fi

echo "[+] Downloading Burp Suite Professional"

wget -q --show-progress -P '/opt' 'http://telury.tech/uploads/BurpSuiteProfessional.tar.gz'

if [ -f "/opt/BurpSuiteProfessional.tar.gz" ]; then
    echo "[+] Downloaded successfully"
    sleep 3
fi

echo "[+] Extracting..."

sleep 3

cd /opt && tar xvzf BurpSuiteProfessional.tar.gz >/dev/null 2>&1

echo "[+] Extracted Successfully"

cd /opt/BurpSuiteProfessional && chmod +x *

cp '/opt/BurpSuiteProfessional/Burp Suite Professional.desktop' /usr/share/applications

rm /opt/BurpSuiteProfessional.tar.gz

sleep 3

echo "[+] Running crack file.."

java -jar burploader.jar >/dev/null 2>&1

echo "[+] Successfully Installed"