#!/bin/bash

echo "Clonage du dépôt ShinOS..."
cd ~
git clone https://github.com/mj10281028/shinos-config.git
cd shinos-config

# Détection Raspberry Pi ou PC
if grep -q 'Raspberry' /proc/cpuinfo; then
    echo "Appareil détecté : Raspberry Pi"
    chmod +x install_shinospi.sh
    ./install_shinospi.sh
else
    echo "Appareil détecté : PC standard"
    chmod +x install_shinos.sh
    ./install_shinos.sh
fi

echo "✅ Déploiement terminé. Redémarre la machine si nécessaire."
